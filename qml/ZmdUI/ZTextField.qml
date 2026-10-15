import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZTextField
    \inqmlmodule ZmdUI
    \brief 输入框：黑色硬边 + 右上 / 右下斜切角，聚焦时亮黄底线。

    标签（\l label）以等宽小字嵌在框内左上角，\l unit 显示在右侧，
    这是工业面板上常见的"字段铭牌"排布，不需要额外的外部标签占位。

    \qml
    ZTextField {
        width: 320
        label: "BOT ID"
        placeholderText: "bot 1 - 36 - · · · - 007"
        unit: "ID"
    }
    \endqml
*/
TextField {
    id: control

    /*! 左上角等宽铭牌文字，空则隐藏 */
    property string label: ""
    /*! 右侧单位 / 后缀 */
    property string unit: ""
    /*! 是否出错（底线转品红） */
    property bool invalid: false

    implicitHeight: Theme.dp(label.length > 0 ? Theme.controlHeightLg : Theme.controlHeight)
    leftPadding: Theme.spacingMd
    rightPadding: Theme.spacingMd + (unit.length > 0 ? unitText.implicitWidth + Theme.spacingSm : 0)
    topPadding: label.length > 0 ? Theme.spacingLg : Theme.spacingSm
    bottomPadding: Theme.spacingSm

    color: enabled ? Theme.ink : Theme.muted
    font: Theme.fontBody
    placeholderTextColor: Theme.muted
    selectionColor: Theme.accent
    selectedTextColor: Theme.textOnAccent
    verticalAlignment: TextInput.AlignVCenter
    selectByMouse: true

    // 光标交给系统默认色会偏灰，这里强制用主文字色
    cursorDelegate: Rectangle {
        width: 2
        color: Theme.ink
    }

    background: Item {
        ZCutRect {
            anchors.fill: parent
            color: control.enabled ? Theme.surface : Theme.surfaceAlt
            strokeColor: control.invalid ? Theme.magenta : Theme.line
            strokeWidth: Theme.border
            cutBottomRight: Theme.cutMd
            cutTopLeft: Theme.cutSm
        }

        // ── 底线：默认细灰线，聚焦/出错时变成粗亮黄（或品红）线 ──
        Rectangle {
            id: underline
            x: Theme.border / 2
            y: parent.height - height - Theme.border / 2
            width: parent.width - Theme.cutMd - Theme.border
            height: control.activeFocus ? 4 : (control.hovered ? 3 : 2)
            color: control.invalid ? Theme.magenta
                 : control.activeFocus ? Theme.accent
                 : Theme.lineSoft

            Behavior on height {
                NumberAnimation { duration: Theme.durFast; easing.type: Theme.easingStd }
            }
        }

        // ── 字段铭牌 ──
        Text {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingMd
            anchors.top: parent.top
            anchors.topMargin: 5
            visible: control.label.length > 0
            text: control.label
            font: Theme.fontMonoSm
            color: control.activeFocus ? Theme.ink : Theme.muted
        }

        // ── 右侧单位块：黑底白字小队标 ──
        ZCutRect {
            id: unitBadge
            anchors.right: parent.right
            anchors.rightMargin: Theme.cutMd + 4
            anchors.verticalCenter: parent.verticalCenter
            width: unitText.implicitWidth + Theme.spacingMd
            height: 18
            visible: control.unit.length > 0
            color: Theme.subBg
            cutTopRight: 5

            Text {
                id: unitText
                anchors.centerIn: parent
                text: control.unit
                font: Theme.fontMonoSm
                color: Theme.textOnSub
            }
        }

        // ── 聚焦时的四角标记（工程瞄准框的感觉）──
        ZCutRect {
            anchors.fill: parent
            anchors.margins: -3
            visible: control.activeFocus
            color: "transparent"
            strokeColor: Theme.ink
            strokeWidth: 1
            cutBottomRight: Theme.cutMd + 3
            cutTopLeft: Theme.cutSm + 3
            opacity: 0.35
        }
    }
}
