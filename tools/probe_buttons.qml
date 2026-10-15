import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  按钮状态探针。三件事：

  1. 默认态断言：Danger 默认**不该**有左侧黄竖条和品红点（用户反馈过），
     平行四边形永远不该有竖条。
  2. 宽度不变量：同形态两个按钮宽度必须完全相等 —— 悬停逻辑一旦再动 padding 就会爆。
  3. 激活态渲染：先 requestActivate() 再 forceActiveFocus()，看离屏平台能否真的
     把 visualFocus 点亮（能点亮就能截出高亮态；点不亮就退化成断言 + 等价论证）。

  用法：qml.exe -I <repo>/qml tools/probe_buttons.qml     退出码 0 = 通过
*/
Window {
    id: probe
    width: 1040
    height: 560
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_buttons.png"

    Component.onCompleted: requestActivate()

    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }

    Column {
        x: 40
        y: 30
        spacing: 14

        Text {
            text: "第一行：Danger 默认态（不应有黄竖条、不应有品红点）· 第二个是平行四边形"
            font: Theme.fontMonoSm
            color: Theme.muted
        }

        Row {
            spacing: 24
            ZButton { id: dangerDefault; text: "删除配置"; variant: Theme.Variant.Danger; mono: "DEL" }
            ZButton { id: dangerSkew; text: "删除配置"; variant: Theme.Variant.Danger
                      mono: "DEL"; skew: 12 }
        }

        Text {
            text: "激活态：Secondary / Ghost / Primary（forceActiveFocus 后若生效，应在右侧出现黄竖条）"
            font: Theme.fontMonoSm
            color: Theme.muted
        }

        Row {
            spacing: 16
            ZButton { id: secOff; text: "扫码登录"; variant: Theme.Variant.Secondary; mono: "F2" }
            ZButton { id: secOn; text: "扫码登录"; variant: Theme.Variant.Secondary; mono: "F2" }
        }

        Row {
            spacing: 16
            ZButton { id: ghoOff; text: "了解更多"; variant: Theme.Variant.Ghost }
            ZButton { id: ghoOn; text: "了解更多"; variant: Theme.Variant.Ghost }
        }

        Row {
            spacing: 16
            ZButton { id: priOff; text: "一键配置并启动"; variant: Theme.Variant.Primary }
            ZButton { id: priOn; text: "一键配置并启动"; variant: Theme.Variant.Primary }
        }
    }

    // 窗口激活后再抢焦点：离屏平台也不一定给，所以下面会如实打印结果
    Timer {
        interval: 700
        running: true
        onTriggered: secOn.forceActiveFocus()
    }

    Timer {
        interval: 1600
        running: true
        onTriggered: {
            var ok = true

            // 1) 默认态断言
            console.log("BTN danger default : showEdge=" + dangerDefault.showEdge + " (expect false)")
            console.log("BTN danger + skew  : showEdge=" + dangerSkew.showEdge + " (expect false)")
            if (dangerDefault.showEdge !== false || dangerSkew.showEdge !== false)
                ok = false

            // 2) 宽度不变量
            var pairs = [["secondary", secOff, secOn], ["ghost", ghoOff, ghoOn],
                         ["primary", priOff, priOn]]
            for (var i = 0; i < pairs.length; i++) {
                var p = pairs[i]
                var same = Math.abs(p[1].width - p[2].width) < 0.01
                if (!same)
                    ok = false
                console.log("BTN " + p[0] + ": width " + p[1].width.toFixed(2) + " / "
                            + p[2].width.toFixed(2) + (same ? "  OK" : "  WIDTH-CHANGED"))
            }

            // 3) 激活态是否真的点亮了
            console.log("BTN visualFocus stuck? secOn=" + secOn.visualFocus
                        + " (true 则截图里右侧按钮带黄竖条，false 则离屏拿不到焦点)")
            if (secOn.visualFocus)
                console.log("BTN active state reached: secOn.showEdge=" + secOn.showEdge
                            + " (expect true)")

            console.log("BTN RESULT: " + (ok ? "PASS" : "FAIL"))
            probe.contentItem.grabToImage(function (res) {
                var saved = res.saveToFile(probe.outFile)
                console.log("BTN " + (saved ? "OK" : "SAVE-FAIL") + " -> " + probe.outFile)
                Qt.exit(ok && saved ? 0 : 1)
            })
        }
    }
    Timer { interval: 20000; running: true; onTriggered: { console.log("BTN TIMEOUT"); Qt.exit(9) } }
}
