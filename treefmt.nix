{
  # Used to find the project root
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    # alejandra.enable = true;
    shfmt.enable = true;
    # jsonfmt.enable = true;
    stylua.enable = true;
    # python
    black.enable = true;
    # dprint.enable = true;
    taplo.enable = true;
    prettier.enable = true;
  };
  # Override the default settings generated by the above option
  settings.global.excludes = [ "_sources/*" ];
  settings.formatter.shfmt.includes = [ "*/zshrc" ];
  # settings.formatter.dprint.includes = [ "*.toml" ];
}
