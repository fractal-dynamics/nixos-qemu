
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-build '<nixpkgs/nixos>' -A vm --arg configuration ./demo.nix


export QEMU_NET_OPTS="hostfwd=tcp::2221-:22,hostfwd=tcp::9200-:9200"


ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no root@localhost -p 2221


Flake version


nixos-rebuild build-vm --flake .#test
# expose port 22 from guest
export QEMU_NET_OPTS="hostfwd=tcp::2221-:22"
result/bin/run-nixos-vm
