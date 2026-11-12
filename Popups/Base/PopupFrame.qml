import Quickshell
import QtQuick
import qs.Singletons

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
        color: Theme.popupBg
        radius: 10
        border.width: 1
        border.color: Theme.popupBorder
        // default-styled controls inside popups read their colours from here
        palette.text: Theme.text
        palette.windowText: Theme.text
        palette.buttonText: Theme.text
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