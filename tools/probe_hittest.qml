import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  命中测试探针：回答"这一项为什么点不上"。

  做法：把每个可点元素中心的坐标换算到窗口坐标，再用 childAt() 从窗口根一路往下钻，
  打印出**最上层**的元素链。如果链子最后落到的不是该项自己的 MouseArea，
  就说明有东西盖在它上面 —— 这就是"按不上"的直接证据（不用猜）。

  同时扫一遍侧边栏中轴线，把每一段的顶层元素列出来，用来找覆盖层。
*/
Window {
    id: probe
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/hittest.txt"
    property var report: []

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
    }

    // QML 的 toString() 形如 "ZSideBar_QMLTYPE_123(0x...)"，先把 _QMLTYPE_ 之后切掉
    function typeName(o) {
        var s = o.toString()
        var i = s.indexOf("_QMLTYPE")
        return i > 0 ? s.substring(0, i) : s.substring(0, s.indexOf("("))
    }

    // 从根往下钻，打印命中的元素链
    function chain(root, x, y, maxDepth) {
        var out = []
        var item = root
        var px = x
        var py = y
        for (var d = 0; d < maxDepth; d++) {
            var c = item.childAt(px, py)
            if (!c)
                break
            out.push(typeName(c) + "(" + Math.round(c.x) + "," + Math.round(c.y) + " "
                     + Math.round(c.width) + "x" + Math.round(c.height) + ")")
            var m = c.mapFromItem(root, x, y)
            px = m.x
            py = m.y
            item = c
        }
        return out.join(" > ")
    }

    function collectByType(item, name, out) {
        var kids = item.children
        if (!kids)
            return
        for (var i = 0; i < kids.length; i++) {
            var c = kids[i]
            if (typeName(c) === name)
                out.push(c)
            collectByType(c, name, out)
        }
    }

    function collectFlickables(item, out) {
        var kids = item.children
        if (!kids)
            return
        for (var i = 0; i < kids.length; i++) {
            var c = kids[i]
            if (typeName(c) === "QQuickFlickable")
                out.push(c)
            collectFlickables(c, out)
        }
    }

    function run() {
        var win = loader.item
        if (!win)
            return
        var rootItem = probe.contentItem

        // 先把页面滚到最底：表格在内容 y≈2600 处，不滚动的话根本不在视口里
        var fl = []
        collectFlickables(rootItem, fl)
        for (var f = 0; f < fl.length; f++) {
            if (fl[f].contentHeight > 1000) {
                fl[f].contentY = fl[f].contentHeight - fl[f].height   // 手动夹到最大值
                console.log("SCROLL contentHeight=" + fl[f].contentHeight
                            + " maxY=" + Math.round(fl[f].contentHeight - fl[f].height)
                            + " viewport=" + Math.round(fl[f].height)
                            + " y=" + Math.round(fl[f].y))
            }
        }
        var tables = []
        collectByType(rootItem, "ZTable", tables)
        var bars = []
        collectByType(rootItem, "ZSideBar", bars)

        console.log("FOUND ZTable=" + tables.length + " ZSideBar=" + bars.length)

        // 1) 侧边栏中轴线扫描：看有没有覆盖层
        if (bars.length > 0) {
            console.log("SIDEBAR scan x=120")
            for (var y = 120; y <= 780; y += 46) {
                console.log("  y=" + y + " -> " + chain(rootItem, 120, y, 18))
            }
        }

        // 1.5) 底部装饰条的位置（用来判断是否盖住最后一行）
        var footers = []
        collectByType(rootItem, "ZCutRect", footers)
        console.log("VIEWPORT bottom check")
        console.log("  windowH=" + Math.round(rootItem.height))

        // 2) 表格每一行的中心命中链
        if (tables.length > 0) {
            var t = tables[0]
            console.log("TABLE " + Math.round(t.width) + "x" + Math.round(t.height))
            var rows = []
            for (var k = 0; k < t.children.length; k++) {
                var ch = t.children[k]
                if (Math.abs(ch.height - 38) < 0.5)     // rowHeight = 38
                    rows.push(ch)
            }
            console.log("  rows=" + rows.length)
            for (var r = 0; r < rows.length; r++) {
                var p = rows[r].mapToItem(rootItem, rows[r].width / 2, rows[r].height / 2)
                console.log("  row" + r + " centerY=" + Math.round(p.y) + " -> " + chain(rootItem, p.x, p.y, 18))
            }
        }

        Qt.exit(0)
    }

    Timer { interval: 1500; running: true; onTriggered: run() }
    Timer { interval: 20000; running: true; onTriggered: { console.log("HITTEST TIMEOUT"); Qt.exit(9) } }
}
