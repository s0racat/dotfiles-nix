{
  config,
  inputs,
  ...
}:
let
  frequency = if config.nix.gc ? "dates" then "dates" else "frequency";
in
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
      ${frequency} = "weekly";
      options = "--delete-older-than 7d";

      automatic = true;
    };
  };

}
