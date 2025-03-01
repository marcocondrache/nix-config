{
  imports = [
    ./k3s-agent.nix
  ];

  # TODO: find a way to provision node external ip from tailscale
  services.k3s = {
    role = "server";
    extraFlags = [
      "--disable=traefik"
      "--disable=coredns"
      "--disable=servicelb"
      "--flannel-backend=none"
      "--disable-network-policy"
      "--disable-kube-proxy"
    ];
  };

  # services.litestream = {
  #   dbs = [
  #     {
  #       path = "/var/lib/rancher/k3s/server/db/state.db";
  #       replicas = [ ];
  #     }
  #   ];
  # };
}
