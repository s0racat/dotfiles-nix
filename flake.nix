{
  description = "dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Quickly locate nix packages with specific files
    # $ nix-locate 'bin/hello'
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-unstable.url = "nixpkgs/nixos-unstable-small";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      nixos-unstable,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = self.overlays.default;
          config.allowUnfree = true;
        }
      );
      nixpkgsMiniFor = forAllSystems (
        system:
        import nixos-unstable {
          inherit system;
          overlays = self.overlays.default;
          config.allowUnfree = true;
        }
      );
      util = import ./lib/util.nix { inherit inputs nixpkgsFor; };
    in
    {
      overlays.default = [
        (import ./overlays { inherit self; })
      ];

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          hm = {
            type = "app";
            program =
              (pkgs.writeShellScript "hm" ''
                profile="''${HM:-$(whoami)@$(hostname)}"
                ${util.hm pkgs}/bin/home-manager switch --flake .#''${profile}
              '').outPath;
          };
          alejandra = {
            type = "app";
            program =
              (pkgs.writeShellScript "alejandra" ''
                ${pkgs.alejandra}/bin/alejandra -e ./_sources .
              '').outPath;
          };

          default = self.apps.${system}.hm;
        }
      );

      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper
      );

      nixosConfigurations = builtins.listToAttrs [
        (util.mkSystem { name = "um690pro"; })
      ];

      homeConfigurations = builtins.listToAttrs [
        (util.mkHome {
          name = "takumi@sub-laptop";
          extraModules = [ ./home-manager/console-wsl ];
          pkgs = nixpkgsMiniFor."x86_64-linux";
        })
        (util.mkHome {
          name = "takumi@takumi-Venus-series";
          extraModules = [ ./home-manager/desktop ];
          av1Support = true;
          pkgs = nixpkgsMiniFor."x86_64-linux";
        })
      ];
    };
}
