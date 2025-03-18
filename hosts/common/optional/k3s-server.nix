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
      "--disable=local-storage"
      "--disable=servicelb"
      "--disable=metrics-server"
      "--flannel-backend=none"
      "--disable-network-policy"
      "--disable-kube-proxy"
      "--disable-helm-controller"
      "--embedded-registry"
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
