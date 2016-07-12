import QtQuick 2.0
import io.thp.pyotherside 1.3

Python {
    property bool ready: false // True if init done succesfully

    id: py

    // Sets up handlers for events and signals from python module
    function __setHandlers() {
        setHandler('log-d', function (text) {
                    console.debug(text);
                });
        setHandler('log-i', function (text) {
                    console.info(text);
                });
        setHandler('log-e', function (text) {
                    console.error(text);
                });
    }

    function makeQuery(queryText) {
        return py.call_sync('WapAdapter.makeQuery', [queryText]);
    }


    Component.onCompleted: {
        if (!py.ready) {
            console.info("WapAdapter starting up...");
            console.info("Python version: " + pythonVersion());
            console.info("PyOtherSide version: " + pluginVersion());
            __setHandlers();
            addImportPath(Qt.resolvedUrl("../python/"));
            importModule_sync('WapAdapter');
            py.ready = true;
        }
    }

    onError: console.error("Exception: %1".arg(traceback));
}
