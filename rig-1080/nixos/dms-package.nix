# Use the DMS package built from the flake branch (1.7-beta+) instead of the
# NixOS module's pinned 1.4.6 release. Needed because 1.4.x speaks the old
# Hyprland dispatch syntax, which Lua-config Hyprland (>= 0.55) rejects —
# workspace clicks in the bar/overview silently fail. Remove once the module's
# default release ships Lua-Hyprland support.
{ inputs, pkgs, ... }:

{
  programs.dms-shell.package =
    inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
}
