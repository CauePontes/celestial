---
name: Celestial
colors:
  surface: '#131025'
  surface-dim: '#131025'
  surface-bright: '#3a364d'
  surface-container-lowest: '#0e0b20'
  surface-container-low: '#1c192e'
  surface-container: '#201d32'
  surface-container-high: '#2a273d'
  surface-container-highest: '#353249'
  on-surface: '#e5dffc'
  on-surface-variant: '#cbc3d5'
  inverse-surface: '#e5dffc'
  inverse-on-surface: '#312e44'
  outline: '#948e9e'
  outline-variant: '#494552'
  surface-tint: '#cfbdff'
  primary: '#cfbdff'
  on-primary: '#39098d'
  primary-container: '#5532a8'
  on-primary-container: '#c5afff'
  inverse-primary: '#6948bd'
  secondary: '#cebdff'
  on-secondary: '#371c77'
  secondary-container: '#4e368f'
  on-secondary-container: '#bea8ff'
  tertiary: '#e0c38e'
  on-tertiary: '#3f2d06'
  tertiary-container: '#5c481f'
  on-tertiary-container: '#d4b784'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e9ddff'
  primary-fixed-dim: '#cfbdff'
  on-primary-fixed: '#22005d'
  on-primary-fixed-variant: '#502da3'
  secondary-fixed: '#e8ddff'
  secondary-fixed-dim: '#cebdff'
  on-secondary-fixed: '#21005e'
  on-secondary-fixed-variant: '#4e368f'
  tertiary-fixed: '#fddfa8'
  tertiary-fixed-dim: '#e0c38e'
  on-tertiary-fixed: '#261900'
  on-tertiary-fixed-variant: '#58441b'
  background: '#131025'
  on-background: '#e5dffc'
  surface-variant: '#353249'
typography:
  display-lg:
    fontFamily: Playfair Display
    fontSize: 36px
    fontWeight: '500'
    lineHeight: 44px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Playfair Display
    fontSize: 30px
    fontWeight: '500'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Playfair Display
    fontSize: 28px
    fontWeight: '500'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Playfair Display
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 30px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Playfair Display
    fontSize: 18px
    fontWeight: '500'
    lineHeight: 26px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 26px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 23px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 19px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.02em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.04em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.06em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system embodies **cosmic minimalism** and **quiet luxury**—a serene, editorial sanctuary for astrology, self-discovery, relationships, numerology, meditation, and personal wellness.

- **Brand Personality:** Mystical yet grounded, intimate, reflective, and refined. It avoids loud neon tropes or cluttered occult motifs in favor of spacious, contemplative calm.
- **Target Audience:** Mindful individuals seeking daily guidance, emotional clarity, and spiritual connection through a modern, high-craft mobile experience.
- **Emotional Response:** Tranquility, wonder, and quiet confidence—like gazing into a clear night sky from a quiet observatory.
- **Design Style:** A blend of **Minimalism** and **Modern Editorial** design, accented by subtle **Glassmorphism** (frosted translucent overlays) and fine celestial orbital linework. Surfaces rely on deep twilight tones, delicate 1px hairline borders, and soft ambient lavender glows rather than heavy gradients.

## Colors

The palette is anchored in deep nocturnal indigo and elevated by soft lavender and muted gold, ensuring high-contrast legibility and a restful dark-mode experience.

- **Backgrounds & Surfaces:**
  - **Main Canvas (`#141126`):** Deep cosmic indigo used for primary screen backgrounds.
  - **Secondary Surface (`#211B38`):** Elevated twilight plum used for cards, bottom sheets, and grouped containers.
- **Brand & Accent Colors:**
  - **Primary Purple (`#5532A8`):** Reserved for primary CTAs, active states, and key interactive highlights.
  - **Soft Lavender (`#A991F0`):** Used for secondary accents, active icons, subtle glow effects, and hairline borders (`rgba(169, 145, 240, 0.15)`).
  - **Muted Gold (`#DABD89`):** Applied sparingly for celestial badges, premium indicators, astrological glyphs, and auspicious highlights.
- **Text & Contrast:**
  - **Primary Text (`#F7F4FF`):** Warm starlight white for headings and primary body copy, maintaining strong contrast against both `#141126` and `#211B38`.
  - **Secondary Text:** `#F7F4FF` at 70% opacity for supporting descriptions, timestamps, and metadata.

## Typography

The typographic hierarchy pairs an expressive editorial serif with a clean, humanist sans-serif:

