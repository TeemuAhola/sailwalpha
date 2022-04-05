import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    function _queryCompletedCb(queryResult) {
        wap.saveQuery(queryResult, "/tmp/sailwalpha_query.bin")
        busy.running = false;
        pageStack.push(Qt.resolvedUrl("QueryResultPage.qml"), {'query': queryResult})
    }

    function _makeQuery(queryText) {
        busy.running = true;
        wap.makeQuery(queryText, _queryCompletedCb);
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "Load query"
                onClicked: {
                    var query = wap.loadQuery("/tmp/sailwalpha_query.bin");
                    pageStack.push(Qt.resolvedUrl("QueryResultPage.qml"), {'query': query})
                }
            }
        }

        PageHeader {
            id: header
            title: qsTr("Query")
        }

        SearchField {
            id: queryField
            anchors {left: parent.left; right: parent.right; top: header.bottom }
            color: Theme.secondaryHighlightColor
            placeholderText: qsTr("Make question")

            EnterKey.enabled: text.length > 0
            EnterKey.onClicked: _makeQuery(text)
        }

        BusyIndicator {
            id: busy
            anchors { top: queryField.bottom; horizontalCenter: parent.horizontalCenter }
            size: BusyIndicatorSize.Large
            running: false
        }
}
}


