import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import qs.Widgets.Base
import qs.Singletons

ItemDelegate {
    id: control
    text: ((Power.percentage*100).toFixed(0) + '% ') + Power.wattage + 'W'
    icon.name: Power.icon
    icon.color: Theme.text
    font.family: Theme.fontFamily

    contentItem: IconLabel {
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: Theme.text
    }

    background: WidgetShape {
    }
}
