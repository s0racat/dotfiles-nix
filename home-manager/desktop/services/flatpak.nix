{ lib, isNixOS, ... }:

lib.mkIf (!isNixOS) {
}
