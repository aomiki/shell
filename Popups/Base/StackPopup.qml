import QtQuick
import QtQuick.Controls

pragma ComponentBehavior: Bound

PopupFrame {
    property alias backButton: backButton
    property alias rightTopButton: reloadButton
    property alias stack: stack
    contentHeight: stack.currentItem.implicitHeight + reloadButton.height

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