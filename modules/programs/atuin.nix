{delib, ...}:
delib.module {
  # shell history database
  name = "programs.atuin";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.atuin = {
      enable = true;
      settings = {
        # search bar at the top
        invert = true;
        # display results inline instead of fullscreen.
        inline_height = 25;
        # simplify the ui
        style = "compact";
      };
    };
  };
}
