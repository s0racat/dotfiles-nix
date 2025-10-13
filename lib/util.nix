{
  inputs,
  nixpkgsFor,
  ...
}:
let
  backupFileExt = "hmbak";
  hm =
    pkgs:
    pkgs.symlinkJoin {
      name = "home-manager";
      paths = [ pkgs.home-manager ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/home-manager \
        --add-flags "-b ${backupFileExt}"
      '';
    };

  inherit (inputs)
    nixpkgs
    home-manager
    self
    nix-darwin
    nix-index-database
    nixos-unstable
    ;
in
{
  inherit hm;
  mkHome =
    {
      name,
      pkgs,
      extraSpecialArgs ? { },
      isNixOS ? false,
      stateVersion ? "25.05",
      extraModules ? [ ],
      av1Support ? false,
    }:
    let
      splittedName = nixpkgs.lib.splitString "@" name;
      username = builtins.elemAt splittedName 0;
    in
    {
      inherit name;
      value = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
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
              home.stateVersion = stateVersion;
              nix.package = pkgs.nix;
              home.packages = [ (hm pkgs) ];
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
      pkgs,
      specialArgs ? { },
      extraSpecialArgs ? { },
      isNixOS ? true,
      stateVersion ? "25.05",
      extraModules ? [ ],
      av1Support ? false,
    }:
    let
      splittedSystem = nixpkgs.lib.splitString "-" pkgs.system;
      os = builtins.elemAt splittedSystem 1;
      systemConfig = if os == "darwin" then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
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
        inherit pkgs;
        specialArgs = specialArgs // {
          inherit
            username
            stateVersion
            inputs
            self
            ;
        };
        modules = [
          "${self}/hosts/${name}.nix"
          {
            networking.hostName = name;
            home-manager = {
              backupFileExtension = backupFileExt;
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
