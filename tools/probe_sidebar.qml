import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  侧边栏滚动条探针。

  用户反馈：窗口变矮时导航溢出，滚动条浮在内容上盖住了右侧的编号/徽标。
  这里用 1200x640 的矮窗口复现溢出，分别抓"开滚动条"和"关滚动条"两张图，
  并打印滚动条与行的几何关系，用来确认占位是否生效。

  用法：qml.exe -I qml tools/probe_sidebar.qml
*/
Window {
    id: probe
    width: 1200
    height: 640
    visible: true
    color: Theme.bg

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
    }

    function typeName(o) {
        var s = o.toString()
        var i = s.indexOf("_QMLTYPE")
        return i > 0 ? s.substring(0, i) : s.substring(0, s.indexOf("("))
    }

    function collect(item, name, out) {
        var kids = item.children
        if (!kids)
            return
        for (var i = 0; i < kids.length; i++) {
            if (typeName(kids[i]) === name)
                out.push(kids[i])
            collect(kids[i], name, out)
        }
    }

    function report(tag) {
        var bars = []
        collect(probe.contentItem, "ZSideBar", bars)
        if (!bars.length) {
            console.log("SIDEBAR not found")
            return
        }
        var b = bars[0]
        var fls = []
        collect(b, "QQuickFlickable", fls)
        var f = fls[0]
        console.log(tag + ": navScrollBar=" + b.navScrollBar
                    + " reserve=" + b.navScrollBarReserve
                    + " contentH=" + Math.round(f.contentHeight)
                    + " viewportH=" + Math.round(f.height)
                    + " overflow=" + (f.contentHeight > f.height))
    }

    Timer {
        interval: 1000
        running: true
        onTriggered: {
            report("ON ")
            probe.contentItem.grabToImage(function (res) {
                res.saveToFile("C:/dev/ZmdUI/tools/sidebar_bar_on.png")
                probe.contentItem.grabToImage  // noop
                step.start()
            })
        }
    }

    Timer {
        id: step
        interval: 500
        onTriggered: {
            var bars = []
            collect(probe.contentItem, "ZSideBar", bars)
            bars[0].navScrollBar = false          // 关掉滚动条
            offTimer.start()
        }
    }

    Timer {
        id: offTimer
        interval: 600
        onTriggered: {
            report("OFF")
            probe.contentItem.grabToImage(function (res) {
                res.saveToFile("C:/dev/ZmdUI/tools/sidebar_bar_off.png")
                console.log("SIDEBAR PROBE done")
                Qt.exit(0)
            })
        }
    }
    Timer { interval: 20000; running: true; onTriggered: { console.log("SIDEBAR TIMEOUT"); Qt.exit(9) } }
}
