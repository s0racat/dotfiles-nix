{ stable, ... }:
{
  programs.bat = {
    enable = true;
    extraPackages = with stable.pkgs.bat-extras; [
      (batman.overrideAttrs (oldAttrs: {
        installPhase = ''
          ${oldAttrs.installPhase}

          wrapProgram $out/bin/batman \
            --set BAT_THEME OneHalfDark
        '';
      }))
      batgrep
    ];
    config = {
      theme = "Nord";
      wrap = "never";
    };
  };

}
