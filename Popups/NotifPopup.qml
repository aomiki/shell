import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Popups.Base
import qs.Singletons
import Quickshell.Services.Notifications

pragma ComponentBehavior: Bound

PopupFrame {
    contentHeight: scrollView.contentHeight

    ScrollView {
        id: scrollView
        anchors.fill: parent
        contentWidth: availableWidth
        GridLayout {
            anchors.fill: parent
            anchors.margins: 10
            id: notifWidgetContent
            flow: GridLayout.TopToBottom
            readonly property int maxHeight: 50

            Repeater {
                model: Notif.notifications
                delegate: ItemDelegate {
                    Layout.column: 0
                    Layout.row: index
                    Layout.maximumHeight: notifWidgetContent.maxHeight
                    Layout.maximumWidth: 50
                    background: Rectangle {
                        color: 'transparent'
                    }
                    required property int index
                    required property var modelData
                    readonly property Notification notif: modelData
                    id: appIcon
                    icon.name: notif.appIcon ?? ''
                    icon.source: notif.appIcon ?? ''
                }
            }

            Repeater {
                model: Notif.notifications
                delegate: Text {
                    id: appTitle

                    Layout.column: 1
                    Layout.row: index

                    required property int index
                    required property var modelData
                    readonly property Notification notif: modelData

                    font.weight: Font.Medium
                    color: '#ffffff'
                    verticalAlignment: Text.AlignVCenter
                    text: notif.appName ?? ''
                }
            }

            Repeater {
                model: Notif.notifications
                delegate: ToolSeparator {
                    Layout.column: 2
                    Layout.fillHeight: true
                    Layout.row: index
                    required property int index
                    required property var modelData
                    readonly property Notification notif: modelData

                    contentItem: Rectangle {
                        implicitWidth: 1
                        color: "#c3c3c3"
                    }
                }
            }
            
            Repeater {
                model: Notif.notifications
                delegate: Image {
                    Layout.column: 3
                    Layout.row: index
                    required property int index
                    required property var modelData
                    readonly property Notification notif: modelData
                    Layout.maximumHeight: notifWidgetContent.maxHeight
                    Layout.maximumWidth: 50

                    fillMode: Image.PreserveAspectFit
                    source: notif?.image.toString() ?? ''
                }
            }

            Repeater {
                model: Notif.notifications
                delegate: ItemDelegate {
                    id: notifText

                    Layout.column: 4
                    Layout.row: index
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 1

                    required property int index
                    required property var modelData
                    readonly property Notification notif: modelData
                    contentItem: Text {
                        text: notif?.body ?? ''
                        font.family: 'SFProDisplay Nerd Font'
                        font.weight: Font.Medium
                        color: '#ffffff'
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }

                    background: Rectangle {
                        color: notifText.hovered? '#980c0e39' : 'transparent'
                    }
                    hoverEnabled: true

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            parent.notif.tracked = false
                        }
                    }
                }
            }

            Repeater {
                model: Notif.notifications
                delegate: ItemDelegate {
                    id: cancelButton
                    Layout.column: 5
                    Layout.row: index
                    Layout.maximumHeight: notifWidgetContent.maxHeight
                    Layout.preferredWidth: height
                    required property int index
                    required property var modelData
                    readonly property Notification notif: modelData
                    icon.name: 'cancel'
                    icon.width: width/2
                    icon.height: height/2
                    contentItem.anchors.centerIn: cancelButton

                    background: Rectangle {
                        color: 'transparent'
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            parent.notif.tracked = false
                        }
                    }
                }
            }
        }
    }
}
