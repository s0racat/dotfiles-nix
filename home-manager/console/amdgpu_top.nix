{ pkgs, ... }:
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "amdgpu_top-dark";
      paths = [ pkgs.amdgpu_top ];

      nativeBuildInputs = [ pkgs.makeWrapper ];

      postBuild = ''
        wrapProgram $out/bin/amdgpu_top --add-flags "--dark"
      '';
    })
  ];
  xdg.dataFile."applications/amdgpu_top.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=AMDGPU TOP (GUI)
    GenericName=AMDGPU Monitoring Tool
    Exec=amdgpu_top --gui
    Categories=System;Monitor;
    Icon=utilities-system-monitor
    Hidden=true
  '';
}
