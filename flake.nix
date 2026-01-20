{
  description = "dotfiles";
  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager = {
      # neovimUtils.makeVimPackageInfo not found https://github.com/nix-community/home-manager/commit/3c71ea724c54b29a8f62e2b965caafca863fa3a2
      url = "github:nix-community/home-manager/d21bee5abf9fb4a42b2fa7728bf671f8bb246ba6";
      inputs.nixpkgs.follows = "nixpkgs-stable";
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
      inputs.nixpkgs.follows = "nixpkgs-stable";
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
      nixpkgs-stable,
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
      forAllSystems = nixpkgs-stable.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs-stable {
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
