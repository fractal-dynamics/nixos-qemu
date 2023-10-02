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
      memorySize = 3048; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
      diskSize = 12000; # MB
    };
  };

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22 9200];
  services.opensearch.enable = true;
  services.opensearch.settings = {
    "network.host" = "0.0.0.0";
  };


  system.stateVersion = "23.05";
}
