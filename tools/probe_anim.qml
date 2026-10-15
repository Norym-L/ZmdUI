import QtQuick
import QtQuick.Window

/*
  动画机制探针：确认 Behavior 对"绑定驱动的属性"是否真的会插值。

  背景：ZButton 的左侧竖条 / 底板颜色都是绑定表达式算出来的
  （color: control._fill、width: control.showEdge ? 5 : 0）。
  如果 Behavior 只在"命令式赋值"时才生效，那么悬停动画就是假的 ——
  值会一次性跳过去。这个探针在动画中途取样，用实际数值说话。

  退出码 0 = Behavior 确实插值；1 = 只是瞬变（需要改用 states/transitions）。
*/
Window {
    id: root
    width: 300
    height: 200
    visible: true
    color: Theme ? Theme.bg : "white"

    property bool on: false

    Rectangle {
        id: box
        x: 10; y: 10
        width: 60; height: 60
        color: root.on ? "#FF0000" : "#0000FF"
        Behavior on color { ColorAnimation { duration: 400 } }
    }

    Rectangle {
        id: bar
        x: 10; y: 90
        height: 20
        width: root.on ? 40 : 0
        Behavior on width { NumberAnimation { duration: 400 } }
    }

    // 采样结果
    property real midRed: -1
    property real midBlue: -1
    property real midWidth: -1
    property real endRed: -1
    property real endWidth: -1
    property int step: 0

    Timer {
        interval: 100
        running: true
        onTriggered: {
            root.on = true
            sampleMid.start()
        }
    }

    Timer {
        id: sampleMid
        interval: 200          // 动画进行到一半
        onTriggered: {
            root.midRed = box.color.r
            root.midBlue = box.color.b
            root.midWidth = bar.width
            sampleEnd.start()
        }
    }

    Timer {
        id: sampleEnd
        interval: 600          // 动画早已结束
        onTriggered: {
            root.endRed = box.color.r
            root.endWidth = bar.width
            var colorAnimated = Math.abs(root.midRed - 0.5) < 0.45 && root.midBlue > 0.05
            var widthAnimated = root.midWidth > 0.5 && root.midWidth < 39.5
            var settled = Math.abs(root.endRed - 1.0) < 0.02 && Math.abs(root.endWidth - 40) < 0.5
            console.log("ANIM color: mid r=" + root.midRed.toFixed(3) + " b=" + root.midBlue.toFixed(3)
                        + "  end r=" + root.endRed.toFixed(3))
            console.log("ANIM width: mid=" + root.midWidth.toFixed(1) + "  end=" + root.endWidth.toFixed(1))
            console.log("ANIM 结论: 颜色插值=" + colorAnimated + " 宽度插值=" + widthAnimated
                        + " 终值正确=" + settled)
            var ok = colorAnimated && widthAnimated && settled
            console.log("ANIM RESULT: " + (ok ? "PASS（Behavior 对绑定驱动的属性有效）"
                                              : "FAIL（只是瞬变，需改 states/transitions）"))
            Qt.exit(ok ? 0 : 1)
        }
    }
}
