deploy host ip='':
  nixos-rebuild switch --fast --flake ".#{{host}}" --use-remote-sudo --target-host "marcocondrache@{{ip}}" --build-host "marcocondrache@{{ip}}"