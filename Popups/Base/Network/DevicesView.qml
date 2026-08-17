import Quickshell.Networking
import QtQuick
import QtQuick.Controls
pragma ComponentBehavior: Bound


Column {
    id: devicesView
    required property StackView stack
    required property var devices
    required property ItemDelegate reloadButton
    readonly property var networksComp: Qt.createComponent("WifiNetworksView.qml")
    property string selectDeviceName

    Repeater {
        model: devicesView.devices
        delegate: ItemDelegate {
            id: deviceItem
            anchors.left: parent.left
            anchors.right: parent.right
            required property var modelData
            text: modelData.name + ' [' + modelData.address + ']'
            icon.name: modelData.type == DeviceType.Wifi? 'network-wireless' : 'network-wired'

            background: Rectangle {
                color: deviceItem.hovered? '#980c0e39' : 'transparent'
            }
            hoverEnabled: true

            Connections {
                target: devicesView
                function onSelectDeviceNameChanged() {
                    if (deviceItem.modelData.name == devicesView.selectDeviceName) {
                        deviceItem.openNetworks()
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                enabled: deviceItem.modelData.type == DeviceType.Wifi
                cursorShape: enabled? Qt.PointingHandCursor : undefined

                onClicked: (mouse) => {
                    deviceItem.openNetworks()
                }
            }

            function openNetworks()
            {
                devicesView.stack.push(devicesView.networksComp, { networks: deviceItem.modelData.networks, dev: deviceItem.modelData, reloadButton: devicesView.reloadButton })
            }
        }
    }
}