{
  description = "dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
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
  };

  outputs =
    {
      self,
      nixpkgs,
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
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
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
          hm-switch = {
            type = "app";
            program =
              (pkgs.writeShellScript "hm-script" ''
                ${util.hm pkgs}/bin/home-manager switch --flake .#''${1:-takumi@debian-wsl}
              '').outPath;
          };
          alejandra = {
            type = "app";
            program =
              (pkgs.writeShellScript "alejandra" ''
                ${pkgs.alejandra}/bin/alejandra -e ./_sources .
              '').outPath;
          };

          default = self.apps.${system}.hm-switch;
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
          name = "takumi@debian-wsl";
          extraModules = [ ./home-manager/console-wsl ];
        })
      ];
    };
}
