{
  config,
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
      trusted-users = [
        "@wheel"
        "@sudo"
      ];
    };

    gc = {
      ${frequency} = "weekly";
      automatic = true;
    };
  };
  imports = [
    ./nix-gc-options.nix
  ];
}
