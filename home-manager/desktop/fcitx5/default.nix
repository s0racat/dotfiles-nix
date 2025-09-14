# apt: require fcitx5
{ pkgs, ... }:
let
  fcitxEnv = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
in
{
  xdg.configFile = {
    "fcitx5" = {
      source = ./config;
      recursive = true;
      force = true;
    };
    "libskk" = {
      source = ./libskk;
      recursive = true;
    };
  };
  home.sessionVariables = fcitxEnv;
  systemd.user.sessionVariables = fcitxEnv;
  xdg.dataFile = {
    "fcitx5/themes" = {
      source = "${pkgs.fcitx5-nord}/share/fcitx5/themes";
      recursive = true;
    };
  };
  # Decode
  # src=$(nix build nixpkgs#mozc.src --no-link --print-out-paths)
  # nix shell nixpkgs#protobuf --command \
  # protoc --proto_path=$src/src/protocol \
  #        --decode "mozc.config.Config" \
  #        $src/src/protocol/config.proto \
  #        < ~/.config/mozc/config1.db \
  #        > ~/.mozc.config1.txt
  xdg.configFile."mozc/config1.db".source = ./config1.db;
}
