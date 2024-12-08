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
    ;
in
{
  inherit hm;
  mkHome =
    {
      name,
      system ? "x86_64-linux",
      extraSpecialArgs ? { inherit inputs self; },
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
        # https://github.com/nix-community/home-manager/issues/5649
        # backupFileExtension = backupFileExt;
        modules = [
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
        ] ++ extraModules;
      };
    };

  mkSystem =
    {
      name,
      username ? "takumi",
      system ? "x86_64-linux",
      specialArgs ? { inherit inputs self; },
      extraSpecialArgs ? { inherit inputs self; },
      isNixOS ? true,
      stateVersion ? "25.05",
      extraModules ? [ ],
    }:
    let
      splittedSystem = nixpkgs.lib.splitString "-" system;
      os = builtins.elemAt splittedSystem 1;
      systemConfig = if os == "darwin" then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
      hmModule =
        if os == "darwin" then
          home-manager.darwinModules.home-manager
        else
          home-manager.nixosModules.home-manager;
    in
    {
      inherit name;
      value = systemConfig {
        pkgs = nixpkgsFor.${system};
        specialArgs = specialArgs // {
          inherit username stateVersion;
        };
        modules = [
          "${self}/hosts/${name}.nix"
          hmModule
          {
            networking.hostName = name;
            home-manager = {
              backupFileExtension = backupFileExt;
              # use flake's nixpkgs settings.
              useGlobalPkgs = true;

              extraSpecialArgs = extraSpecialArgs // {
                inherit isNixOS;
              };
            };
          }
        ] ++ extraModules;
      };
    };
}
