import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: subpodItem

    property var subpod
    property bool isVisible: true

    contentHeight: plainText.height + (image.status === Image.Ready ? image.height : loadingIndicator.height)
    contentWidth: width
    height: contentHeight + Theme.paddingSmall

    Label {
        id: plainText
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: Theme.horizontalPageMargin
            rightMargin: Theme.horizontalPageMargin
        }
        text: "Plain text: " + wap.getPlainText(subpod)
    }
    Image {
        id: image
        anchors {
            top: plainText.bottom
            left: parent.left
            right: parent.right
        }
        asynchronous: true
        cache: true
        fillMode: Image.Pad
        horizontalAlignment:  Image.AlignLeft
        source: wap.getImgSrc(subpod)

        anchors {
            rightMargin: Theme.horizontalPageMargin
            leftMargin: Theme.horizontalPageMargin
        }


        sourceSize.width: {
            var maxImageWidth = parent.width
            var leftMargin = Theme.horizontalPageMargin
            var rightMargin = Theme.horizontalPageMargin
            return maxImageWidth - leftMargin - rightMargin
        }

        BusyIndicator {
            id: loadingIndicator
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
