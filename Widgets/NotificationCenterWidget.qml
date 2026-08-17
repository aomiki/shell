import QtQuick.Controls
import QtQuick
import qs.Popups

ItemDelegate {
    id: control
    required property NotifPopup popup
    icon.name: 'bell'
    width: icon.width
    background: Rectangle {
        color: 'transparent'
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: (mouse) =>  control.popup.togglePopup()
    }
}