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
      formatter.${system} = pkgs.nixfmt-rfc-style;

      apps.${system} =
        let
          home = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "home-script" ''
                set -e
                echo "Updating flake..."
                nix flake update
                echo "Rebuilding home-manager..."
                home-manager switch --impure -b hmbak --flake .#''${1:-console-wsl}
                echo "home-manager Rebuild complete!"
              ''
            );
          };
        in
        {
          default = home;
          inherit home;
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
        "um690pro" = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./machines/um690pro.nix
          ];
        };
      };

      homeConfigurations = {
        console = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./home-manager/console
          ];
        };

        console-wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./home-manager/console-wsl
          ];
        };

        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./home-manager/desktop
          ];
        };

      };
    };
}
