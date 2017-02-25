import QtQuick 2.0
import Sailfish.Silica 1.0
import "../views"

Page {
    property var query

    Component.onCompleted: {
        podView.model = wap.getPods(query);
    }

    SilicaListView {
        id: podView
        anchors.fill: parent
        clip: true

        header: PageHeader {
            title: qsTr("Query results")
            extraContent.children: [ Label { text: "extraa" } ]
        }

        VerticalScrollDecorator { flickable: podView }

        delegate: PodView {
            width: ListView.view.width
            pod: model.modelData
        }
    }
}
