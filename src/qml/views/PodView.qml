import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    property var pod
    property bool _visible: true

    id: podView

    contentHeight: subpodColumn.height
    clip: true

    Component.onCompleted: {
        var subpods = wap.getSubpods(pod);
        subpodRepeater.model = subpods;
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
            id: subpodColumn
            anchors.left: parent.left;
            anchors.right: parent.right;

            SectionHeader {
                id: title
                text: wap.getTitle(pod);
            }

            Repeater {
                id: subpodRepeater

                delegate: SubPodView {
                    subpod: model.modelData
                }
            }
        }
    }
}

