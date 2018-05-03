#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "fuzzycompleter.h"

#define KEYBOARD_SPEED 20

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{

public:
    explicit MainWindow(QWidget *parent = 0);
    void EnterPressed();
    void EndOfWorkflow();
    void SearchEvent();
    void hideEvent(QHideEvent *e);
    void setWriteFd(int fd);
    void setData(std::string d);
public slots:
    void showSettings();

private:
    Q_OBJECT
    Ui::MainWindow *ui;
    FuzzyLineEdit *lineEdit;
    std::map<std::string, std::string> kvpairs;
    int wfd;
    QAction *settingsAcc;
    std::string data = "";

protected:
#ifndef QT_NO_CONTEXTMENU
    void contextMenuEvent(QContextMenuEvent *event) override;
#endif // QT_NO_CONTEXTMENU
};

#endif // MAINWINDOW_H
