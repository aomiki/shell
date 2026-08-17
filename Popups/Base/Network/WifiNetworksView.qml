import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Networking

pragma ComponentBehavior: Bound

ScrollView {
    id: networksView
    required property var networks
    required property WifiDevice dev
    required property ItemDelegate reloadButton
    contentWidth: availableWidth
    GridLayout {
        columns: 5
        rowSpacing: 0
        columnSpacing: 0
        anchors.fill: parent
        flow: GridLayout.TopToBottom
        Repeater {
            model: networksView.networks
            delegate: ItemDelegate {
                Layout.column: 0
                Layout.row: index
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: icon.width+padding
                required property int index
                required property var modelData
                readonly property WifiNetwork net: modelData
                icon.name: (net?.connected? 'check-filled' : '')
                background: Rectangle {
                    color: 'transparent'
                }
            }
        }
        Repeater {
            model: networksView.networks
            delegate: ItemDelegate {
                Layout.column: 1
                Layout.row: index
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                required property int index
                required property var modelData
                readonly property WifiNetwork net: modelData
                icon.name: net != null? networksView.getWifiIcon(net) : ''
                background: Rectangle {
                    color: 'transparent'
                }
            }
        }
        Repeater {
            model: networksView.networks
            delegate: Text {
                Layout.column: 2
                Layout.row: index
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Qt.AlignVCenter
                required property int index
                required property var modelData
                readonly property WifiNetwork net: modelData
                text: (net?.signalStrength*100).toFixed(0) + '% '
                color: 'white'
            }
        }
        Repeater {
            model: networksView.networks.values.length
            delegate: ToolSeparator {
                Layout.column: 3
                Layout.row: index
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                padding: 0
                contentItem: Rectangle {
                    implicitWidth: 1
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    color: "#c3c3c3"
                }
                required property int index
            }
        }
        Repeater {
            model: networksView.networks
            delegate: ItemDelegate {
                Layout.column: 4
                Layout.row: index
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                required property int index
                id: networkItem
                required property var modelData
                readonly property WifiNetwork net: modelData
                readonly property WifiDevice dev: net?.device ?? null
                text: net?.name
                background: Rectangle {
                    color: networkItem.hovered? '#980c0e39' : 'transparent'
                }
                hoverEnabled: true

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    enabled: networkItem.net != null

                    onClicked: (mouse) =>  {
                        networkItem.net.connect()
                    }
                }
            }
        }

        Component.onCompleted: {
            networksView.reloadButton.visible = true
            networksView.reloadButton.icon.color = networksView.dev.scannerEnabled? 'grey' : 'white'
        }
        Component.onDestruction: networksView.reloadButton.visible = false

        Connections {
            target: networksView.reloadButton
            function onClicked() {
                networksView.dev.scannerEnabled = true
            }
        }
    }

    function getWifiIcon(network: WifiNetwork): string {
        var baseText = 'network-wireless'
        var signalText = '0'


        if (network.stateChanging) {
            return `${baseText}-acquiring`
        }

        if (network.signalStrength == 0) {
            signalText = '00'
        }
        else if (network.signalStrength <= 0.25) {
            signalText = '25'
        }
        else if (network.signalStrength <= 0.5) {
            signalText = '50'
        }
        else if (network.signalStrength <= 0.75) {
            signalText = '75'
        }
        else if (network.signalStrength <= 1) {
            signalText = '100'
        }
/*
        if (network.connected) {
            return `${baseText}-connected-${signalText}`
        }
*/
        if (network.security != WifiSecurityType.Open && !network.known) {
            return `${baseText}-${signalText}-locked`
        }

        return `${baseText}-${signalText}`
    }
}