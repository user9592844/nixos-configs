{ lib, ... }: {
  services.ollama = {
    enable = true;

    loadModels = [ "gemma3:1b" "deepseek-r1:1.5b" ];

    acceleration = false;
  };
}
