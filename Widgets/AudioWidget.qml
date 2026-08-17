import QtQuick
import QtQuick.Controls
import qs.Widgets.Base
import qs.Popups
import qs.Singletons


ItemDelegate {
    id: control
    required property AudioPopup popup
    text: (Audio.sinkVolume*100).toFixed(0) + '%' 
    icon.name: Audio.sinkIcon
    font.family: 'SFProDisplay Nerd Font'

    background: WidgetShape {
    }
    wheelEnabled: true

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onWheel: (wheel) => Qt.callLater((wheel) => {
            var direction = Math.sign(wheel.angleDelta.y)
            if((Audio.sinkVolume >= 1 && direction == 1) || (Audio.sinkVolume <= 0 && direction == -1)) return
            Audio.setVolume(Audio.sinkVolume + direction*0.005)
        }, wheel)
        onClicked: (mouse) => control.popup.togglePopup()

    }
}
