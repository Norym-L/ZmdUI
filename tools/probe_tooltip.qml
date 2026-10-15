import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  工具提示探针：把 ZToolTip 强制展开（不给它悬停的机会），专门核对
  左侧亮黄竖边与底板斜边是否贴齐 —— 之前用直边矩形画竖条，
  顶部会戳出平行四边形之外，用户一眼就看出来了。
*/
Window {
    id: probe
    width: 760
    height: 300
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_tooltip.png"

    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }

    Row {
        x: 40
        y: 60
        spacing: 40

        ZButton {
            id: hostA
            text: "同步余额"
            variant: Theme.Variant.Primary
            ZToolTip { text: "同步最近 24 小时余额变动"; visible: true; delay: 0 }
        }

        ZButton {
            id: hostB
            text: "扫码登录"
            variant: Theme.Variant.Secondary
            mono: "F2"
            ZToolTip { text: "打开二维码窗口"; visible: true; delay: 0 }
        }

        ZIconButton {
            id: hostC
            glyph: "≡"
            ZToolTip { text: "菜单"; visible: true; delay: 0 }
        }
    }

    Timer {
        interval: 1200
        running: true
        onTriggered: probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(probe.outFile)
            console.log("TOOLTIP " + (ok ? "OK" : "FAIL") + " -> " + probe.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
    Timer { interval: 15000; running: true; onTriggered: { console.log("TOOLTIP TIMEOUT"); Qt.exit(9) } }
}