- **Headings (`Playfair Display`):** Used for daily horoscope titles, ritual names, and section headers. Its high-contrast strokes and classical proportions evoke editorial luxury. On mobile viewports, `display-lg-mobile` scales down from `36px` to `30px` to preserve breathing room.
- **Body & UI (`Plus Jakarta Sans`):** Used for readings, meditation scripts, navigation, and form controls. Generous line heights (`1.5x` on body text) ensure effortless long-form reading in dark mode.
- **Labels:** Uppercase or wide-tracked `label-sm` and `label-md` styles are used for astrological houses, moon phases, and category tags.

## Layout & Spacing

The layout uses a **fluid mobile-first grid** designed for spacious, unhurried reading and effortless thumb reachability.

- **Mobile (default, `< 600px`):** 4-column fluid grid with `1.25rem` (`20px`) outer margins and `1rem` (`16px`) gutters. Cards typically span all 4 columns, while compact metric tiles (e.g., Moon Phase, Rising Sign) pair in 2-column rows.
- **Tablet (`600px – 1024px`):** Expands to an 8-column fluid grid with `2rem` outer margins, allowing editorial readings and natal chart wheels to sit side-by-side.
- **Desktop (`> 1024px`):** 12-column centered container (max-width `1120px`) with `2rem` margins, preserving comfortable line lengths (`60–70ch`) for long-form astrological insights.
- **Spacing Rhythm:** Generous vertical breathing room (`space-lg` and `space-xl`) separates distinct content modules, reinforcing the quiet luxury aesthetic.

## Elevation & Depth

Depth is achieved through **tonal layering** and **low-contrast hairline outlines** rather than heavy drop shadows:

- **Tonal Layers:** The primary canvas (`#141126`) sits at the base, while cards, modals, and bottom navigation rest on `#211B38`.
- **Subtle Borders:** Interactive and grouped surfaces are defined by a crisp `1px solid rgba(169, 145, 240, 0.15)` border, mimicking fine celestial orbital lines.
- **Soft Ambient Glow:** Featured elements (such as the daily tarot/horoscope card or active meditation player) may include a diffused, low-opacity radial glow (`0 8px 32px rgba(169, 145, 240, 0.08)`) behind the surface.
- **Frosted Overlays:** Bottom sheets and floating navigation bars use subtle backdrop blur (`blur(16px)`) over semi-transparent `#211B38` (`85%` opacity).

## Shapes

The shape language is **softly rounded** (`roundedness: 2`), echoing planetary curves and organic smoothness:

- **Standard Controls (`0.5rem` / `8px`):** Inputs, small tags, and compact buttons.
- **Cards & Containers (`1rem` / `16px`):** Daily reading cards, compatibility modules, and list containers.
- **Featured Surfaces & Modals (`1.5rem` / `24px`):** Bottom sheets, meditation player cards, and hero banners.
- **Circular & Pill Elements:** Primary action buttons, filter chips, and avatar frames use full pill or circular radii (`9999px`) to harmonize with orbital motifs.

## Components

- **Buttons:**
  - *Primary:* Pill-shaped (`9999px`), filled with `#5532A8`, `#F7F4FF` label text, and a subtle `rgba(169, 145, 240, 0.25)` hover/press glow.
  - *Secondary:* Transparent background with a `1px solid rgba(169, 145, 240, 0.3)` border and `#A991F0` text.
  - *Ghost / Text:* `#DABD89` (muted gold) or `#A991F0` text for low-emphasis actions.
- **Cards:**
  - Built on `#211B38` with `1rem` (`16px`) corner radius, `1.25rem` internal padding, and a `1px solid rgba(169, 145, 240, 0.15)` border.
- **Chips:**
  - Pill-shaped filters for zodiac signs, mood tags, or meditation themes. Unselected chips use `#211B38` with a subtle border; selected chips use `#5532A8` fill with `#F7F4FF` text.
- **Lists:**
  - Clean vertical rows separated by `1px solid rgba(169, 145, 240, 0.1)` dividers, with generous `1rem` vertical padding and `#DABD89` or `#A991F0` leading icons.
- **Input Fields:**
  - `#141126` or `#211B38` fill, `0.5rem` (`8px`) radius, `1px solid rgba(169, 145, 240, 0.2)` border, transitioning to `#A991F0` on focus.
- **Checkboxes & Radio Buttons:**
  - Circular or softly rounded (`0.25rem`) controls with `1.5px` `#A991F0` borders, filling with `#5532A8` when active.
- **Celestial Orbital Dividers & Gauges:**
  - Thin `1px` concentric rings and hairline arcs in `rgba(169, 145, 240, 0.2)` with `#DABD89` planetary nodes, used in natal charts, compatibility meters, and meditation timers.