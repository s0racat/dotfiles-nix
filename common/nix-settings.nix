{ ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      options = "--delete-older-than 7d";
      automatic = true;
    };
  };
}
