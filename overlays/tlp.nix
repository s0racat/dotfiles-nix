# https://github.com/NixOS/nixpkgs/issues/349759
final: prev: {
  tlp = prev.tlp.overrideAttrs (old: {
    makeFlags = (old.makeFlags or [ ]) ++ [
      "TLP_SYSD=/lib/systemd/system"
    ];
  });
}
