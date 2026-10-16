{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apfs;

  inherit (lib)
    concatMapStrings
    concatStringsSep
    escapeShellArg
    escapeShellArgs
    mkOption
    optionalString
    optionals
    types
    ;

  diskutil = "/usr/sbin/diskutil";
  plutil = "/usr/bin/plutil";
  cmp = "/usr/bin/cmp";
  jq = lib.getExe pkgs.jq;

  marker = "# nix-darwin apfs.volumes";
  syntheticFile = "/etc/synthetic.d/nix-darwin-apfs-volumes";

  volumes = lib.attrValues cfg.volumes;

  # Top-level mount points can only exist on the read-only root through synthetic.conf(5).
  syntheticEntries = map (volume: lib.removePrefix "/" volume.mountPoint) (
    lib.filter (
      volume: volume.mountPoint != null && builtins.match "/[^/]+" volume.mountPoint != null
    ) volumes
  );

  container =
    volume: if volume.container == null then ''"$rootContainer"'' else escapeShellArg volume.container;

  findDevice = volume: "device=$(apfsVolumeDevice ${container volume} ${escapeShellArg volume.name})";

  createVolume =
    volume:
    let
      args = [
        (if volume.caseSensitive then "APFSX" else "APFS")
        volume.name
      ]
      ++ optionals (volume.quota != null) [
        "-quota"
        volume.quota
      ]
      ++ optionals (volume.reserve != null) [
        "-reserve"
        volume.reserve
      ]
      ++ [ "-nomount" ];
    in
    ''
      ${findDevice volume}
      if [[ -z $device ]]; then
        printf >&2 'creating APFS volume %s...\n' ${escapeShellArg volume.name}
        ${diskutil} apfs addVolume ${container volume} ${escapeShellArgs args} >/dev/null
        ${findDevice volume}
      fi
    ''
    + optionalString (volume.mountPoint != null) ''
      printf 'UUID=%s %s apfs %s ${marker}\n' "$(apfsVolumeInfo "$device" VolumeUUID)" ${
        escapeShellArgs [
          volume.mountPoint
          (concatStringsSep "," volume.mountOptions)
        ]
      } >> "$fstab"
    '';

  mountVolume =
    volume:
    let
      ownership =
        optionalString (volume.owner != null) volume.owner
        + optionalString (volume.group != null) ":${volume.group}";
    in
    ''
      ${findDevice volume}
    ''
    + (
      if volume.mountPoint == null then
        ''
          [[ -n $(apfsVolumeInfo "$device" MountPoint) ]] || ${diskutil} mount "$device" >/dev/null
        ''
      else
        ''
          apfsVolumeMount "$device" ${
            escapeShellArgs [
              volume.mountPoint
              (concatStringsSep "," volume.mountOptions)
            ]
          }
        ''
    )
    + optionalString (ownership != "") ''
      mountPoint=$(apfsVolumeInfo "$device" MountPoint)
      [[ -z $mountPoint ]] || chown ${escapeShellArg ownership} "$mountPoint"
    '';

  volumeModule =
    { name, ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          default = name;
          description = "Name of the volume. Existing volumes are matched by this name.";
        };

        container = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "disk3";
          description = ''
            Disk identifier of the APFS container holding the volume.
            Defaults to the container of the boot volume.
          '';
        };

        caseSensitive = mkOption {
          type = types.bool;
          default = false;
          description = "Whether the volume is case-sensitive. Only applied when the volume is created.";
        };

        quota = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "100g";
          description = "Maximum size of the volume. Only applied when the volume is created.";
        };

        reserve = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "10g";
          description = "Space guaranteed to the volume. Only applied when the volume is created.";
        };

        mountPoint = mkOption {
          type = types.nullOr (types.strMatching "/[^[:space:]]*[^/[:space:]]");
          default = null;
          example = "/Users/alice/Developer";
          description = ''
            Where to mount the volume, through an `/etc/fstab` entry. Top-level
            paths are created through `/etc/synthetic.d`, which may need a reboot.
            Defaults to `/Volumes/<name>`.
          '';
        };

        mountOptions = mkOption {
          type = types.nonEmptyListOf types.str;
          default = [
            "rw"
            "nobrowse"
          ];
          description = "Options used to mount the volume. Only used when `mountPoint` is set.";
        };

        owner = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "User owning the root of the volume.";
        };

        group = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Group owning the root of the volume.";
        };
      };
    };
in
{
  options.apfs.volumes = mkOption {
    type = types.attrsOf (types.submodule volumeModule);
    default = { };
    example = lib.literalExpression ''
      {
        Developer = {
          caseSensitive = true;
          mountPoint = "/Users/alice/Developer";
          owner = "alice";
        };
      }
    '';
    description = ''
      APFS volumes to create and mount. Volumes removed from this set are kept
      on disk, only their mount configuration is removed.
    '';
  };

  config.system.activationScripts.extraActivation.text =
    optionalString (volumes != [ ]) ''
      echo "setting up APFS volumes..." >&2

      apfsVolumeDevice() {
        ${diskutil} apfs list -plist "$1" | ${plutil} -convert json -o - - \
          | ${jq} -r --arg name "$2" 'first(.Containers[].Volumes[] | select(.Name == $name) | .DeviceIdentifier)'
      }

      apfsVolumeInfo() {
        ${diskutil} info -plist "$1" | ${plutil} -extract "$2" raw - 2>/dev/null || true
      }

      apfsVolumeMount() {
        local device=$1 mountPoint=$2 options=$3 current
        current=$(apfsVolumeInfo "$device" MountPoint)
        [[ $current != "$mountPoint" ]] || return 0

        if ! mkdir -p "$mountPoint" 2>/dev/null; then
          printf >&2 '\e[1;33mwarning: %s does not exist yet, reboot to mount %s there\e[0m\n' "$mountPoint" "$device"
          return 0
        fi

        [[ -z $current ]] || ${diskutil} unmount "$device" >/dev/null
        ${diskutil} mount -mountOptions "$options" -mountPoint "$mountPoint" "$device" >/dev/null
      }

      rootContainer=$(apfsVolumeInfo / APFSContainerReference)
    ''
    + ''
      fstab=$(mktemp)
      grep -vF ${escapeShellArg marker} /etc/fstab > "$fstab" 2>/dev/null || true
    ''
    + concatMapStrings createVolume volumes
    + ''
      if ! ${cmp} -s "$fstab" /etc/fstab && [[ -s $fstab || -e /etc/fstab ]]; then
        echo "updating /etc/fstab..." >&2
        cat "$fstab" > /etc/fstab
      fi
      rm "$fstab"
    ''
    + (
      if syntheticEntries == [ ] then
        ''
          rm -f ${syntheticFile}
        ''
      else
        ''
          if ! printf '%s\n' ${escapeShellArgs syntheticEntries} | ${cmp} -s - ${syntheticFile}; then
            echo "setting up mount points in /etc/synthetic.d..." >&2
            mkdir -p /etc/synthetic.d
            printf '%s\n' ${escapeShellArgs syntheticEntries} > ${syntheticFile}
            /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t || true
          fi
        ''
    )
    + concatMapStrings mountVolume volumes;
}
