import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  无头冒烟自检：离屏渲染演示内容（qml/DemoContent.qml），抓图落盘后退出。
  退出码：0 = 成功；3 = 加载失败；4 = 抓图保存失败；9 = 超时（多半是 QML 报错卡死）。

  用法：
    QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software \
    QT_QPA_FONTDIR=C:/Windows/Fonts \
    qml.exe -I <repo>/qml <repo>/tools/smoke.qml
*/
Window {
    id: smoke
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    /*! 抓图输出路径 */
    property string outFile: "C:/dev/ZmdUI/tools/smoke.png"

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
        onStatusChanged: if (status === Loader.Error) {
            console.log("SMOKE FAIL: loader error")
            Qt.exit(3)
        }
    }

    // 等字体重排 + 首帧渲染稳定后再抓
    Timer {
        interval: 1500
        running: true
        onTriggered: doGrab()
    }

    Timer {
        interval: 20000
        running: true
        onTriggered: { console.log("SMOKE TIMEOUT"); Qt.exit(9) }
    }

    function doGrab() {
        console.log("SMOKE: window", width, "x", height,
                    "| contentItem", contentItem.width, "x", contentItem.height,
                    "| loaded", loader.status === Loader.Ready)
        contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(smoke.outFile)
            console.log("SMOKE " + (ok ? "OK" : "SAVE_FAIL") + " -> " + smoke.outFile)
            Qt.exit(ok ? 0 : 4)
        })
    }
}
