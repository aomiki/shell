import QtQuick
import qs.Popups.Base
import qs.Popups.Base.Audio
import qs.Singletons

pragma ComponentBehavior: Bound

PopupFrame {
    id: networkPopup

    contentHeight: sinksView.contentHeight

    SinksView {
        id: sinksView
        anchors.margins: 15
        sinks: Audio.hwSinks
    }
}
