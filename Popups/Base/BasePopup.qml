import Quickshell
import QtQuick
import QtQuick.Controls

pragma ComponentBehavior: Bound

PopupWindow {
    color: 'transparent'
    required property var togglePopup
    property alias backButton: backButton
    property alias rightTopButton: reloadButton
    property alias stack: stack
    property bool canBecomeVisible: true

    Rectangle {
        id: networkWindow
        anchors.fill: parent
        color: '#b35156b3'
        radius: 10
        border.width: 1
        border.color: 'white'
        ItemDelegate {
            id: backButton
            icon.name: 'arrow-left'
            visible: stack.depth > 1
            anchors.top: parent.top
            anchors.left: parent.left
            background: Rectangle {
                color: 'transparent'
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: (mouse) => {
                    stack.pop()
                }
            }
        }
        ItemDelegate {
            id: reloadButton
            icon.name: 'reload'
            visible: false
            anchors.top: parent.top
            anchors.right: parent.right
            background: Rectangle {
                color: 'transparent'
            }
            Component.onCompleted: {
                mouseArea.clicked.connect(reloadButton.clicked)
            }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }

        PopupStack {
            id: stack
            anchors.top: backButton.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    function toggleVisibility()
    {
        if (visible) {
            visible = false
            return
        }
        if (canBecomeVisible) {
            visible = true
        }
    }

    onClosed: () =>
    {
        console.log('Window closed! ' + objectName)
        canBecomeVisible = visible = false
    }
    onResourcesLost: () =>
    {
        console.log('Resource lost on window! ' + objectName)
        canBecomeVisible = visible = false
    }

}