import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: subpodItem

    property var subpod
    property bool isVisible: true
    contentHeight: plainText.height + image.height
    contentWidth: parent.width

    Label {
        id: plainText
        text: "Plain text: " + wap.getPlainText(subpod)
    }
    Image {
        id: image
        anchors.top: plainText.bottom
        asynchronous: true
        cache: true
        width: parent.width
        height: 100
        fillMode: Image.PreserveAspectFit
        verticalAlignment:  Image.AlignLeft
        source: wap.getImgSrc(subpod)

        BusyIndicator {
            size: BusyIndicatorSize.Small
            anchors.centerIn: image
            running: image.status != Image.Ready
        }
    }

    states: [
        State {
            name: "closed"; when: !isVisible
            PropertyChanges { target: subpodItem; opacity: 0; contentHeight: 0 }
        }
        ,State {
            name: "opened"; when: isVisible
            PropertyChanges { target: subpodItem; opacity: 1.0; contentHeight: plainText.height + image.height}
        }
    ]
    transitions: Transition {
        PropertyAnimation { properties: "opacity,contentHeight"; easing.overshoot: 1.2; duration: 400; easing.type: Easing.OutBack }
    }
}
