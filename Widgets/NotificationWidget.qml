import QtQuick
import qs.Singletons
import Quickshell.Services.Notifications
import QtQuick.Controls
pragma ComponentBehavior: Bound
Item {
    id: notifWidget
    clip: true

    ListView {
        id: notifListView
        model: Notif.notifications
        anchors.fill: parent
        currentIndex: -1
        interactive: false

        onCountChanged: {
            if (currentIndex != (count - 1) && !anim.running) {
                notifListView.incrementCurrentIndex()
                anim.running = true
            }
            console.log('count changed, new value: ' + notifListView.count + ' current item: ' + notifListView.currentIndex)
        }

        delegate: Row {
            id: notifWidgetContent
            spacing: 5
            required property var modelData
            required property int index
            visible: false

            Image {
                height: notifWidget.height
                fillMode: Image.PreserveAspectFit
                source: notifWidgetContent.modelData?.image.toString() ?? ''
            }

            Text {
                id: notifText
                height: notifWidget.height
                maximumLineCount: 1
                text: notifWidgetContent.modelData?.body ?? ''
                font.family: 'SFProDisplay Nerd Font'
                font.weight: Font.Medium
                color: '#ffffff'
                verticalAlignment: Text.AlignVCenter
            }
        }

        SequentialAnimation {
            id: anim
            readonly property int duration: (notifListView.currentItem?.width ?? 0) * 25
            readonly property string propX: 'x'
            PropertyAction {
                target: notifListView.currentItem
                property: 'visible'
                value: true
            }
            NumberAnimation {
                target: notifListView.currentItem
                property: anim.propX
                duration: anim.duration
                easing.type: Easing.OutInQuad
                from: -notifListView.currentItem?.width ?? 0
                to: notifWidget.width
            }
            PropertyAction {
                target: notifListView.currentItem
                property: 'visible'
                value: false
            }

            onStarted: {
                console.log('Started animation for: ' + notifListView.currentIndex + ' loops: ' + anim.loops)
            }
            onFinished: {
                if (notifListView.currentIndex < (notifListView.count - 1)) {
                    notifListView.incrementCurrentIndex()
                    anim.restart()
                }
                console.log('Stopped animation on: ' + notifListView.currentIndex + ' loops: ' + anim.loops)
            }
        }
    }
}
