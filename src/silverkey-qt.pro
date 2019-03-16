TARGET = silverkey-qt
TEMPLATE = app

QT += core gui network quick
CONFIG += c++14

SOURCES += \
        main.cpp \
        requester.cpp \
    worker.cpp \
    keysmodel.cpp \
    datamanager.cpp

HEADERS += \
        requester.h \
        focuscontroller.h \
        skappdelegate-c-interface.h \
    worker.h \
    keysmodel.h \
    datamanager.h

LIBS += -lyaml-cpp

include(UGlobalHotkey/uglobalhotkey.pri)
INCLUDEPATH += ./UGlobalHotkey

macx {
    HEADERS += \
            mac_service.h \
            skappdelegate.h \
            focuscontroller_mac.h
    DEFINES += ROBOT_OS_MAC
    INCLUDEPATH += /usr/local/Cellar/rapidjson/1.1.0/include
    INCLUDEPATH += /usr/local/include/Robot/
    LIBS += -L/usr/local/lib/robot -lRobot -framework ApplicationServices
    QMAKE_INFO_PLIST = ../contrib/Info.plist
    QMAKE_LFLAGS += -framework Cocoa
    OBJECTIVE_SOURCES += \
                        mac_service.mm \
                        focuscontroller_mac.mm \
                        skappdelegate.mm
}

linux {
    HEADERS += \
            focuscontroller_xcb.h
    SOURCES += \
            focuscontroller_xcb.cpp
    DEFINES += ROBOT_OS_LINUX
    INCLUDEPATH += /usr/local/include/Robot/
    LIBS += -lRobot -lXtst -lX11 -lxcb -lxcb-ewmh -lxdo
    QT += x11extras
}

windows {
    INCLUDEPATH += ../include/robot
    LIBS += -L$$PWD/../bin -lRobot

    SOURCES += focuscontroller_win.cpp
    HEADERS += focuscontroller_win.h

    target.path = $$PWD/../bin
    INSTALLS += target
}

RESOURCES += \
    qml.qrc \
    images.qrc


