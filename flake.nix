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
    treefmt-nix.url = "github:numtide/treefmt-nix";
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
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./overlays/chromium.nix)
        ];
      };
      sources = pkgs.callPackage ./_sources/generated.nix { };
      username = "takumi";
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      # for `nix fmt`
      apps.${system} =
        let
          hm-switch =
            let
              gc-opt = (import ./nixos/nix-gc-options.nix).nix.gc.options;
            in
            {
              type = "app";
              program = toString (
                pkgs.writeShellScript "home-script" ''
                  command -v home-manager &> /dev/null && home-manager switch -b hmbak --flake .#''${1:-thinkbook-g6a-wsl} || 
                  nix run nixpkgs#home-manager switch -- -b hmbak --flake .#''${1:-thinkbook-g6a-wsl}
                  nix-collect-garbage ${gc-opt}
                ''
              );
            };
        in
        {
          default = hm-switch;
        };
      formatter.${system} = treefmtEval.config.build.wrapper;
      nixosConfigurations = {
        "um690pro" = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs username;
          };
          modules = [
            ./hosts/um690pro.nix
            home-manager.nixosModules.home-manager
            ./nixos/home-manager.nix
            {
              home-manager.extraSpecialArgs = {
                inherit sources;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "thinkbook-g6a-wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs sources;
          };
          modules = [
            ./home-manager/console-wsl
            (
              { pkgs, ... }:
              rec {
                home.username = username;
                home.homeDirectory = "/home/${home.username}";
                home.stateVersion = "24.05"; # Please read the comment before changing.
                programs.home-manager.enable = true;
                nix.package = pkgs.nix;
              }
            )
          ];
        };
      };
    };
}
