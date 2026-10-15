import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*!
    ZmdUI 组件库演示应用入口。

    窗口壳在这里，真正的演示内容在 demo/DemoContent.qml —— 抽出来的目的是
    让无头冒烟测试（tools/smoke.qml）能复用同一份内容做离屏渲染校验。
*/
Window {
    id: app

    width: 1500
    height: 940
    minimumWidth: 1100
    minimumHeight: 700
    visible: true
    title: "ZmdUI · 终末地工业机能风组件库"
    color: Theme.bg

    DemoContent {
        anchors.fill: parent
    }
}
