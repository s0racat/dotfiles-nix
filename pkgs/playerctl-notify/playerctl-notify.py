#!/usr/bin/env python3

from gi.repository import GLib, Gio
import gi

gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl

manager = Playerctl.PlayerManager()

Application = Gio.Application.new("hello.world", Gio.ApplicationFlags.FLAGS_NONE)
Application.register()
notification = Gio.Notification.new("Playerctl")


def notify(player, icon):
    metadata = player.props.metadata
    keys = metadata.keys()

    if "xesam:artist" in keys and "xesam:title" in keys:

        notification.set_body(
            f"{metadata['xesam:title']}, {metadata['xesam:artist'][0]}"
        )
        Icon = Gio.ThemedIcon.new(icon)
        notification.set_icon(Icon)
        Application.send_notification(None, notification)


def on_play(player, status, manager):
    notify(player, "media-playback-start")


def on_pause(player, status, manager):
    notify(player, "media-playback-pause")


def init_player(name):
    player = Playerctl.Player.new_from_name(name)
    player.connect("playback-status::playing", on_play, manager)
    player.connect("playback-status::paused", on_pause, manager)
    manager.manage_player(player)
    notify(player, "dialog-information")


def on_name_appeared(manager, name):
    init_player(name)


manager.connect("name-appeared", on_name_appeared)

for name in manager.props.player_names:
    init_player(name)


main = GLib.MainLoop()
main.run()

Gio.Application.quit(Application)
