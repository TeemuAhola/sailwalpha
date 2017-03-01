import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow
{
    property var wap: WapAdapter { }

    initialPage: Component { QueryPage { } }
    cover: Component { CoverPage { } }
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    onOrientationChanged: {
        if (orientation === Orientation.Portrait)
            console.log("orientation portrait")
        else
            console.log("orientation landscape")
    }
}


