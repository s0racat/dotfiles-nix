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
      pkgs = import nixpkgs { inherit system; };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      apps.${system} =
        let
          rebuild-home = {
            type = "app";
            program = builtins.toString (
              pkgs.writeShellScript "home-manager-script" ''
                set -e
                echo "Rebuilding home-manager..."
                nix run nixpkgs#home-manager -- switch --impure -b backup --flake .#console
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
                nix run nixpkgs#home-manager -- switch --impure -b backup --flake .#console
                echo "home-manager Rebuild complete!"
              ''
            );
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
                home.username = "takumi";
                home.homeDirectory = "/home/${config.home.username}";
                imports = [ ./console/default.nix ];
              }
            )
          ];
        };
      };
    };
}
# update:
#   nix run .#update
#
# rebuild-home:
# nix run .#rebuild-home
