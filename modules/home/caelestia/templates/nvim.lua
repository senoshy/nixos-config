-- Caelestia user template for Neovim. The `caelestia` CLI fills in the
-- `{{ role.hex }}` tokens from the active scheme and writes the result to
-- ~/.local/state/caelestia/theme/nvim.lua, next to the kitty template. The
-- Neovim config (modules/home/dev/nvim-theme.nix) reads this table and feeds
-- it to base16-colorscheme, so the editor tracks the shell exactly like the
-- built-in Zed template makes Zed track it.
--
-- The table carries two things:
--   * the base16 slots, which give base16-colorscheme broad default coverage
--     (Vim, LSP, diagnostics, diff, ...);
--   * the raw roles below, which mirror zed.json's syntax block one-for-one so
--     the overrides in modules/home/dev/nvim-theme.nix can match Zed token by
--     token instead of relying on base16's coarser slot mapping.
return {
  base00 = "#{{ surface.hex }}",              -- background
  base01 = "#{{ surfaceContainer.hex }}",      -- status bars, raised surfaces
  base02 = "#{{ surfaceContainerHigh.hex }}",  -- selection background
  base03 = "#{{ subtext0.hex }}",              -- comments, invisibles
  base04 = "#{{ onSurfaceVariant.hex }}",      -- line numbers, dim foreground
  base05 = "#{{ onSurface.hex }}",             -- default foreground
  base06 = "#{{ onSurface.hex }}",             -- light foreground
  base07 = "#{{ primary.hex }}",               -- brightest foreground / accent
  base08 = "#{{ red.hex }}",                   -- errors, diff removed
  base09 = "#{{ peach.hex }}",                 -- numbers, constants, booleans
  base0A = "#{{ yellow.hex }}",                -- types, classes, labels
  base0B = "#{{ green.hex }}",                 -- strings, diff added
  base0C = "#{{ teal.hex }}",                  -- regex, escapes, support
  base0D = "#{{ blue.hex }}",                  -- functions, methods, includes
  base0E = "#{{ pink.hex }}",                  -- keywords, storage, operators
  base0F = "#{{ maroon.hex }}",                -- deprecated, embedded tags

  -- Raw roles, named exactly as the tokens zed.json uses.
  surface = "#{{ surface.hex }}",
  surfaceContainer = "#{{ surfaceContainer.hex }}",
  surfaceContainerHigh = "#{{ surfaceContainerHigh.hex }}",
  onSurface = "#{{ onSurface.hex }}",
  onSurfaceVariant = "#{{ onSurfaceVariant.hex }}",
  outline = "#{{ outline.hex }}",
  outlineVariant = "#{{ outlineVariant.hex }}",
  subtext0 = "#{{ subtext0.hex }}",
  subtext1 = "#{{ subtext1.hex }}",
  primary = "#{{ primary.hex }}",
  onPrimary = "#{{ onPrimary.hex }}",
  red = "#{{ red.hex }}",
  maroon = "#{{ maroon.hex }}",
  peach = "#{{ peach.hex }}",
  yellow = "#{{ yellow.hex }}",
  green = "#{{ green.hex }}",
  teal = "#{{ teal.hex }}",
  sky = "#{{ sky.hex }}",
  sapphire = "#{{ sapphire.hex }}",
  blue = "#{{ blue.hex }}",
  lavender = "#{{ lavender.hex }}",
  mauve = "#{{ mauve.hex }}",
  pink = "#{{ pink.hex }}",
  error = "#{{ error.hex }}",
  success = "#{{ success.hex }}",
}
