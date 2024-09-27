{ pkgs, ... }:
{
  programs.firefox = {
    nativeMessagingHosts = [
      pkgs.tridactyl-native
      pkgs.keepassxc
    ];
  };
}
