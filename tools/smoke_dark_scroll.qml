import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  暗色分段滚动截图：用来逐屏审计暗色模式（亮色版是 smoke_scroll.qml）。
  用法同其他探针，产物为 tools/dark_0..N.png
*/
Window {
    id: tool
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property var offsets: [0, 900, 1800, 2700]
    property int idx: 0

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
    }

    Component.onCompleted: Theme.mode = Theme.Mode.Dark

    Timer {
        interval: 1300
        running: true
        onTriggered: tool.contentItem.grabToImage(function (res) { next(res) })
    }
    Timer { interval: 40000; running: true; onTriggered: { console.log("DARKSCROLL TIMEOUT"); Qt.exit(9) } }

    function next(res) {
        if (!loader.item) { console.log("DARKSCROLL FAIL: no item"); Qt.exit(2); return }
        var ok = res.saveToFile("C:/dev/ZmdUI/tools/dark_" + tool.idx + ".png")
        console.log("DARKSCROLL " + tool.idx + " contentY=" + loader.item.contentY + (ok ? " SAVED" : " FAIL"))
        tool.idx++
        if (tool.idx >= tool.offsets.length || !ok) { Qt.exit(ok ? 0 : 4); return }
        loader.item.contentY = tool.offsets[tool.idx]
        step.start()
    }
    Timer { id: step; interval: 420; onTriggered: tool.contentItem.grabToImage(function (res) { next(res) }) }
}
