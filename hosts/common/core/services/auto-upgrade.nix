{ config, inputs, pkgs, lib, ... }:
let
  inherit (config.networking) hostName;
  isClean = inputs.self ? rev;
in {
  system.autoUpgrade = {
    enable = isClean;
    allowReboot = true;
    dates = "hourly";
    flags = [ "--refresh" ];
    flake = "git://github.com/user9592844/nixos-config?ref=release-${hostName}";
  };

  systemd.services.nixos-upgrade = lib.mkIf config.system.autoUpgrade.enable {
    serviceConfig.ExecCondition = lib.getExe
      (pkgs.writeShellScriptBin "check-date" ''
        lastModified() {
          nix flake metadata "$1" --refresh --json | ${
            lib.getExe pkgs.jq
          } '.lastModified'
        }
        test "$(lastModified "${config.system.autoUpgrade.flake}")" - gt "$(lastModified "self")"
      '');
  };
}
