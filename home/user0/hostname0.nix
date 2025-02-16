{ configVars, ... }:

{
  imports = [
    # Required configs
    common/core

    # Optional configs
    common/optional/browsers/firefox.nix
    common/optional/dev/vscode.nix
    common/optional/terminal/zellij.nix
    common/optional/sops.nix
  ];

  home = {
    inherit (configVars) username;
    homeDirectory = "/home/${configVars.username}";
  };
}
