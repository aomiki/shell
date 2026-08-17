import QtQuick.Controls
import QtQuick
import Quickshell.Networking
import qs.Widgets.Base

ItemDelegate {
    required property var modelData
    readonly property WifiNetwork connectedWifiNetwork: modelData as WifiNetwork
    visible: connectedWifiNetwork.connected
    text: connectedWifiNetwork?.name
    icon.name: connectedWifiNetwork != null? signalStrengthToIcon((connectedWifiNetwork.signalStrength*100).toFixed(0)) : 'network-wireless-disconnected'

    background: WidgetShape {
    }

    function signalStrengthToIcon(strength: real): string {
        if (strength == 0) {
            return 'network-wireless-connected-00'
        }
        else if (strength <= 25) {
            return 'network-wireless-connected-25'
        }
        else if (strength <= 50) {
            return 'network-wireless-connected-50'
        }
        else if (strength <= 75) {
            return 'network-wireless-connected-75'
        }
        else if (strength <= 100) {
            return 'network-wireless-connected-100'
        }
    }
}