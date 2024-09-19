# https://github.com/kawarimidoll/dotfiles/blob/master/flake.nix
# https://zenn.dev/kawarimidoll/articles/9c44ce8b60726f

{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
      };
    in
    {
      # Accessible through 'nix build', 'nix shell', etc
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      apps.${system} =
        let
          rebuild-home = {
            type = "app";
            program = builtins.toString (
              pkgs.writeShellScript "home-manager-script" ''
                set -e
                echo "Rebuilding home-manager..."
                home-manager switch --impure -b backup --flake .#console
                echo "home-manager Rebuild complete!"
              ''
            );
          };
        in
        {
          default = rebuild-home;
          inherit rebuild-home;
          update = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "update-script" ''
                set -e
                echo "Updating flake..."
                nix flake update
                echo "Rebuilding home-manager..."
                home-manager switch --impure -b backup --flake .#console
                echo "home-manager Rebuild complete!"
              ''
            );
          };
          clean = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "clean-script" ''
                set -e
                echo "Running \`nix-collect-garbage -d\`..."
                nix-collect-garbage -d
                echo "nix gc complete!"
              ''
            );
          };

        };

      nixosConfigurations = {
        "alice@um690pro" = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
	  ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = {
                imports = [
                  ./home-manager/console/default.nix
                  ./home-manager/desktop/default.nix
                ];
              };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
          specialArgs = {
            inherit inputs; # `inputs = inputs;`と等しい
          };
        };
      };
      homeConfigurations = {
        console = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            (
              { config, ... }:
              {
                home.username = "alice";
                home.homeDirectory = "/home/${config.home.username}";
                imports = [
                  ./home-manager/console/default.nix
                ];
              }
            )
          ];
        };
        console-wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            (
              { config, ... }:
              {
                home.username = "alice";
                home.homeDirectory = "/home/${config.home.username}";
                imports = [
                  ./home-manager/console/default.nix
                  ./home-manager/console/tmux/shell.nix
                  ./home-manager/console/wsl.nix
                  ./home-manager/console/nix/default.nix
                ];
              }
            )
          ];
        };
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            (
              { config, ... }:
              {
                home.username = "alice";
                home.homeDirectory = "/home/${config.home.username}";
                imports = [
                  ./home-manager/console/default.nix
                  ./home-manager/desktop/default.nix
                ];
              }
            )
          ];
        };
      };
    };
}
# default:
#   nix run .
#
# update:
#   nix run .#update
#
# rebuild-home:
#   nix run .#rebuild-home
#
# clean:
#   nix run .#clean
