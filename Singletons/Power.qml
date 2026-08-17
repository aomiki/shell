pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.UPower

Singleton {
    id: root
    property real percentage: UPower.displayDevice.percentage
    property real wattage: UPower.displayDevice.changeRate
    property string icon: UPower.displayDevice.iconName
}