{ pkgs, lib, config, ... }:

with lib;
{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    # import your own NixOS modules here if needed
  ];

  config = {
    nixpkgs.overlays = [
	  # define or import overlays here
	  #
	  (self: super: { })
	  # (import ./my-overlay.nix)
    ];

    services.qemuGuest.enable = true;

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      autoResize = true;
    };

    boot = {
      growPartition = true;
      kernelParams = ["console=ttyS0" "boot.shell_on_fail"];
      loader.timeout = 5;
    };

    virtualisation = {
      diskSize = 12000; # MB
      memorySize = 8048; # MB
      writableStoreUseTmpfs = false;
    };

    services.openssh.enable = true;
    services.openssh.permitRootLogin = "yes";
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [22 9200];
    services.opensearch.enable = true;
    services.opensearch.settings = {
      "network.host" = "0.0.0.0";
    };
    # services.nginx.enable = true;
    # services.nomad.enable = true;
    # services.nomad.settings = {
    #     #bind_addr = "0.0.0.0";
    #     ports = {
    #     http = 4646;
    #     rpc = 4647;
    #     serf = 4648;
    #     };

    # # A minimal config example:
    #     server = {
    #     enabled = true;
    #     bootstrap_expect = 1; # for demo; no fault tolerance
    #     };
    #     client = {
    #     enabled = true;
    #     };
    # };
    # services.hydra = {
    #     enable = true;
    #     hydraURL = "http://0.0.0.0:3000"; # externally visible URL
    #     notificationSender = "hydra@localhost"; # e-mail of hydra service
    #     # a standalone hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
    #     buildMachinesFiles = [];
    #     # you will probably also want, otherwise *everything* will be built from scratch
    #     useSubstitutes = true;
    # };
    nix.extraOptions = "experimental-features = nix-command flakes";
    # environment.systemPackages = with pkgs;
    #   [ # some relevant packages here

    #   ];

    # we could alternatively hook root or a custom user
    # to some ssh key pair
    users.extraUsers.root.password = ""; # oops
    users.mutableUsers = false;
  };

}
