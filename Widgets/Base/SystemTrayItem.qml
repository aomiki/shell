import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Singletons

ItemDelegate {
    required property QsMenuEntry modelData
    property bool active: modelData.focused
    readonly property string hyprName: modelData.id

    id: control
    text: hyprName
    readonly property string bgColor: active? Theme.accent : null

    contentItem: WidgetText {}
    background: WidgetShape { }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: (mouse) => parent.modelData.activate();
    }
}
