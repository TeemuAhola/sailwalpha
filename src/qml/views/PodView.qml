import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    property var pod
    property bool _isVisible: true

    id: podView

    contentHeight: subpodColumn.height
    clip: true

    Component.onCompleted: {
        var subpods = wap.getSubpods(pod);
        subpodRepeater.model = subpods;
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

            Item {
                anchors.left: parent.left;
                anchors.right: parent.right;
                height: title.height

                IconButton {
                    id: expandButton
                    icon.source: "image://theme/icon-m-right"

                    rotation: _isVisible ? 90 : 0
                    Behavior on rotation { NumberAnimation { duration: 300; } }

                    onClicked: {
                        for (var i=0; i < subpodRepeater.count; i++) {
                            subpodRepeater.itemAt(i).isVisible = !subpodRepeater.itemAt(i).isVisible;
                        }
                        _isVisible = !_isVisible;
                    }
                }

                Label {
                    id: title
                    x: Theme.horizontalPageMargin
                    height: Theme.itemSizeExtraSmall
                    width: (parent ? parent.width : Screen.width) - x*2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: Theme.fontSizeSmall
                    truncationMode: TruncationMode.Fade
                    color: Theme.highlightColor
                    text: wap.getTitle(pod);
                }
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

