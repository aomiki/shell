import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import qs.Widgets.Base
import qs.Popups

pragma ComponentBehavior: Bound

Row {
    id: control
    required property NetworkPopup popup
    Repeater {
        model: Networking.devices
        delegate: ItemDelegate {
            id: deviceItem
            required property var modelData
            readonly property NetworkDevice netDev: modelData as NetworkDevice
            icon.name: netDev.connected? '' : (netDev.type == DeviceType.Wifi ? 'network-wireless-disconnected' : 'network-wired-disconnected')
            implicitWidth: netDev.connected? networksRow.width : control.height
            implicitHeight: netDev.connected? networksRow.height : control.height
            background: Rectangle {
                color: 'transparent'
            }

            Row {
                id: networksRow
                Repeater {
                    model: deviceItem.netDev.networks
                    delegate: deviceItem.netDev.type == DeviceType.Wifi? wifiNetworkComp : wiredNetworkComp
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: (mouse) => {
                    control.popup.selectDeviceName = netDev.name
                    control.popup.togglePopup()
                }
            }
        }
    }

    Component {
        id: wifiNetworkComp
        ItemDelegate {
            required property var modelData
            visible: modelData.connected
            text: modelData?.name
            icon.name: modelData != null? signalStrengthToIcon((modelData.signalStrength*100).toFixed(0)) : 'network-wireless-disconnected'

            background: WidgetShape {
            }

            function signalStrengthToIcon(strength: real): string {
                if (strength == 0) {
                    return 'network-wireless-00'
                }
                else if (strength <= 25) {
                    return 'network-wireless-25'
                }
                else if (strength <= 50) {
                    return 'network-wireless-50'
                }
                else if (strength <= 75) {
                    return 'network-wireless-75'
                }
                else if (strength <= 100) {
                    return 'network-wireless-100'
                }
            }
        }
    }

    Component {
        id: wiredNetworkComp
        ItemDelegate {
            required property var modelData
            visible: modelData.connected
            text: modelData?.name
            icon.name: 'network-wired-connected' 

            background: WidgetShape {
            }
        }
    }
}