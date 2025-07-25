# Based on the official catppuccin themes https://github.com/yazi-rs/themes
{ mkTarget, lib, ... }:
mkTarget {
  name = "yazi";
  humanName = "Yazi";

  extraOptions = {
    boldDirectory = lib.mkOption {
      description = "Whether to use bold font for directories.";
      type = lib.types.bool;
      default = true;
    };
  };

  configElements =
    { cfg, colors }:
    {
      programs.yazi.theme =
        with colors.withHashtag;
        let
          mkFg = fg: { inherit fg; };
          mkBg = bg: { inherit bg; };
          mkBoth = fg: bg: { inherit fg bg; };
          mkSame = c: (mkBoth c c);
        in
        {
          mgr = rec {
            # Reusing bat themes, since it's suggested in the stying guide
            # https://yazi-rs.github.io/docs/configuration/theme#mgr
            syntect_theme = colors {
              template = ../bat/base16-stylix.tmTheme.mustache;
              extension = ".tmTheme";
            };

            cwd = mkFg cyan;
            hovered = (mkBg base02) // {
              bold = true;
            };
            preview_hovered = hovered;
            find_keyword = (mkFg green) // {
              bold = true;
            };
            find_position = mkFg magenta;
            marker_selected = mkSame yellow;
            marker_copied = mkSame green;
            marker_cut = mkSame red;
            border_style = mkFg base04;

            count_copied = mkBoth base00 green;
            count_cut = mkBoth base00 red;
            count_selected = mkBoth base00 yellow;
          };

          tabs = {
            active = (mkBoth base00 blue) // {
              bold = true;
            };
            inactive = mkBoth blue base01;
          };

          mode = {
            normal_main = (mkBoth base00 blue) // {
              bold = true;
            };
            normal_alt = mkBoth blue base00;
            select_main = (mkBoth base00 green) // {
              bold = true;
            };
            select_alt = mkBoth green base00;
            unset_main = (mkBoth base00 brown) // {
              bold = true;
            };
            unset_alt = mkBoth brown base00;
          };

          status = {
            progress_label = mkBoth base05 base00;
            progress_normal = mkBoth base05 base00;
            progress_error = mkBoth red base00;
            perm_type = mkFg blue;
            perm_read = mkFg yellow;
            perm_write = mkFg red;
            perm_exec = mkFg green;
            perm_sep = mkFg cyan;
          };

          pick = {
            border = mkFg blue;
            active = mkFg magenta;
            inactive = mkFg base05;
          };

          input = {
            border = mkFg blue;
            title = mkFg base05;
            value = mkFg base05;
            selected = mkBg base03;
          };

          completion = {
            border = mkFg blue;
            active = mkBoth magenta base03;
            inactive = mkFg base05;
          };

          tasks = {
            border = mkFg blue;
            title = mkFg base05;
            hovered = mkBoth base05 base03;
          };

          which = {
            mask = mkBg base02;
            cand = mkFg cyan;
            rest = mkFg brown;
            desc = mkFg base05;
            separator_style = mkFg base04;
          };

          help = {
            on = mkFg magenta;
            run = mkFg cyan;
            desc = mkFg base05;
            hovered = mkBoth base05 base03;
            footer = mkFg base05;
          };

          # https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/theme.toml
          filetype.rules =
            let
              mkRule = mime: fg: { inherit mime fg; };
            in
            [
              (mkRule "image/*" cyan)
              (mkRule "video/*" yellow)
              (mkRule "audio/*" yellow)

              (mkRule "application/zip" magenta)
              (mkRule "application/gzip" magenta)
              (mkRule "application/tar" magenta)
              (mkRule "application/bzip" magenta)
              (mkRule "application/bzip2" magenta)
              (mkRule "application/7z-compressed" magenta)
              (mkRule "application/rar" magenta)
              (mkRule "application/xz" magenta)

              (mkRule "application/doc" green)
              (mkRule "application/pdf" green)
              (mkRule "application/rtf" green)
              (mkRule "application/vnd.*" green)

              ((mkRule "inode/directory" blue) // { bold = cfg.boldDirectory; })
              (mkRule "*" base05)
            ];
        };
    };
}
