import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Popups.Base
import qs.Singletons

pragma ComponentBehavior: Bound

PopupFrame {
    id: datePopup

    contentHeight: monthView.height
    maxHeight: contentHeight

    readonly property date currDate: Time.date
    readonly property int currDay: currDate.getDate()

    GridLayout {
        id: monthView
        anchors.fill: parent
        columns: 1
        anchors.margins: 10

        Text {
            text: Time.readableDateTime
            color: 'white'
        }

        DayOfWeekRow {
            Layout.fillWidth: true
            id: header
            locale: grid.locale
        }

        MonthGrid {
            id: grid

            Layout.fillWidth: true
            Layout.fillHeight: true
            month: datePopup.currDate.getMonth()
            year: datePopup.currDate.getFullYear()
            locale: Qt.locale("en_US")
            delegate: Rectangle {
                readonly property bool isToday: (model.month == grid.month) && (model.day == datePopup.currDay) && (model.year == grid.year)
                required property var model
                color: isToday? 'white' : 'transparent'
                radius: 4
                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: parent.model.month === grid.month ? 1 : 0
                    text: parent.model.day
                    font: grid.font
                    color: parent.isToday? 'black' : grid.palette.text
                }
            }
        }
    }
}
