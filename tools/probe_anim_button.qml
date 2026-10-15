import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  在真实 ZButton 上验证"状态切换有过渡动画"。

  做法：把按钮的 enabled 从 true 翻到 false（走的是和悬停同一条 _fill 绑定分支、
  同一个 Behavior on color），翻转后 120ms 抓一张、800ms 再抓一张。
  如果颜色是瞬变的，两张图会逐字节相同；只要动画真的在插值，两张必然不同。

  图片落盘后用 cmp 比对（QML 侧没有像素读取 API）。
*/
Window {
    id: probe
    width: 420
    height: 160
    visible: true
    color: Theme.bg

    ZButton {
        id: target
        x: 40
        y: 50
        text: "删除配置"
        variant: Theme.Variant.Danger
        mono: "DEL"
    }

    function snap(name, after) {
        probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile("C:/dev/ZmdUI/tools/" + name)
            console.log("ANIM2 " + name + (ok ? " saved" : " SAVE-FAIL"))
            if (after)
                after()
        })
    }

    Timer {
        interval: 700
        running: true
        onTriggered: {
            snap("anim_before.png", function () {
                target.enabled = false        // ← 触发状态切换
                midTimer.start()
            })
        }
    }

    Timer { id: midTimer; interval: 120; onTriggered: snap("anim_mid.png", function () { endTimer.start() }) }
    Timer { id: endTimer; interval: 800; onTriggered: snap("anim_end.png", function () {
        console.log("ANIM2 已落盘 anim_before / anim_mid / anim_end，请用 cmp 比对")
        Qt.exit(0)
    }) }

    Timer { interval: 15000; running: true; onTriggered: { console.log("ANIM2 TIMEOUT"); Qt.exit(9) } }
}
