{
  imports = [
    ./k3s-agent.nix
  ];

  services.k3s = {
    role = "server";
    extraFlags = [
      "--disable=traefik"
      "--disable=coredns"
      "--disable=local-storage"
      "--disable=servicelb"
      "--disable=metrics-server"
      "--disable-network-policy"
      "--disable-kube-proxy"
      "--disable-helm-controller"
      "--flannel-backend=none"

      "--cluster-cidr=10.42.0.0/16"
      "--service-cidr=10.43.0.0/16"
    ];
  };
}
