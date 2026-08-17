pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string readableTime: Qt.formatDateTime(date, 'hh:mm AP')
  readonly property string readableDateTime: Qt.formatDateTime(date, 'dd MMMM yyyy hh:mm:ss AP (dddd)')

  readonly property date date: clock.date

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}