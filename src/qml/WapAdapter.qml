import QtQuick 2.0
import Sailfish.Silica 1.0
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

    function setSizeParameters(width, maxwidth, plotwidth, magnification) {
        return py.call_sync('WapAdapter.setSizeParameters', [width, maxwidth, plotwidth, magnification]);
    }

    function makeQuery(queryText) {
        return py.call_sync('WapAdapter.makeSimpleQuery', [queryText]);
    }

    function saveQuery(query, path) {
        return py.call_sync('WapAdapter.saveQuery', [query, path]);
    }

    function loadQuery(path) {
        return py.call_sync('WapAdapter.loadQuery', [path]);
    }

    function getAttribute(obj) {
        var argArray = Array.prototype.slice.call(arguments); // includes obj
        return py.call_sync('WapAdapter.getAttribute', argArray);
    }

    function getPods(query) {
        return getAttribute(query, 'pods');
    }

    function getSubpods(pod) {
        return getAttribute(pod, 'subpods');
    }

    // get title of pod or subpod
    function getTitle(pod) {
        return getAttribute(pod, 'title');
    }

    function getPlainText(subpod) {
        return getAttribute(subpod, 'plaintext');
    }

    function getImgSrc(subpod) {
        return getAttribute(subpod, 'img', 'src'); // subpod.img.src
    }

    Component.onCompleted: {
        if (!py.ready) {
            console.info("WapAdapter starting up...");
            console.info("Python version: " + pythonVersion());
            console.info("PyOtherSide version: " + pluginVersion());
            __setHandlers();
            addImportPath(Qt.resolvedUrl("../python/"));
            importModule_sync('WapAdapter');
            setSizeParameters(Screen.width - Theme.horizontalPageMargin*2,
                              Screen.width,
                              Screen.width - Theme.horizontalPageMargin*2,
                              2.5);
            py.ready = true;
        }
    }

    onError: console.error("Exception: %1".arg(traceback));
}
