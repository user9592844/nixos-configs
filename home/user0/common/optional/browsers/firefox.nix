{ pkgs, lib, config, ... }:
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

    profiles.default = {
      search = {
        default = "DuckDuckGo";

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
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontcheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";

      # Declare Extensions
      ExtensionSettings = {
        "*".installation_mode = "blocked";

        "@testpilot-containers" = { # Multi-Account Containers
          install_url =
            "https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search";
          installation_mode = "force_installed";
        };
        "extension@one-tab.com" = { # OneTab
          install_url =
            "https://addons.mozilla.org/en-US/firefox/addon/onetab/";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = { # uBlock Origin
          install_url =
            "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/";
          installation_mode = "force_installed";
        };
      };
      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "extensions.pocket.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =
          lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          lock-false;

        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
          lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

        "privacy.donottrackheader.enabled" = lock-true;
        "privacy.clearSiteData.historyFormDataAndDownloads" = lock-true;
        "privacy.clearSiteData.cache" = lock-true;
        "privacy.clearSiteData.cookiesAndStorage" = lock-true;
        "privacy.clearSiteData.siteSettings" = lock-true;
        "privacy.clearHistory.cache" = lock-true;
        "privacy.clearHistory.cookiesAndStorage" = lock-true;
        "privacy.clearHistory.historyFormDataAndDownloads" = lock-true;
        "privacy.clearHistory.siteSettings" = lock-true;
      };
    };
  };
}
