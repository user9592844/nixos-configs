{ inputs, pkgs, lib, config, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;

    profiles.user0 = {
      isDefault = true;
      search = {
        default = "ddg";
        force = true;

        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";

              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template =
                "https://wiki.nixos.org/index.php?search={searchTerms}";
            }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };
        };
      };

      bookmarks = {
        force = true;
        settings = [{
          name = "NixOS Bookmarks Toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "Nix Packages";
              url = "https://search.nixos.org";
            }
            {
              name = "NixOS Wiki";
              url = "https://wiki.nixos.org";
            }
            {
              name = "LoFi Synthwave";
              url = "https://www.youtube.com/watch?v=4xDzrJKXOOY";
            }
          ];
        }];
      };

      # Grab the latest XPI and build the extension
      extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          multi-account-containers
          downthemall
          single-file
          user-agent-string-switcher
          image-search-options
          search-by-image
          copy-selected-links

          # Not found
          # bulk-media-downloader
          # fireshot
          # nimbus
          # resurrect-pages
          # view-page-archive

          # allowUnfree needed
          # video-downloadhelper
          # onetab
        ];
    };
  };
}
