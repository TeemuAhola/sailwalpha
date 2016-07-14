import QtQuick 2.0
import Sailfish.Silica 1.0

Column {
    property var pod
    property bool _visible: true

    id: podView

    clip: true

    ListModel {
        id: subpodModel
    }

    Component.onCompleted: {
        sectionHeader.text = wap.getPodData(pod)['title'];
        var subpods = wap.getSubPods(pod);

        for (var i = 0; i < subpods.length; i++) {
            var subpodData = wap.getSubPodData(subpods[i]);
            subpodModel.append({'title':subpodData['title'],
                                'plaintext':subpodData['plaintext'],
                                'img':subpodData['img']})
        }
    }

    spacing: Theme.paddingSmall
    SectionHeader { id: sectionHeader }

    Repeater {
        id: subpodRepeater
        model: subpodModel
        delegate: Column {
            width: parent.width
            DetailItem { label: qsTr("title"); value: model.title; }
            DetailItem { label: qsTr("plaintext"); value: model.plaintext; }
            Image {
                width: parent.width
                id: name
                asynchronous: true
                fillMode: Image.PreserveAspectFit
                source: model.img['src']
            }
        }
    }

    IconButton {
        anchors.right: parent.right
        icon.source: "image://theme/icon-lock-more"

        onClicked: _visible = !_visible
    }

}

