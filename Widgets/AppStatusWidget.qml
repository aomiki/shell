import QtQuick
import Quickshell.Wayland
import qs.Singletons

Text {
    id: appStatusWidget
    text: ToplevelManager.activeToplevel?.title ?? ''
    font.family: Theme.fontFamily
    font.weight: Font.Light
    color: Theme.text
    verticalAlignment: Text.AlignVCenter
    wrapMode: Text.WrapAnywhere
    maximumLineCount: 1

    Behavior on text {
        SequentialAnimation {
            id: anim
            readonly property int duration: 150
            readonly property string propY: 'y'
            readonly property string propOpacity: 'opacity'
            ParallelAnimation {
                NumberAnimation {
                    target: appStatusWidget
                    property: anim.propY
                    duration: anim.duration
                    easing.type: Easing.InQuad
                    to: appStatusWidget.height
                }
                NumberAnimation {
                    target: appStatusWidget
                    property: anim.propOpacity
                    duration: anim.duration
                    easing.type: Easing.InQuad
                    to: 0
                }
            }
            PropertyAction { }
            ParallelAnimation {
                NumberAnimation {
                    target: appStatusWidget
                    property: anim.propY
                    duration: anim.duration
                    easing.type: Easing.OutQuad
                    from: -appStatusWidget.height
                    to: 0
                }
                NumberAnimation {
                    target: appStatusWidget
                    property: anim.propOpacity
                    duration: anim.duration
                    easing.type: Easing.InQuad
                    to: 1
                }

            }
        }
    }
}
