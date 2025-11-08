# ~/.config/qtile/config.py
# Qtile config matching i3 (TokyoNight Storm + Green Focus)
# Optimized for Termux + PRoot-Distro (mobile use)

from libqtile import bar, layout, widget, hook
from libqtile.config import Key, Group, Match, Screen
from libqtile.lazy import lazy
import os, subprocess

# -----------------------
# BASIC SETTINGS
# -----------------------
mod = "mod1"  # Alt key as mod
terminal = "alacritty"
font_name = "FiraCode Nerd Font Bold"
font_size = 15
wallpaper_cmd = "nitrogen --restore &"

# -----------------------
# COLOR SCHEME (TokyoNight Storm + Green Focus)
# -----------------------
colors = {
    "bg": "#1a1b26",
    "bg_alt": "#24283b",
    "fg": "#c0caf5",
    "green": "#9ece6a",
    "red": "#f7768e",
    "yellow": "#e0af68",
    "gray": "#565f89",
    "darkgray": "#1f2335",
    "urgent": "#f7768e",
    "inactive": "#a9b1d6",
}

# -----------------------
# KEYBINDINGS
# -----------------------
keys = [
    # Launch terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    
    # Kill window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    
    # App launchers
    Key([mod], "r", lazy.spawncmd(), desc="Run command (Qtile prompt)"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Run Rofi"),
    Key([mod, "shift"], "f", lazy.spawn("firefox-esr")),
    Key([mod, "shift"], "t", lazy.spawn("thunar")),
    Key([mod, "shift"], "b", lazy.spawn("brave-browser --no-sandbox")),

    # Focus movement
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),

    # Resize windows (like i3 resize mode)
    Key([mod, "control"], "h", lazy.layout.shrink_main(), desc="Shrink window width"),
    Key([mod, "control"], "l", lazy.layout.grow_main(), desc="Grow window width"),
    Key([mod, "control"], "j", lazy.layout.grow(), desc="Grow window height"),
    Key([mod, "control"], "k", lazy.layout.shrink(), desc="Shrink window height"),
    Key([mod, "control"], "Left", lazy.layout.shrink_main()),
    Key([mod, "control"], "Right", lazy.layout.grow_main()),
    Key([mod, "control"], "Down", lazy.layout.grow()),
    Key([mod, "control"], "Up", lazy.layout.shrink()),

    # Layout controls
    Key([mod], "space", lazy.next_layout(), desc="Next layouts"),
    Key([mod, "shift"], "space", lazy.prev_layout(), desc="Previous layouts"),

    # Restart / reload
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload Qtile"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Exit Qtile"),
]

# -----------------------
# WORKSPACES
# -----------------------
groups = [Group(str(i)) for i in range(1, 10)]

for i in groups:
    keys.extend([
        # Switch to workspace
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        # Move focused window to workspace
        Key([mod, "control"], i.name, lazy.window.togroup(i.name)),
    ])

# -----------------------
# LAYOUTS
# -----------------------
layout_conf = {
    "border_focus": colors["green"],
    "border_normal": colors["darkgray"],
    "border_width": 2,
    "margin": 8,
}

layouts = [
    layout.MonadTall(**layout_conf),
    layout.RatioTile(**layout_conf),
    layout.Max(**layout_conf),
]

# -----------------------
# WIDGETS / BAR
# -----------------------
widget_defaults = dict(
    font=font_name,
    fontsize=15,
    padding=4,
    background=colors["bg"],
    foreground=colors["fg"],
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(background=colors["bg_alt"]),
                widget.GroupBox(
                    highlight_method='line',
                    active=colors["fg"],
                    inactive=colors["inactive"],
                    this_current_screen_border=colors["green"],
                    this_screen_border=colors["green"],
                    background=colors["bg_alt"],
                    urgent_border=colors["urgent"],
                    rounded=True,
                    padding_x=6,
                    padding_y=3,
                ),
                widget.Prompt(prompt="Run: "),
                widget.WindowName(),
                widget.Clock(
                    format="%a. %b. %d, %Y",
                    background=colors["bg_alt"],
                ),
            ],
            28,
            background=colors["bg"],
            margin=[8, 8, 0, 8],
        ),
    ),
]

# -----------------------
# AUTOSTART
# -----------------------
@hook.subscribe.startup_once
def autostart():
    subprocess.Popen(["sh", "-c", wallpaper_cmd])

# -----------------------
# FLOATING RULES
# -----------------------
floating_layout = layout.Floating(
    border_focus=colors["green"],
    border_normal=colors["darkgray"],
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
)

# -----------------------
# FINAL SETTINGS
# -----------------------
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "Qtile"

