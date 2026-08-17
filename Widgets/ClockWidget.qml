import QtQuick
import QtQuick.Controls
import qs.Widgets.Base
import qs.Popups
import qs.Singletons

ItemDelegate {
    id: control
    required property DatePopup popup
    text: Time.readableTime

    contentItem: WidgetText {
        font.bold: true
    }
    background: Rectangle {
        color: 'transparent'
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: (mouse) => control.popup.togglePopup()
    }
}
