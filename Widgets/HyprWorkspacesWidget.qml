import QtQuick
import Quickshell.Hyprland
import qs.Widgets.Base

Row {
    id: workspaceRow
    Repeater {
        model: Hyprland.workspaces

        delegate: HyprWorkspaceButton {
        }
    }
}