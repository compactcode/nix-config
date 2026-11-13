{
  delib,
  pkgs,
  ...
}:
delib.module {
  # local speech to text
  name = "programs.voxtype";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.voxtype = {
      enable = true;
      # gpu accelerated, falls back to cpu
      package = pkgs.voxtype-vulkan;
      loadModels = ["base.en"];
      settings = {
        # triggered by a hyprland keybind instead
        hotkey.enabled = false;
        whisper = {
          model = "base.en";
          language = "en";
        };
      };
    };
  };
}
