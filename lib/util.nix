{
  inputs,
  nixpkgsFor,
  ...
}:
let

  inherit (inputs)
    nixpkgs-unstable
    home-manager
    self
    nix-darwin
    nix-index-database
    ;
in
{
  mkHome =
    {
      name,
      system ? "x86_64-linux",
      extraSpecialArgs ? { },
      isNixOS ? false,
      extraModules ? [ ],
      av1Support ? false,
    }:
    let
      splittedName = nixpkgs-unstable.lib.splitString "@" name;
      username = builtins.elemAt splittedName 0;
    in
    {
      inherit name;
      value = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgsFor.${system};
        extraSpecialArgs = extraSpecialArgs // {
          inherit
            isNixOS
            av1Support
            inputs
            self
            ;
        };
        # https://github.com/nix-community/home-manager/issues/5649
        # backupFileExtension = backupFileExt;
        modules = [
          nix-index-database.homeModules.nix-index
          (
            { pkgs, ... }:
            rec {
              home.username = username;
              home.homeDirectory = "/home/${home.username}";
              home.stateVersion = "25.05";
              nix.package = pkgs.nix;
              programs.home-manager.enable = true;
            }
          )
        ]
        ++ extraModules;
      };
    };

  mkSystem =
    {
      name,
      username ? "takumi",
      system ? "x86_64-linux",
      specialArgs ? { },
      extraSpecialArgs ? { },
      isNixOS ? true,
      extraModules ? [ ],
      av1Support ? false,
    }:
    let
      splittedSystem = nixpkgs-unstable.lib.splitString "-" system;
      os = builtins.elemAt splittedSystem 1;
      systemConfig =
        if os == "darwin" then nix-darwin.lib.darwinSystem else nixpkgs-unstable.lib.nixosSystem;
      hmModules =
        if os == "darwin" then
          [
            home-manager.darwinModules.home-manager
            nix-index-database.darwinModules.nix-index
          ]
        else
          [
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
          ];
    in
    {
      inherit name;
      value = systemConfig {
        pkgs = nixpkgsFor.${system};
        specialArgs = specialArgs // {
          inherit
            username
            inputs
            self
            ;
        };
        modules = [
          "${self}/hosts/${name}.nix"
          {
            networking.hostName = name;
            home-manager = {
              backupFileExtension = "hmbak";
              # use flake's nixpkgs settings.
              useGlobalPkgs = true;

              extraSpecialArgs = extraSpecialArgs // {
                inherit
                  isNixOS
                  av1Support
                  inputs
                  self
                  ;
              };
            };
          }
        ]
        ++ hmModules
        ++ extraModules;
      };
    };
}
