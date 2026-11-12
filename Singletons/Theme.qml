pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // text
    readonly property color text:        '#ffffff'
    readonly property color textMuted:   '#c3c3c3'
    readonly property color textOnLight: 'black'

    // surfaces
    readonly property color bar:         '#988288ff'
    readonly property color popupBg:     '#b35156b3'
    readonly property color popupBorder: 'white'
    readonly property color hover:       '#980c0e39'
    readonly property color selected:    '#d10c0e39'
    readonly property color accent:      '#0b6b9b'
    readonly property color accentLight: '#25acef'

    // fonts
    readonly property string fontFamily: 'SFProDisplay Nerd Font'
}
