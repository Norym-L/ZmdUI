import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  暗色主题探针：加载演示内容后切到暗色主题再抓图。
  亮色主题的截图靠 tools/smoke.qml，这个专门用来核对暗色下的文字可读性。
*/
Window {
    id: probe
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_dark.png"
    /*! 抓图前先把内容区滚到指定位置（0 = 顶部，用于看卡片区） */
    property real scrollTo: 0

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
        onStatusChanged: if (status === Loader.Error) { console.log("DARK FAIL: loader"); Qt.exit(3) }
    }

    Component.onCompleted: Theme.mode = Theme.Mode.Dark

    Timer {
        interval: 1400
        running: true
        onTriggered: {
            if (loader.item && loader.item.contentY !== undefined)
                loader.item.contentY = probe.scrollTo
            grabTimer.start()
        }
    }
    Timer { id: grabTimer; interval: 400; onTriggered: doGrab() }
    Timer { interval: 15000; running: true; onTriggered: { console.log("DARK TIMEOUT"); Qt.exit(9) } }

    function doGrab() {
        probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(probe.outFile)
            console.log("DARK " + (ok ? "OK" : "FAIL") + " -> " + probe.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
}
