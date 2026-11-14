{
  delib,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.walker";

  home.ifEnabled.programs.walker = {
    config.theme = "stylix";

    themes.stylix.style = let
      colors = homeconfig.lib.stylix.colors.withHashtag;
    in ''
      @define-color window_bg_color ${colors.base00};
      @define-color accent_bg_color ${colors.base0D};
      @define-color theme_fg_color ${colors.base05};
      @define-color subtle_fg_color ${colors.base03};

      * { all: unset; }

      .box-wrapper {
        background: @window_bg_color;
        border: 2px solid @accent_bg_color;
        border-radius: 12px;
        padding: 12px;
      }

      .input {
        color: @theme_fg_color;
        caret-color: @accent_bg_color;
        padding: 8px 4px;
        border-bottom: 1px solid alpha(@subtle_fg_color, 0.3);
      }

      .input placeholder { color: @subtle_fg_color; }

      .list { color: @theme_fg_color; }

      .item-box {
        border-radius: 8px;
        padding: 8px 10px;
      }

      child:hover .item-box,
      child:selected .item-box {
        background: alpha(@accent_bg_color, 0.2);
      }

      .item-subtext { font-size: 11px; color: @subtle_fg_color; }
      .item-image { margin-right: 8px; }
      .normal-icons { -gtk-icon-size: 16px; }
      .large-icons { -gtk-icon-size: 28px; }

      .keybind-hints { color: @subtle_fg_color; }
      scrollbar { opacity: 0; }

      .preview {
        border: 1px solid alpha(@accent_bg_color, 0.2);
        border-radius: 8px;
        padding: 8px;
        color: @theme_fg_color;
      }
    '';
  };
}
