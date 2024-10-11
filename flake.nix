{
  description = "NixOS configurations for multiple machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
        with myConfig.configurations;
          tower = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
              ./configuration/tower.nix
              ];
          };

          laptop = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
              ./configuration/laptop.nix
              ];
          };

          agent = nixpkgs.lib.nixosSystem {
              system = builtins.currentSystem;
              specialArgs = {meta = {"node"}; };
              modules = [./configuration/node.nix];
          };

          server = nixpkgs.lib.nixosSystem {
              system = builtins.currentSystem;
              specialArgs = {meta = {"server"} ; };
              modules = [./configuration/node.nix]
          };
    };
  };
}
