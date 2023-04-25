
nix-build '<nixpkgs/nixos>' -A vm --arg configuration ./demo.nix


export QEMU_NET_OPTS="hostfwd=tcp::2221-:22,hostfwd=tcp::8881-:80,hostfwd=tcp::4646-:4646,hostfwd=tcp::3000-:3000"


ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no root@localhost -p 2221
