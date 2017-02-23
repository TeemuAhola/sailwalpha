import QtQuick 2.0
import Sailfish.Silica 1.0
import "../views"

Page {

    property string queryText

    Component.onCompleted: {
        var query = wap.makeQuery(queryText);
        var pods = wap.getPods(query);

        for (var i=0; i<pods.length; i++)
            resultModel.append(pods[i]);
    }

    SilicaListView {
        id: podView
        anchors.fill: parent
        clip: true

        model: ListModel { id: resultModel }

        header: PageHeader { title: qsTr("Query results") }

        VerticalScrollDecorator { flickable: podView }

        delegate: PodView {
            width: ListView.view.width
            pod: model
        }
    }
}
