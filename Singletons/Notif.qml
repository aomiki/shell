pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.Notifications 

Singleton {
    id: root
    property alias notification: server.currNotification
    property alias notifications: server.trackedNotifications
    
    NotificationServer {
        id: server
        bodyMarkupSupported: true
        keepOnReload: false
        property Notification currNotification

        onNotification: function(notif: Notification){
            notif.tracked = true
            currNotification = notif
        }
    }
}
