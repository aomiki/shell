import QtQuick
import QtQuick.Controls
import qs.Widgets.Base
import qs.Singletons

ItemDelegate {
    id: control
    text: ((Power.percentage*100).toFixed(0) + '% ') + Power.wattage + 'W'
    icon.name: Power.icon
    font.family: 'SFProDisplay Nerd Font'

    background: WidgetShape {
    }
}
