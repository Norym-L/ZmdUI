import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  分段滚动截图：窗口放不下全部区块，因此按 offsets 依次滚动并抓图，
  一屏一张，便于逐段核对渲染结果。
  用法同 smoke.qml。
*/
Window {
    id: tool
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property var offsets: [0, 900, 1800, 2700, 3600]
    property int idx: 0
    property string dir: "C:/dev/ZmdUI/tools/"

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
        onStatusChanged: if (status === Loader.Error) { console.log("SCROLL FAIL: loader"); Qt.exit(3) }
    }

    Timer {
        interval: 1200
        running: true
        onTriggered: tool.contentItem.grabToImage(function (res) {
            grabNext(res)
        })
    }

    Timer { interval: 40000; running: true; onTriggered: { console.log("SCROLL TIMEOUT"); Qt.exit(9) } }

    function grabNext(res) {
        if (!loader.item) { console.log("SCROLL FAIL: no item"); Qt.exit(2); return }
        var name = tool.dir + "scroll_" + tool.idx + ".png"
        var ok = res.saveToFile(name)
        console.log("SCROLL " + tool.idx + " contentY=" + loader.item.contentY
                    + " total=" + loader.item.contentHeight + (ok ? " SAVED" : " FAIL"))
        tool.idx++
        if (tool.idx >= tool.offsets.length || !ok) {
            Qt.exit(ok ? 0 : 4)
            return
        }
        loader.item.contentY = tool.offsets[tool.idx]
        stepTimer.start()
    }

    Timer {
        id: stepTimer
        interval: 420
        onTriggered: tool.contentItem.grabToImage(function (res) { grabNext(res) })
    }
}
