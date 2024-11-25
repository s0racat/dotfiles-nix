# https://github.com/kawarimidoll/dotfiles/blob/master/flake.nix
# https://zenn.dev/kawarimidoll/articles/9c44ce8b60726f
# username is defined in flake.nix

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
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [ (import ./overlays) ];
        inherit system;
        config.allowUnfree = true;
      };
      sources = pkgs.callPackage ./_sources/generated.nix { };
      username = "takumi";
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      isNixOS = true;
    in
    {
      # for `nix fmt`
      apps.${system} =
        let
          hm-switch =
            let
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
        in
        {
          inherit hm-switch;
          default = hm-switch;
        };
      formatter.${system} = treefmtEval.config.build.wrapper;
      nixosConfigurations = {
        "um690pro" =
          let
            stateVersion = "25.05";
          in
          nixpkgs.lib.nixosSystem {
            inherit pkgs;
            specialArgs = {
              inherit inputs username stateVersion;
            };
            modules = [
              ./hosts/um690pro.nix
              home-manager.nixosModules.home-manager
              ./nixos/home-manager.nix
              {
                home-manager.extraSpecialArgs = {
                  inherit
                    inputs
                    isNixOS
                    sources
                    stateVersion
                    ;
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
            isNixOS = false;
          };
          modules = [
            ./home-manager/console-wsl
            (
              { pkgs, ... }:
              rec {
                home.username = username;
                home.homeDirectory = "/home/${home.username}";
                home.stateVersion = "25.05";
                programs.home-manager.enable = true;
                nix.package = pkgs.nix;
              }
            )
          ];
        };
      };
    };
}
