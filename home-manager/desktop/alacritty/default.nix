{ pkgs,...}:
{
  xdg.configFile = {
    "alacritty/alacritty.toml".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/s0racat/dotfiles-old/41504838db900c35c0003198aafd0099f3d50696/home/dot_config/alacritty/alacritty.toml";
      hash = "sha256-fOs7mbL/oMRVPOxAwOdMWHAE5iFjTbowz3ISYtMOD0o=";
    };
    "alacritty/nord.toml".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/s0racat/dotfiles-old/41504838db900c35c0003198aafd0099f3d50696/home/dot_config/alacritty/nord.toml";
      hash = "sha256-jhQjxrgJ2purqfLTdE4vRi5Wbl5wHsLWA3xFTZmKHVA=";
    };
  };
}
