# https://github.com/kawarimidoll/dotfiles/blob/master/flake.nix
# https://zenn.dev/kawarimidoll/articles/9c44ce8b60726f

{
  description = "dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./overlays/chromium.nix)
        ];
      };
      sources = pkgs.callPackage ./_sources/generated.nix { };
      username = "takumi";
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      nixosConfigurations = {
        "${username}@um690pro" = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs username;
          };
          modules = [
            ./hosts/um690pro.nix
            home-manager.nixosModules.home-manager
            ./nixos/home-manager.nix
            {
              home-manager.extraSpecialArgs = {
                inherit sources;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "${username}@debian-wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs sources;
          };
          modules = [
            ./home-manager/console-wsl
            rec {
              home.username = username;
              home.homeDirectory = "/home/${home.username}";
              home.stateVersion = "24.05"; # Please read the comment before changing.
              programs.home-manager.enable = true;
            }
          ];
        };
      };
    };
}
