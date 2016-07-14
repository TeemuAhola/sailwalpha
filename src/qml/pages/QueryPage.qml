import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Query")
            }
            SearchField {
                id: queryField
                width: parent.width
                color: Theme.secondaryHighlightColor
                placeholderText: qsTr("Enter what you want to know about")

                EnterKey.enabled: text.length > 0

                EnterKey.onClicked: {
                    pageStack.push(Qt.resolvedUrl("QueryResultPage.qml"), {'queryText': queryField.text})
                }
            }
        }
    }
}


