import QtQuick
import QtQuick.Shapes
import qs.Singletons

Shape {
    id: rectangleShape
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
        fillColor: control.active? Theme.accent : Theme.accentLight

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