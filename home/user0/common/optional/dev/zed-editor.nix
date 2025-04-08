{ pkgs, lib, config, ... }: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
      "make"
      "html"
      "terraform"
      "latex"
      "zig"
      "fish"
      "blade-runner-2049-theme"
    ];

    userSettings = {
      features.copilot = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      ui_font_size = 16;
      buffer_font_size = 13;

      assistant = {
        enabled = false;
        default_open_ai_model = null;

        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
      };

      hour_format = "hour24";
      auto_update = false;

      lsp = {
        rust-analyzer = { binary = { path_lookup = true; }; };

        nix = { binary = { path_lookup = true; }; };
      };

      theme = {
        mode = "system";
        light = "Blade Runner 2049 Theme";
        dark = "Blade Runner 2049 Theme";
      };
    };
  };
}
