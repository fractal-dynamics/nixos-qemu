{ config, lib, pkgs, ... }: {
  # customize kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_3;

  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "admin";
      group = "admin";
    };
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # services.nginx = {
  #   enable = true;
  #   virtualHosts."localhost" = {
  #     listen = [ { addr = "0.0.0.0"; port = 8088; } ];
  #     extraConfig = ''
  #         location / {
  #             auth_request /auth;
  #             proxy_pass http://<apache-gitolite>;
  #         }

  #         location = /auth {
  #             #internal;
  #             proxy_pass http://localhost:5000/validate-token;
  #             proxy_pass_request_body off;
  #             proxy_set_header Content-Length "";
  #             proxy_set_header X-Original-URI $request_uri;
  #         }

  #     '';
  #   };
  # };


  networking.firewall.allowedTCPPorts = [ 22 80 8088 ];
  environment.systemPackages = with pkgs; [
    htop
  ];
  nix.settings.extra-trusted-substituters = [ "https://cache.floxdev.com" ];
  nix.settings.extra-trusted-public-keys = [ "flox-store-public-0:8c/B+kjIaQ+BloCmNkRUKwaVPFWkriSAd0JJvuDu4F0="];
  system.stateVersion = "23.05";
}
