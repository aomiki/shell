import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland

ItemDelegate {
    required property HyprlandWorkspace modelData
    property bool active: modelData.focused
    readonly property string hyprName: modelData.name

    id: control
    text: hyprName

    contentItem: WidgetText {}
    background: Rectangle {
        color: control.active? '#63bc7afa' : 'transparent'
        gradient: Gradient {
            GradientStop { position: 0.0; color: control.active? '#63bc7afa' : 'transparent' }
            GradientStop { position: 1.0; color: control.active? '#6319032f' : 'transparent' }
        }
    }

    Behavior on active {
        NumberAnimation {
            target: control.background
            duration: 150
            property: 'y'
            easing.type: control.active? Easing.InQuad : Easing.OutQuad
            to: control.active? -control.height : 0
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: (mouse) => parent.modelData.activate();
    }
}
