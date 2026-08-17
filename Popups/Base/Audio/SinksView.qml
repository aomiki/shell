import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.Singletons

pragma ComponentBehavior: Bound

ScrollView {
    id: sinksView
    anchors.fill: parent
    contentWidth: availableWidth
    required property list<PwNode> sinks
    GridLayout {
        columns: 5
        width: sinksView.availableWidth
        flow: GridLayout.TopToBottom
        rowSpacing: 0
        columnSpacing: 0

        Repeater {
            model: sinksView.sinks
            delegate: ItemDelegate {
                id: iconItem
                Layout.rowSpan: 2
                Layout.column: 0
                Layout.row: index*2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 1
                padding: 0
                required property int index
                required property var modelData
                readonly property bool isDefault: Audio.isDefault(modelData)

                icon.name: Audio.getNodeIcon(modelData)
                text: Audio.getNodeName(modelData)

                background: Rectangle {
                    color: iconItem.isDefault? '#d10c0e39' : (iconItem.hovered? '#980c0e39' : 'transparent')
                }
                hoverEnabled: true

                MouseArea {
                    anchors.fill: parent
                    enabled: !iconItem.isDefault
                    cursorShape: enabled? Qt.PointingHandCursor : undefined

                    onClicked: (mouse) =>  {
                        Pipewire.preferredDefaultAudioSink = iconItem.modelData
                    }
                }
            }
        }

        Repeater {
            model: sinksView.sinks.length
            delegate: ToolSeparator {
                Layout.column: 1
                Layout.row: index*2
                Layout.rowSpan: 2
                Layout.fillHeight: true
                padding: 0
                required property int index
                contentItem: Rectangle {
                    implicitWidth: 1
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    color: "#c3c3c3"
                }
            }
        }

        Repeater {
            model: sinksView.sinks
            delegate: Text {
                Layout.rowSpan: 2
                Layout.column: 2
                Layout.row: index*2
                id: volText
                padding: 7
                required property int index
                required property var modelData

                text: (modelData.audio.volume * 100).toFixed(0) + '% '
                color: 'white'
                verticalAlignment: Text.AlignVCenter
            }
        }

        Repeater {
            model: sinksView.sinks
            delegate: Text {
                Layout.column: 3
                Layout.row: index*2
                Layout.alignment: Qt.AlignTop
                id: detailsText
                required property int index
                required property var modelData

                text: '(' + modelData.id +') ' + ' ' + Audio.getBluetoothCodec(modelData)
                color: 'white'
            }
        }

        Repeater {
            model: sinksView.sinks
            delegate: Slider {
                Layout.column: 3
                Layout.row: index*2+1
                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 2
                id: volSlider
                required property int index
                required property var modelData

                value: modelData.audio.volume
                onValueChanged: Qt.callLater(() => modelData.audio.volume = value)
            }
        }

        Repeater {
            model: sinksView.sinks
            delegate: ItemDelegate {
                Layout.rowSpan: 2
                Layout.column: 4
                Layout.row: index*2
                id: muteButton
                required property int index
                required property var modelData
                icon.name: modelData.audio.muted? 'audio-off' : 'audio-on'

                background: Rectangle {
                    color: 'transparent'
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: (mouse) =>  {
                        parent.modelData.audio.muted = !parent.modelData.audio.muted
                    }
                }
            }
        }

        PwObjectTracker {
            objects: sinksView.sinks
        }
    }
}