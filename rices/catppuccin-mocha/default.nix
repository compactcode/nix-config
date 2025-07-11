{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.rice {
  name = "catppuccin-mocha";

  darwin = {
    imports = [inputs.stylix.darwinModules.stylix];

    stylix = {
      enable = true;

      autoEnable = false;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      fonts = {
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        monospace = {
          package = pkgs.nerd-fonts.sauce-code-pro;
          name = "Sauce Code Pro Nerd Font";
        };

        sansSerif = {
          package = pkgs.rubik;
          name = "Rubik";
        };

        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
      };

      # dark mode
      polarity = "dark";
    };
  };

  home = {
    stylix.targets = {
      bat.enable = true;
      btop.enable = true;
      kitty.enable = true;
      swaylock.enable = true;
    };
  };

  nixos = {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;

      autoEnable = false;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      fonts = {
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        monospace = {
          package = pkgs.nerd-fonts.sauce-code-pro;
          name = "Sauce Code Pro Nerd Font";
        };

        sansSerif = {
          package = pkgs.rubik;
          name = "Rubik";
        };

        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
      };

      # dark mode
      polarity = "dark";

      targets = {
        console.enable = true;
      };
    };
  };
}
