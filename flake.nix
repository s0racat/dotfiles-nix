{
  description = "dotfiles";
  inputs = {
    nixpkgs-stable-small.url = "github:NixOS/nixpkgs/nixos-25.11-small";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      # neovimUtils.makeVimPackageInfo not found https://github.com/nix-community/home-manager/commit/3c71ea724c54b29a8f62e2b965caafca863fa3a2
      url = "github:nix-community/home-manager/63a87808f5f9b6e4195a1d33f6ea25d23f4aa0d";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.3";
    #   # Optional but recommended to limit the size of your system closure.
    #   inputs.nixpkgs.follows = "nixpkgs-stable";
    #   # inputs.pre-commit-hooks-nix.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    # };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # Quickly locate nix packages with specific files
    # $ nix-locate 'bin/hello'
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      treefmt-nix,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs-unstable.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs-unstable {
          inherit system;
          overlays = self.overlays.default;
          config.allowUnfree = true;
        }
      );
      util = import ./lib/util.nix { inherit inputs nixpkgsFor; };
    in
    {
      overlays.default = [
        (import ./overlays { inherit self inputs; })
      ];

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          alejandra = {
            type = "app";
            program =
              (pkgs.writeShellScript "alejandra" ''
                ${pkgs.alejandra}/bin/alejandra -e ./_sources .
              '').outPath;
          };
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
        })
        (util.mkHome {
          name = "takumi@takumi-Venus-series";
          extraModules = [ ./home-manager/desktop ];
          av1Support = true;
        })
      ];
    };
}
