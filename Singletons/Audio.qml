// Time.qml
pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
    id: root
    readonly property list<PwNode> hwSinks: Pipewire.nodes.values.filter(n => n.isSink && !n.isStream)
    readonly property int sinkId: Pipewire.defaultAudioSink?.id ?? -1
    readonly property string sinkName: getNodeName(Pipewire.defaultAudioSink)
    readonly property string sinkIcon: getNodeIcon(Pipewire.defaultAudioSink)
    property real sinkVolume: Pipewire.defaultAudioSink?.audio.volume ?? "IDKVOL"
    property alias tracker: pwTracker
    readonly property int ready: Pipewire.ready

    function setVolume(vol: real) {
        Pipewire.defaultAudioSink.audio.volume = vol
    }

    function getNodeName(node: PwNode): string {
        if(node.nickname != '') return node.nickname

        return node.description?? 'idk'
    }

    function isBluetooth(node: PwNode): bool { return node.properties['device.api'] == 'bluez5' }
    function getBluetoothCodec(node: PwNode): string { return node.properties['api.bluez5.codec']?.toUpperCase() ?? '' }

    function getNodeIcon(node: PwNode): string {
        if (isBluetooth(node)) return 'bluetooth'
        return node.properties['device.icon_name'] ?? node.properties["device.icon-name"] ?? "IDK"
    }

    function isDefault(node: PwNode): bool {
        return node.id == sinkId
    }

    PwObjectTracker {
        id: pwTracker
        objects: [
            Pipewire.defaultAudioSink
        ]
    }
}