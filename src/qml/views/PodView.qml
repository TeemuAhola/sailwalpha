import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    property var pod
    property bool _visible: true

    id: podView

    contentHeight: subpodView.height
    clip: true

    ListModel {
        id: subpodModel
    }

    Component.onCompleted: {
        var subpods = pod.subpods;

        for (var i = 0; i < subpods.count; i++) {
            var s = subpods.get(i);
            subpodModel.append(s);
        }
    }

    onClicked: {
        for (var i=0; i < subpodRepeater.count; i++) {
            subpodRepeater.itemAt(i).isVisible = !subpodRepeater.itemAt(i).isVisible;
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: "white"
        radius: 20
        color: Theme.rgba(Theme.highlightDimmerColor,
                          Theme.highlightBackgroundOpacity)

        Column {
            id: subpodView
            anchors.left: parent.left;
            anchors.right: parent.right;

            SectionHeader {
                id: title
                text: pod.title;
            }

            Repeater {
                id: subpodRepeater
                model: subpodModel

                delegate: ListItem {
                    id: subpodItem
                    property bool isVisible: true
                    contentHeight: plainText.height + image.height
                    Label {
                        id: plainText
                        text: "Plain text: " + model.plaintext
                    }
                    Image {
                        id: image
                        anchors.top: plainText.bottom
                        asynchronous: true
                        fillMode: Image.PreserveAspectFit
                        source: model.img['src']
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
            }
        }
    }
}

