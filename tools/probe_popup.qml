import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  弹层类组件探针：工具提示与对话框默认不显示（要悬停 / 要打开），
  静态截图里看不到，所以这里强制展开后抓图核对。
*/
Window {
    id: probe
    width: 1000
    height: 660
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_popup.png"

    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }
    ZHatchPattern {
        anchors.right: parent.right
        anchors.top: parent.top
        width: 260
        height: 150
        lineColor: Theme.hatch
        spacing: 12
    }

    ZSectionTitle {
        x: 40
        y: 30
        index: "07"
        eyebrow: "POPUP / OVERLAY"
        title: "弹层"
        subtitle: "TOOLTIP & DIALOG"
    }

    Row {
        x: 40
        y: 190
        spacing: 18

        // 工具提示：强制展开
        ZButton {
            id: tipHost
            text: "同步余额"
            variant: Theme.Variant.Primary
            mono: "SYNC"

            ZToolTip {
                id: tip
                text: "同步最近 24 小时余额变动"
                visible: true
                delay: 0
            }
        }

        ZButton { text: "次要按钮"; variant: Theme.Variant.Secondary }
        ZIconButton { glyph: "◎"; tone: Theme.Tone.Accent }
    }

    // 对话框：打开状态
    ZDialog {
        id: dlg
        title: "覆盖本地配置"
        code: "SYS-04"
        subtitle: "此操作不可撤销"
        confirmText: "确认覆盖"
        cancelText: "取消"
        width: 560
        Component.onCompleted: open()

        Column {
            width: parent.width
            spacing: 14

            Text {
                width: parent.width
                wrapMode: Text.WordWrap
                text: "检测到本地已存在配置文件 bot_007.json。继续操作将用工作区配置覆盖本地文件，"
                      + "原有账号信息与历史数据会保留。"
                font: Theme.fontBody
                color: Theme.inkSoft
            }

            ZTable {
                width: parent.width
                columns: [
                    { title: "文件", key: "file" },
                    { title: "修改时间", key: "time", align: "right" }
                ]
                rows: [
                    { file: "bot_007.json", time: "2026-10-14 21:03" },
                    { file: "session.dat", time: "2026-10-15 09:12" }
                ]
            }

            Row {
                spacing: 8
                ZTag { text: "备份已就绪"; tone: Theme.Tone.Accent }
                ZTag { text: "3.2 KB" }
            }
        }
    }

    Timer {
        interval: 1600
        running: true
        onTriggered: probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(probe.outFile)
            console.log("PROBE " + (ok ? "OK" : "FAIL") + " -> " + probe.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
    Timer { interval: 15000; running: true; onTriggered: { console.log("PROBE TIMEOUT"); Qt.exit(9) } }
}
