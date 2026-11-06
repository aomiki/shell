import QtQuick
import qs.Popups.Base
import qs.Popups.Base.Audio
import qs.Singletons

pragma ComponentBehavior: Bound

PopupFrame {
    id: audioPopup

    contentHeight: sinksView.contentHeight + sinksView.topPadding + sinksView.bottomPadding

    SinksView {
        id: sinksView
        padding: 15
        sinks: Audio.hwSinks
    }
}
