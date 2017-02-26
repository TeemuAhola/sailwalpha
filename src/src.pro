# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-sailwalpha

CONFIG += sailfishapp

SOURCES += \
    src/harbour-sailwalpha.cpp

OTHER_FILES += \
    ../rpm/harbour-sailwalpha.spec \
    ../rpm/harbour-sailwalpha.changes \
    ../rpm/harbour-sailwalpha.yaml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-sailwalpha-fi.ts

DISTFILES += \
    harbour-sailwalpha.desktop \
    qml/* \
    qml/cover/* \
    qml/pages/* \
    python/* \
    translations/*.ts \
    qml/WapAdapter.qml \
    qml/pages/QueryResultPage.qml \
    qml/views/PodView.qml \
    qml/views/AssumptionsView.qml \
    qml/views/SubPodView.qml

python.files = python
python.path = /usr/share/$${TARGET}

INSTALLS += python
