#-------------------------------------------------
#
# Project created by QtCreator 2018-04-12T02:10:11
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = silverkey-qt
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        main.cpp \
        mainwindow.cpp \
    fuzzycompleter.cpp

HEADERS += \
        mainwindow.h \
    fuzzycompleter.h

FORMS += \
        mainwindow.ui

LIBS += \
       -lcurl

DEFINES += ROBOT_ARCH_64

macx {
    DEFINES += ROBOT_OS_MAC
    INCLUDEPATH += /usr/local/Cellar/rapidjson/1.1.0/include
    INCLUDEPATH += /usr/local/include/Robot/
    LIBS += -L/usr/local/lib/robot -lRobot -framework ApplicationServices
}

linux {
    DEFINES += ROBOT_OS_LINUX
    INCLUDEPATH += /usr/local/include/Robot/
    LIBS += -lRobot -lXtst -lX11
}

windows {
    DEFINES += ROBOT_OS_WIN
}

