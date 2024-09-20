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
      username = "alice";
    in
    {
      # Accessible through 'nix build', 'nix shell', etc
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
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
                                home-manager switch --impure -b backup --flake .#''${1:-console-wsl}
                                echo "home-manager Rebuild complete!"
              ''
            );
          };
        in
        {
          default = home;
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

      homeConfigurations = {
        console = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs username;
          };
          modules = [
	  ./home-manager/console
          ];
        };
        console-wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs username;
          };
          modules = [
	  ./home-manager/console-wsl
          ];
        };
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs username;
          };
          modules = [
	  ./home-manager/desktop
          ];
        };
      };
    };
}
