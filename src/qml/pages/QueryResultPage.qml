import QtQuick 2.0
import Sailfish.Silica 1.0
import "../views"

Page {

    property string queryText

    Component.onCompleted: {
        var query = wap.makeQuery(queryText);
        var pods = wap.getPods(query);
        podRepeater.model = pods;
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge
        contentWidth: parent.width

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: "Query results" }

            Repeater {
                id: podRepeater
                delegate: PodView {
                    width: parent.width
                    pod: model.modelData
                }
            }

        }
    }
}
