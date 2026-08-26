{
  config,
  lib,
  matugenAbsPath,
  ...
}: let
  base = ''
    @define-color accent_color {{colors.primary.default.hex}};
    @define-color accent_bg_color {{colors.primary.default.hex}};
    @define-color accent_fg_color {{colors.on_primary.default.hex}};
    @define-color accent_hover_bg_color {{colors.primary_container.default.hex}};
    @define-color accent_hover_fg_color {{colors.on_primary_container.default.hex}};

    @define-color window_bg_color {{colors.surface_dim.default.hex}};
    @define-color window_fg_color {{colors.on_surface.default.hex}};

    @define-color headerbar_bg_color {{colors.surface_dim.default.hex}};
    @define-color headerbar_fg_color {{colors.on_surface.default.hex}};
    @define-color headerbar_backdrop_color {{colors.surface.default.hex}};
    @define-color headerbar_shade_color {{colors.shadow.default.hex}};

    @define-color titlebar_bg_color {{colors.surface_dim.default.hex}};
    @define-color titlebar_fg_color {{colors.on_surface.default.hex}};
    @define-color titlebar_backdrop_color {{colors.surface.default.hex}};

    @define-color dialog_bg_color {{colors.surface_container_high.default.hex}};
    @define-color dialog_fg_color {{colors.on_surface.default.hex}};

    @define-color popover_bg_color {{colors.surface_container_high.default.hex}};
    @define-color popover_fg_color {{colors.on_surface.default.hex}};

    @define-color view_bg_color {{colors.surface_container_low.default.hex}};
    @define-color view_fg_color {{colors.on_surface.default.hex}};
    @define-color view_hover_bg_color {{colors.surface_container_high.default.hex}};
    @define-color view_hover_fg_color {{colors.on_surface.default.hex}};
    @define-color view_selected_bg_color {{colors.primary_container.default.hex}};
    @define-color view_selected_fg_color {{colors.on_primary_container.default.hex}};

    @define-color card_bg_color {{colors.surface_container_low.default.hex}};
    @define-color card_fg_color {{colors.on_surface.default.hex}};
    @define-color card_shade_color {{colors.shadow.default.hex}};

    @define-color sidebar_bg_color {{colors.surface_dim.default.hex}};
    @define-color sidebar_fg_color {{colors.on_surface.default.hex}};
    @define-color sidebar_border_color {{colors.surface_variant.default.hex}};
    @define-color sidebar_backdrop_color {{colors.surface_dim.default.hex}};
    @define-color sidebar_shade_color {{colors.shadow.default.hex}};

    @define-color button_bg_color {{colors.primary_container.default.hex}};
    @define-color button_fg_color {{colors.on_primary_container.default.hex}};
    @define-color button_hover_bg_color {{colors.primary.default.hex}};
    @define-color button_hover_fg_color {{colors.on_primary.default.hex}};

    @define-color border_color {{colors.outline_variant.default.hex}};
    @define-color shade_color {{colors.shadow.default.hex}};

    @define-color warning_bg_color {{colors.tertiary_container.default.hex}};
    @define-color warning_fg_color {{colors.on_tertiary_container.default.hex}};
    @define-color error_bg_color {{colors.error_container.default.hex}};
    @define-color error_fg_color {{colors.on_error_container.default.hex}};
    @define-color success_bg_color {{colors.secondary_container.default.hex}};
    @define-color success_fg_color {{colors.on_secondary_container.default.hex}};

    @define-color scrollbar_bg_color {{colors.surface_variant.default.hex}};
    @define-color scrollbar_fg_color {{colors.on_surface_variant.default.hex}};
    @define-color scrollbar_slider_color {{colors.on_surface_variant.default.hex}};
    @define-color scrollbar_slider_hover_color {{colors.on_surface.default.hex}};
    @define-color scrollbar_slider_active_color {{colors.primary.default.hex}};

    @define-color switch_bg_color {{colors.surface_variant.default.hex}};
    @define-color switch_fg_color {{colors.on_surface_variant.default.hex}};

    @define-color check_bg_color {{colors.surface_variant.default.hex}};
    @define-color check_fg_color {{colors.on_surface_variant.default.hex}};

    @define-color progress_bg_color {{colors.primary_container.default.hex}};
    @define-color progress_fg_color {{colors.primary.default.hex}};

    @define-color dim_label_fg_color {{colors.on_surface_variant.default.hex}};
    @define-color secondary_label_fg_color {{colors.outline.default.hex}};
    @define-color placeholder_label_fg_color {{colors.outline_variant.default.hex}};

    @define-color theme_bg_color {{colors.surface_dim.default.hex}};
    @define-color theme_fg_color {{colors.on_surface.default.hex}};
    @define-color theme_selected_bg_color {{colors.primary.default.hex}};
    @define-color theme_selected_fg_color {{colors.on_primary.default.hex}};
    @define-color theme_unfocused_bg_color {{colors.surface.default.hex}};
    @define-color theme_unfocused_fg_color {{colors.on_surface_variant.default.hex}};
  '';
in {
  config = lib.mkIf config.home.matugen.enable {
    home.file."${matugenAbsPath}/gtk4.css".text = base;
  };
}
