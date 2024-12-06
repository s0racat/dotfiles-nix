{
  description = "dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
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

      mkHome =
        {
          name,
          system ? "x86_64-linux",
          extraSpecialArgs ? { inherit inputs; },
          isNixOS ? false,
          stateVersion ? "25.05",
          extraModules ? [ ],
        }:
        let
          splittedName = nixpkgs.lib.splitString "@" name;
          username = builtins.elemAt splittedName 0;
        in
        {
          inherit name;
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgsFor.${system};
            extraSpecialArgs = extraSpecialArgs // {
              inherit isNixOS;
            };
            modules = [
              (
                { pkgs, ... }:
                rec {
                  home.username = username;
                  home.homeDirectory = "/home/${home.username}";
                  home.stateVersion = stateVersion;
                  programs.home-manager.enable = true;
                  nix.package = pkgs.nix;
                }
              )
            ] ++ extraModules;
          };
        };

      mkSystem =
        {
          name,
          username ? "takumi",
          system ? "x86_64-linux",
          specialArgs ? { inherit inputs; },
          extraSpecialArgs ? { inherit inputs; },
          isNixOS ? true,
          stateVersion ? "25.05",
          extraModules ? [ ],
        }:
        {
          inherit name;
          value = nixpkgs.lib.nixosSystem {
            pkgs = nixpkgsFor.${system};
            specialArgs = specialArgs // {
              inherit username stateVersion;
            };
            modules = [
              ./hosts/${name}.nix
              home-manager.nixosModules.home-manager
              ./nixos/home-manager.nix
              {
                networking.hostName = name;
                home-manager.extraSpecialArgs = extraSpecialArgs // {
                  inherit isNixOS;
                };
              }
            ] ++ extraModules;
          };
        };
    in

    {

      overlays.default = [
        (import ./overlays)
      ];

      apps = forAllSystems (system: {
        hm-switch =
          let
            pkgs = nixpkgsFor.${system};
            backupFileExt = (import ./nixos/home-manager.nix).home-manager.backupFileExtension;
          in
          {
            type = "app";
            program = toString (
              pkgs.writeShellScript "home-script" ''
                ${pkgs.home-manager}/bin/home-manager switch -b ${backupFileExt} --flake .#''${1:-takumi@debian-wsl}
              ''
            );
          };
        default = self.apps.${system}.hm-switch;
      });

      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper
      );

      nixosConfigurations = builtins.listToAttrs [
        (mkSystem { name = "um690pro"; })
      ];

      homeConfigurations = builtins.listToAttrs [
        (mkHome {
          name = "takumi@debian-wsl";
          extraModules = [ ./home-manager/console-wsl ];
        })
      ];

    };
}
