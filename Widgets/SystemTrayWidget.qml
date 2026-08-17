import QtQuick
import QtQuick.Controls
import Quickshell.Services.SystemTray

Row {
    id: workspaceRow
    Repeater {
        model: SystemTray.items
        delegate: ItemDelegate {
            required property var modelData
            id: control
            icon.source: modelData?.icon?? 'icon/idk'
            implicitHeight: 30
            implicitWidth: 30
            display: AbstractButton.IconOnly
            background: Rectangle {
                color: 'transparent'
                implicitHeight: 20
                implicitWidth: 20
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: (mouse) => parent.modelData.activate();
            }
        }
    }
}