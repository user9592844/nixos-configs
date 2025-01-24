{ inputs, pkgs, ... }:

{
  environment.systemPackages = with inputs;
    [ ghostty.packages.x86_64-linux.default ];
}
