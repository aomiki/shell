import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Widgets
import qs.Popups
import qs.Popups.Base

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: bar
      color: '#988288ff'
      required property var modelData
      property PopupFrame activePopup
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30
      RowLayout {
        id: rowleft
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: dateWidget.left
        SystemTrayWidget {
          Layout.fillWidth: true
          Layout.fillHeight: true
          Layout.minimumWidth: 30
          Layout.maximumWidth: 200
        }
       ToolSeparator {
          contentItem: Rectangle {
              implicitWidth: 1
              implicitHeight: 24
              color: "#c3c3c3"
          }
       }
        HyprWorkspacesWidget {
          Layout.fillHeight: true
          Layout.leftMargin: 0
          Layout.minimumWidth: 30
        }
        AppStatusWidget {
          Layout.fillHeight: true
          Layout.leftMargin: 15
          Layout.fillWidth: true
          Layout.horizontalStretchFactor: 1
        }
      }

      ClockWidget {
        id: dateWidget
        popup: datePopup
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.fillWidth: false
        Layout.minimumWidth: 200
        Layout.preferredWidth: 200
        Layout.maximumWidth: 200
      }
      RowLayout {
        id: rowright
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.left: dateWidget.right
        anchors.leftMargin: 10

        NotificationWidget {
          id: notifWidget
          Layout.fillHeight: true
          Layout.fillWidth: true
          Layout.alignment: Qt.AlignLeft
        }
        NotificationCenterWidget {
          id: notifCenterWidget
          popup: notifPopup
          Layout.fillHeight: true
        }
        AudioWidget {
          id: audioWidget
          popup: audioPopup
        }
       ToolSeparator {
          contentItem: Rectangle {
              implicitWidth: 1
              implicitHeight: 24
              color: "#c3c3c3"
          }
       }
        NetworkWidget {
          popup: networkPopup
        }
       ToolSeparator {
          contentItem: Rectangle {
              implicitWidth: 1
              implicitHeight: 24
              color: "#c3c3c3"
          }
       }
        PowerWidget {
          Layout.fillWidth: false
          Layout.minimumWidth: 100
          Layout.maximumWidth: 300
        }
       ToolSeparator {
          contentItem: Rectangle {
              implicitWidth: 1
              implicitHeight: 24
              color: "#c3c3c3"
          }
       }
        ArchLogoWidget {
          Layout.fillWidth: true
          Layout.minimumWidth: 15
          Layout.preferredWidth: 75
          Layout.maximumWidth: 75
        }
      }

      NetworkPopup {
        id: networkPopup
        implicitWidth: 300
        maxHeight: 500
        togglePopup: () => bar.togglePopup(networkPopup)
        anchor.window: bar
        anchor.rect.x: bar.width
        anchor.rect.y: bar.height
        visible: false
      }
      AudioPopup {
        id: audioPopup
        implicitWidth: 500
        maxHeight: 300
        togglePopup: () => bar.togglePopup(audioPopup)
        anchor.window: bar
        anchor.rect.x: bar.width
        anchor.rect.y: bar.height
        visible: false
      }
      DatePopup {
        id: datePopup
        implicitWidth: 250
        implicitHeight: 250
        togglePopup: () => bar.togglePopup(datePopup)
        anchor.window: bar
        anchor.rect.x: dateWidget.x - width/2 + dateWidget.width/2
        anchor.rect.y: bar.height
        visible: false
      }
      NotifPopup {
        id: notifPopup
        implicitWidth: 700
        maxHeight: 400
        togglePopup: () => bar.togglePopup(notifPopup)
        anchor.window: bar
        anchor.rect.x: bar.width
        anchor.rect.y: bar.height
        visible: false
      }

      function togglePopup(popup: PopupWindow)
      {
        if (activePopup != undefined && activePopup != popup) {
          activePopup.visible = false
        }
        activePopup = popup
        activePopup.toggleVisibility()
      }
    }
  }
}