import QtQuick
import QtQuick.Shapes

Shape {
    id: rectangleShape
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
        fillColor: control.active? '#0b6b9b' : '#25acef'

        PathRectangle {
            width: rectangleShape.width
            height: rectangleShape.height
            topLeftRadius: 0
            bottomRightRadius: 0
            bottomLeftRadius: 30
            topRightRadius: 30
            bevel: true
        }
    }
}