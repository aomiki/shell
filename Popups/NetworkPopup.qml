import Quickshell.Networking
import QtQuick
import QtQuick.Controls
import qs.Popups.Base
import qs.Popups.Base.Network

pragma ComponentBehavior: Bound

StackPopup {
    id: networkPopup
    stack.initialItem: devicesView
    readonly property ItemDelegate reloadButton: networkPopup.rightTopButton
    property string selectDeviceName

    DevicesView {
        id: devicesView
        selectDeviceName: networkPopup.selectDeviceName
        reloadButton: networkPopup.reloadButton
        stack: networkPopup.stack
        devices: Networking.devices
    }
}
