import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  「白 → 灰 → 白」闪烁的成因测量。

  假设：Ghost 空闲时底色是 "transparent"，悬浮时变成不透明的 surfaceHover。
  ColorAnimation 从透明色淡入到不透明色时，中间帧是"透明黑与不透明灰的插值"，
  叠在白色卡片上会比目标色**更深** —— 看上去就是先深一下再回到浅灰（≈白）。

  两种做法放在一起取样对比：
    A) color 从 transparent 过渡到 surfaceHover   （现在的做法）
    B) 颜色固定不透明，只过渡 opacity           （准备改成的做法）

  判据：把颜色按 alpha 合成到白底，看中间帧是不是比目标色深。
*/
Window {
    id: win
    width: 320
    height: 240
    visible: true
    color: "#FFFFFF"

    property bool on: false
    property int step: 0

    Rectangle {
        id: a
        x: 20; y: 20
        width: 120; height: 40
        color: win.on ? Theme.surfaceHover : "transparent"
        Behavior on color {
            ColorAnimation { duration: 160; easing.type: Theme.easingStd }
        }
    }

    Rectangle {
        id: b
        x: 20; y: 90
        width: 120; height: 40
        color: Theme.surfaceHover
        opacity: win.on ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 160; easing.type: Theme.easingStd }
        }
    }

    /*
      注意：QML 的 color.r/g/b 是 **0..1 归一化**的，alpha 也是 0..1。
      （第一版探针忘了乘 255，把 #E9E9E9 打成了 "1"，差点得出错误结论。）
    */
    function v(x) { return Math.round(x * 255) }

    // 把颜色按 alpha 合成到白底 —— 眼睛实际看到的颜色
    function overWhite(c) {
        return Math.round(255 * (c.r * c.a + (1 - c.a)))
    }

    function sample(tag) {
        console.log("FADE " + tag
                    + " | A(color 过渡): rgb=" + v(a.color.r) + ","
                    + v(a.color.g) + "," + v(a.color.b)
                    + " a=" + a.color.a.toFixed(2)
                    + " 看到=" + overWhite(a.color)
                    + " | B(opacity 过渡): rgb=" + v(b.color.r)
                    + " a=" + b.opacity.toFixed(2)
                    + " 看到=" + overWhite(b.color))
    }

    Timer {
        interval: 120
        repeat: true
        running: true
        onTriggered: {
            win.step++
            if (win.step === 1) {
                sample("起始 未悬浮")
                win.on = true
            } else if (win.step === 2) {
                sample("悬浮后 120ms（动画中）")
            } else if (win.step === 3) {
                sample("悬浮后 240ms（动画结束）")
                win.on = false
            } else if (win.step === 4) {
                sample("移开后 120ms（回落中）")
            } else if (win.step === 5) {
                sample("移开后 240ms（已复位）")
                win.stop()
                Qt.exit(0)
            }
        }
    }
    Timer { interval: 20000; running: true; onTriggered: { console.log("FADE TIMEOUT"); Qt.exit(9) } }
}