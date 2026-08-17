import Quickshell
import QtQuick

pragma ComponentBehavior: Bound

PopupWindow {
    color: 'transparent'
    id: popupWindowId
    required property var togglePopup
    required property int maxHeight
    required property int contentHeight
    readonly property int minHeight: 50
    implicitHeight: contentHeight < maxHeight? (contentHeight < minHeight? minHeight: contentHeight) : maxHeight
    property bool canBecomeVisible: true
    default property alias content: networkWindow.children
    readonly property alias popupWindow: popupWindowId

    Rectangle {
        id: networkWindow
        anchors.fill: parent
        color: '#b35156b3'
        radius: 10
        border.width: 1
        border.color: 'white'
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