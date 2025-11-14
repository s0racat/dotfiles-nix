{ pkgs, ... }:
let
  theme = "OneHalfDark";
in
{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.stable.bat-extras; [
      (batman.overrideAttrs (oldAttrs: {
        installPhase = ''
          ${oldAttrs.installPhase}

          wrapProgram $out/bin/batman \
            --set BAT_THEME ${theme}
        '';
      }))
      batgrep
    ];
    config = {
      theme = "Nord";
      wrap = "never";
      style = builtins.concatStringsSep "," [ "numbers" "changes" "header-filename"];
    };
  };
  programs.zsh.shellGlobalAliases = {
    "--help" = "--help 2>&1 | bat --language=help --style=plain --theme ${theme}";
  };

}
