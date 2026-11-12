import QtQuick
import qs.Singletons
import Quickshell.Services.Notifications
pragma ComponentBehavior: Bound

// Ticker: new notifications are queued and scrolled right-to-left one at a time.
Item {
    id: notifWidget
    clip: true

    readonly property real speed: 120 // px per second
    property var queue: []
    property Notification current: null

    Connections {
        target: Notif
        function onNotificationChanged() {
            if (!Notif.notification) return
            notifWidget.queue.push(Notif.notification)
            notifWidget.showNext()
        }
    }

    function showNext() {
        if (ticker.running) return
        while (queue.length > 0) {
            const next = queue.shift()
            if (next) { // null if it was dismissed while waiting
                current = next
                content.x = width
                ticker.start()
                return
            }
        }
        current = null
    }

    Row {
        id: content
        visible: ticker.running
        height: notifWidget.height
        spacing: 5

        Image {
            width: height
            height: content.height
            visible: (notifWidget.current?.image ?? '') !== ''
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            source: notifWidget.current?.image ?? ''
        }

        Text {
            height: content.height
            maximumLineCount: 1
            text: notifWidget.current?.body ?? ''
            font.family: Theme.fontFamily
            font.weight: Font.Medium
            color: Theme.text
            verticalAlignment: Text.AlignVCenter
        }
    }

    // Moves the row every frame and stops once its real (current) width has fully left on the left.
    FrameAnimation {
        id: ticker
        onTriggered: {
            content.x -= notifWidget.speed * frameTime
            if (content.x + content.width < 0) {
                stop()
                Qt.callLater(notifWidget.showNext)
            }
        }
    }
}
