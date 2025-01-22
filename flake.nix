{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations."cool" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; 
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
