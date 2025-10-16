{ lib, ... }:
{
  programs.starship = {
    enableZshIntegration = false;
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$status"
        "$nix_shell"
        "$python"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      cmd_duration = {

        format = "took [$duration](yellow) ";
      };

      status = {
        disabled = false;
        format = "[exit: $status](bold yellow) ";
      };
      character = {
        #   success_symbol = "😼";
        #   error_symbol = "😿";
        success_symbol = "%";
        error_symbol = "%";
      };
    };
  };
}
