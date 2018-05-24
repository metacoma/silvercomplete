#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "fuzzycompleter.h"

#define KEYBOARD_SPEED 20

#ifdef Q_OS_MACOS
#define SK_UI_FORK
#endif


namespace Ui {
class MainWindow;
}

class MainWindow : public FuzzyLineEdit
{

public:
    explicit MainWindow(QWidget *parent = 0);
    void EnterPressed();
    void EndOfWorkflow();
    void SearchEvent();
    void hideEvent(QHideEvent *e);
    void setWriteFd(int fd);
    void setData(std::string d);
    void getDbData();
    void setResultPtr(QString *ptr);
public slots:
    void showSettings();
    void setAngleCorners();
    void setRoundedCorners();
    void handleDataLoad();

private:
    void lockInput();
    void unlockInput();
    Q_OBJECT
    std::map<std::string, std::string> kvpairs;
    int wfd;
    QAction *settingsAcc;
    std::string data = "";
    QString *resultPtr;

protected:
#ifndef QT_NO_CONTEXTMENU
    void contextMenuEvent(QContextMenuEvent *event) override;
#endif // QT_NO_CONTEXTMENU
    void keyPressEvent(QKeyEvent *e);
};

#endif // MAINWINDOW_H
