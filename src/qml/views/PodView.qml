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
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: title.height + extraButton.height

                IconButton {
                    id: expandButton
                    icon.source: "image://theme/icon-m-right"

                    rotation: _isVisible ? 90 : 0
                    Behavior on rotation { NumberAnimation { duration: 400; } }

                    onClicked: {
                        for (var i=0; i < subpodRepeater.count; i++) {
                            subpodRepeater.itemAt(i).isVisible = !subpodRepeater.itemAt(i).isVisible;
                        }
                        _isVisible = !_isVisible;
                    }
                }

                Label {
                    id: title
                    anchors {
                        left: expandButton.right
                        right: parent.right
                        rightMargin: Theme.paddingSmall
                        leftMargin: Theme.paddingMedium
                    }
                    height: Theme.itemSizeExtraSmall
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: Theme.fontSizeSmall
                    truncationMode: TruncationMode.Fade                    
                    color: Theme.highlightColor
                    text: wap.getTitle(pod);
                }

                IconButton {
                    anchors {
                        left: parent.left
                        top: expandButton.bottom
                        rightMargin: Theme.paddingSmall
                        leftMargin: Theme.paddingSmall
                    }

                    id: extraButton
                    icon.source: "image://theme/icon-m-add"
                }

                IconButton {
                    anchors {
                        left: extraButton.right
                        top: expandButton.bottom
                        rightMargin: Theme.paddingSmall
                        leftMargin: Theme.paddingSmall
                    }

                    id: infoButton
                    icon.source: "image://theme/icon-m-about"
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

