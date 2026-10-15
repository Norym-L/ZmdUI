import QtQuick
import QtQuick.Controls.Basic
import ZmdUI 1.0

/*!
    演示内容（不含窗口壳）。Main.qml 把它塞进 Window，
    无头冒烟测试 tools/smoke.qml 也直接复用它 —— 同一份代码两条路径验证。
*/
Item {
    id: demoRoot

    implicitWidth: 1500
    implicitHeight: 940

    /*! 内容区滚动偏移。开放出来是为了让自动化冒烟测试能分段截图核对各区块。 */
    property alias contentY: pageFlick.contentY
    /*! 内容总高度（超出窗口时需要滚动） */
    readonly property real contentHeight: pageFlick.contentHeight

    // ════════════════════════════════════════════════════════
    //  背景层：工程网格 + 局部斜线纹理
    // ════════════════════════════════════════════════════════
    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
        minorStep: Theme.gridMinor
        majorStep: Theme.gridMajor
    }

    // 右上角大面积斜线区
    ZHatchPattern {
        anchors.right: parent.right
        anchors.top: parent.top
        width: Math.round(parent.width * 0.28)
        height: Math.round(parent.height * 0.3)
        lineColor: Theme.hatch
        spacing: 13
        lineWidth: 1.6
        opacity: 0.85
    }

    // 左上角一小块竖斜线，打破对称
    ZHatchPattern {
        anchors.left: parent.left
        anchors.leftMargin: 240
        anchors.top: parent.top
        width: 150
        height: 90
        vertical: true
        lineColor: Theme.hatch
        spacing: 11
        opacity: 0.6
    }

    // ════════════════════════════════════════════════════════
    //  左下角：极小的点缀色状态块（青 / 品红，只允许这个尺寸）
    // ════════════════════════════════════════════════════════
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 254
        anchors.bottom: footerBar.top
        anchors.bottomMargin: Theme.spacingMd
        spacing: 4
        Repeater {
            model: [Theme.cyan, Theme.magenta, Theme.accent, Theme.ink, Theme.inkSoft]
            Rectangle {
                width: 26
                height: 6
                color: modelData
            }
        }
    }

    // ════════════════════════════════════════════════════════
    //  主体：侧边栏 + 内容区
    // ════════════════════════════════════════════════════════
    ZSideBar {
        id: sidebar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: footerBar.top
        width: 240

        brand: "ZmdUI"
        brandCode: "BUILD 2026 / 10"
        brandSub: "TERMINAL INDUSTRIAL UI"
        version: "ZmdUI 1.0 · Qt 6.11.2 · MSVC"

        model: [
            { header: "01 / 工作台", label: "运行概况", badge: "→" },
            { label: "扫码登录" },
            { label: "余额同步" },
            { header: "02 / 系统管理", label: "日志中心", badge: "12" },
            { label: "模型检测" },
            { label: "连接配置" },
            { header: "03 / 组件库", label: "基础控件" },
            { label: "数据展示" }
        ]

        onActivated: (i) => {
            pageFlick.contentY = 0
            console.log("sidebar activated:", i)
        }

        // 侧边栏底部自定义区
        Row {
            width: 240 - Theme.spacingLg * 2
            spacing: Theme.spacingSm
            ZCutRect {
                width: 34
                height: 34
                color: Theme.accent
                cutTopRight: 10
                Text {
                    anchors.centerIn: parent
                    text: "UI"
                    font: Theme.fontMonoMd
                    color: Theme.textOnAccent
                }
            }
            Column {
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    text: "组件库在线"
                    font: Theme.fontLabel
                    color: "#FFFFFF"
                }
                Text {
                    text: "127.0.0.1 : 5000"
                    font: Theme.fontMonoSm
                    color: "#8C8C8C"
                }
            }
        }
    }

    // ── 内容区 ──
    Item {
        id: contentArea
        anchors.left: sidebar.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: footerBar.top

        // 顶部信息条（黑底黄字）
        ZCutRect {
            id: topBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 46
            // 反相块（黑底白字）必须用 inkBlock：ink 在暗色下是浅灰，
            // 配 textOnSub（白）会变成"白字浅底"，顶栏文字直接看不清 —— 踩过。
            color: Theme.inkBlock
            cutBottomRight: 26

            Row {
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacingXl
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacingMd

                ZStatusDot { anchors.verticalCenter: parent.verticalCenter; tone: Theme.Tone.Accent }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "工作空间  /  组建总览  /  终末地工业机能风"
                    font: Theme.fontMonoSm
                    color: Theme.textOnSub
                }
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacingXl
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacingSm

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: Theme.isDark ? "DARK MODE" : "LIGHT MODE"
                    font: Theme.fontMonoSm
                    color: Theme.accent
                }

                // 一键切换亮 / 暗主题
                ZIconButton {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 32
                    height: 28
                    implicitWidth: 32
                    implicitHeight: 28
                    glyphSize: 15
                    glyph: Theme.isDark ? "☼" : "☾"
                    tooltip: Theme.isDark ? "切换到浅色主题" : "切换到暗色主题"
                    onClicked: Theme.mode = Theme.isDark ? Theme.Mode.Light : Theme.Mode.Dark
                }
            }
        }

        // ── 可滚动内容 ──
        Flickable {
            id: pageFlick
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            contentWidth: width
            contentHeight: page.implicitHeight + Theme.spacingXl * 2
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            ScrollBar.vertical: ZScrollBar { policy: ScrollBar.AsNeeded }

            Column {
                id: page
                x: Theme.spacingXl
                y: Theme.spacingXl
                width: pageFlick.width - Theme.spacingXl * 2 - 14
                spacing: Theme.spacingXl

                // ══════════════════════════════════════════
                //  区块 01 —— 标题 & 统计卡
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "01"
                    eyebrow: "MISSION-DEPENDENT PAYLOAD / SYSTEM INTERFACE"
                    title: "运行概况"
                    subtitle: "INTERFACE GALLERY"
                }

                Row {
                    spacing: Theme.spacingLg
                    width: parent.width

                    ZPanel {
                        width: (parent.width - Theme.spacingLg * 2) / 3
                        title: "API 可用余额"
                        tag: "LAVENDRY"
                        eyebrow: "WALLET / API BALANCE"
                        footerText: "US$ 16,906.5  可用总额"
                        hatchRatio: 0.42

                        Column {
                            width: parent.width
                            spacing: Theme.spacingXs
                            Text {
                                text: "US$9.7665"
                                font: Theme.fontNumber
                                color: Theme.ink
                            }
                            Text {
                                text: "钱包余额 · 可用总额 US$16,906.5"
                                font: Theme.fontMonoSm
                                color: Theme.muted
                            }
                        }

                        headerRight: ZIconButton {
                            width: 28
                            height: 28
                            implicitWidth: 28
                            implicitHeight: 28
                            glyphSize: 14
                            glyph: "↗"
                            tooltip: "打开钱包面板"
                        }
                    }

                    ZPanel {
                        width: (parent.width - Theme.spacingLg * 2) / 3
                        title: "NapCat"
                        tag: "QQ 客户端"
                        eyebrow: "LOGIN / CONNECTION"
                        footerText: "扫码登录 · 设备确认"
                        footerTone: Theme.Tone.Ink

                        Row {
                            width: parent.width
                            Row {
                                width: (parent.width - Theme.spacingMd) / 2
                                spacing: Theme.spacingSm
                                ZStatusDot { anchors.verticalCenter: parent.verticalCenter }
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "已找到进程"
                                    font: Theme.fontStrong
                                    color: Theme.ink
                                }
                            }
                            Text {
                                text: "01"
                                font: Theme.fontMonoMd
                                color: Theme.muted
                            }
                        }

                        Column {
                            width: parent.width
                            spacing: Theme.spacingSm
                            Text {
                                text: "桌面端"
                                font: Theme.fontHeading
                                color: Theme.ink
                            }
                            ZButton {
                                text: "设置连接 →"
                                variant: Theme.Variant.Secondary
                                mono: "F2"
                            }
                        }
                    }

                    ZPanel {
                        width: (parent.width - Theme.spacingLg * 2) / 3
                        title: "Kolshi"
                        tag: "BOT 框架"
                        eyebrow: "SERVICE STATUS"
                        footerText: "端口 3011 · 未响应"
                        hatch: true
                        accentEdge: false

                        Column {
                            width: parent.width
                            spacing: Theme.spacingSm

                            Row {
                                spacing: Theme.spacingSm
                                ZStatusDot {
                                    anchors.verticalCenter: parent.verticalCenter
                                    tone: Theme.Tone.Magenta
                                    blink: true
                                }
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "未响应"
                                    font: Theme.fontHeading
                                    color: Theme.ink
                                }
                            }

                            ZTag { text: "端口未响应"; tone: Theme.Tone.Muted; dotColor: Theme.magenta }

                            ZButton {
                                text: "设置连接 →"
                                variant: Theme.Variant.Ghost
                            }
                        }
                    }
                }

                // ── 顶部一条亮黄横幅（原图里最抢眼的元素） ──
                ZPanel {
                    width: parent.width
                    title: "本地 Bot 接入"
                    tag: "WORKBENCH"
                    eyebrow: "01 / WORKBENCH"
                    footerText: "ARKNIGHTS:ENDFIELD  /  BOT CONSOLE  /  127.0.0.1:3011"
                    cut: true
                    hatchRatio: 0.28

                    Row {
                        width: parent.width
                        spacing: Theme.spacingLg

                        Column {
                            width: parent.width - 420 - Theme.spacingLg
                            spacing: Theme.spacingXs
                            Text {
                                text: "让你的 Bot 就位。"
                                font: Theme.fontTitle
                                color: Theme.ink
                            }
                            Text {
                                text: "已取消配置；所有账号和数据保留"
                                font: Theme.fontBody
                                color: Theme.muted
                            }
                        }

                        Rectangle {
                            width: 1
                            height: 56
                            color: Theme.line
                            opacity: 0.5
                        }

                        Column {
                            width: 420 - Theme.spacingLg
                            spacing: Theme.spacingSm

                            ZTextField {
                                width: parent.width
                                label: "当前 BOT / ID"
                                text: "bot 1 - 36 - · · · - 007"
                                unit: "ID"
                            }

                            ZButton {
                                text: "一键配置并启动"
                                variant: Theme.Variant.Primary
                                mono: "Ctrl+↵"
                                tooltip: "写入本地配置并拉起 Bot 进程"
                            }
                        }
                    }
                }

                // ══════════════════════════════════════════
                //  区块 02 —— 按钮
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "02"
                    eyebrow: "CONTROL / ACTION"
                    title: "按钮"
                    subtitle: "BUTTONS"
                }

                ZPanel {
                    width: parent.width
                    title: "按钮家族"
                    tag: "BTN-01"
                    eyebrow: "PRIMARY / SECONDARY / DANGER / GHOST / ICON"
                    footerText: "状态：DEFAULT · HOVER · DISABLED · SKEW"

                    Column {
                        width: parent.width
                        spacing: Theme.spacingLg

                        Flow {
                            width: parent.width
                            spacing: Theme.spacingMd

                            ZButton { text: "一键配置并启动"; variant: Theme.Variant.Primary }
                            ZButton { text: "扫码登录"; variant: Theme.Variant.Secondary; mono: "F2" }
                            ZButton { text: "删除配置"; variant: Theme.Variant.Danger; mono: "DEL" }
                            ZButton { text: "了解更多"; variant: Theme.Variant.Ghost }
                            ZButton { text: "禁用状态"; variant: Theme.Variant.Primary; enabled: false }
                            ZButton { text: "平行四边形"; variant: Theme.Variant.Primary; skew: 12 }
                            ZButton { text: "平行四边形"; variant: Theme.Variant.Secondary; skew: 12 }
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: Theme.lineSoft
                        }

                        Flow {
                            width: parent.width
                            spacing: Theme.spacingMd

                            ZIconButton { glyph: "+"; tooltip: "新建任务" }
                            ZIconButton { glyph: "→"; tooltip: "导出" }
                            ZIconButton { glyph: "×"; tone: Theme.Tone.Danger; tooltip: "关闭" }
                            ZIconButton { glyph: "◎"; tone: Theme.Tone.Accent; tooltip: "定位" }
                            ZIconButton { glyph: "≡"; tooltip: "菜单" }
                            ZIconButton { glyph: "↻"; tooltip: "刷新"; enabled: false }

                            ZButton {
                                text: "打开对话框"
                                variant: Theme.Variant.Secondary
                                tooltip: "ZDialog · 中央斜线纹理 + 顶部黑底黄字"
                                onClicked: demoDialog.open()
                            }
                        }
                    }
                }

                // ══════════════════════════════════════════
                //  区块 03 —— 输入与选择
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "03"
                    eyebrow: "INPUT / SELECTION"
                    title: "输入与选择"
                    subtitle: "INPUTS"
                }

                Row {
                    width: parent.width
                    spacing: Theme.spacingLg

                    ZPanel {
                        width: (parent.width - Theme.spacingLg) * 0.5
                        title: "文本框"
                        tag: "INPUT-01"
                        eyebrow: "TEXT FIELD"
                        footerText: "聚焦时亮黄底线 · 出错时品红底线"

                        Column {
                            width: parent.width
                            spacing: Theme.spacingMd

                            ZTextField {
                                width: parent.width
                                label: "账号 / ACCOUNT"
                                placeholderText: "输入账号"
                            }
                            ZTextField {
                                width: parent.width
                                label: "令牌 / TOKEN"
                                text: "zmdui-2026-10-15"
                                unit: "TOKEN"
                                echoMode: TextInput.Password
                            }
                            ZTextField {
                                width: parent.width
                                label: "端口 / PORT"
                                placeholderText: "3011"
                                unit: "PORT"
                                invalid: true
                            }
                            Text {
                                text: "注：品红只用于极小的错误标识，不做大面积铺色。"
                                font: Theme.fontMonoSm
                                color: Theme.muted
                            }
                        }
                    }

                    ZPanel {
                        width: (parent.width - Theme.spacingLg) * 0.5
                        title: "选择控件"
                        tag: "SELECT-02"
                        eyebrow: "CHECK / RADIO / SWITCH"
                        footerText: "选中态一律用亮黄填充几何图形"

                        Column {
                            width: parent.width
                            spacing: Theme.spacingLg

                            Column {
                                width: parent.width
                                spacing: Theme.spacingSm
                                Text { text: "复选框 / CHECKBOX"; font: Theme.fontLabel; color: Theme.muted }
                                Flow {
                                    width: parent.width
                                    spacing: Theme.spacingLg
                                    ZCheckBox { text: "自动重连"; checked: true; note: "断开后 5s 重试" }
                                    ZCheckBox { text: "保留日志" }
                                    ZCheckBox { text: "半选态"; indeterminate: true }
                                    ZCheckBox { text: "禁用"; enabled: false }
                                }
                            }

                            Column {
                                width: parent.width
                                spacing: Theme.spacingSm
                                Text { text: "单选 / RADIO"; font: Theme.fontLabel; color: Theme.muted }
                                Flow {
                                    width: parent.width
                                    spacing: Theme.spacingLg
                                    ZRadioButton { text: "全量同步"; checked: true }
                                    ZRadioButton { text: "增量同步" }
                                    ZRadioButton { text: "手动" }
                                }
                            }

                            Column {
                                width: parent.width
                                spacing: Theme.spacingSm
                                Text { text: "开关 / SWITCH"; font: Theme.fontLabel; color: Theme.muted }
                                Row {
                                    spacing: Theme.spacingXl
                                    ZSwitch { text: "开机自启"; checked: true }
                                    ZSwitch { text: "静默模式" }
                                }
                            }
                        }
                    }
                }

                // ══════════════════════════════════════════
                //  区块 04 —— 数值控件
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "04"
                    eyebrow: "NUMERIC / GAUGE"
                    title: "数值与进度"
                    subtitle: "NUMERIC"
                }

                ZPanel {
                    width: parent.width
                    title: "滑块与进度条"
                    tag: "NUM-01"
                    eyebrow: "SLIDER / PROGRESS"
                    footerText: "刻度线 + 等宽读数"

                    Row {
                        width: parent.width
                        spacing: Theme.spacingXl

                        Column {
                            width: (parent.width - Theme.spacingXl) * 0.5
                            spacing: Theme.spacingLg

                            ZSlider {
                                width: parent.width
                                label: "负载上限"
                                from: 0
                                to: 100
                                value: 62
                                valueSuffix: "%"
                            }
                            ZSlider {
                                width: parent.width
                                label: "刷新间隔"
                                from: 1
                                to: 60
                                value: 24
                                valueSuffix: " s"
                                decimals: 0
                            }
                        }

                        Column {
                            width: (parent.width - Theme.spacingXl) * 0.5
                            spacing: Theme.spacingLg

                            ZProgressBar {
                                width: parent.width
                                label: "同步进度"
                                value: 0.62
                            }
                            ZProgressBar {
                                width: parent.width
                                label: "配置写入"
                                value: 0.28
                            }
                            ZProgressBar {
                                width: parent.width
                                label: "扫描中"
                                indeterminate: true
                                showTicks: true
                            }
                        }
                    }
                }

                // ══════════════════════════════════════════
                //  区块 05 —— 列表与标签
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "05"
                    eyebrow: "LIST / TAG"
                    title: "列表与标签"
                    subtitle: "LISTS"
                }

                Row {
                    width: parent.width
                    spacing: Theme.spacingLg

                    ZPanel {
                        width: (parent.width - Theme.spacingLg) * 0.58
                        title: "任务队列"
                        tag: "LIST-01"
                        eyebrow: "SELECTED = YELLOW BLOCK"
                        footerText: "点击任意一行切换选中态"

                        ZListView {
                            width: parent.width
                            height: 268
                            headerText: "QUEUE / 04"
                            model: [
                                { label: "余额同步", description: "WALLET SYNC", value: "00:12" },
                                { label: "扫码登录", description: "QR CODE LOGIN", value: "00:31" },
                                { label: "模型检测", description: "MODEL PROBE", value: "01:04" },
                                { label: "日志归档", description: "LOG ARCHIVE", value: "02:20" },
                                { label: "连接配置", description: "CONNECTION SETUP", value: "03:45" }
                            ]
                            currentIndex: 1
                        }
                    }

                    ZPanel {
                        width: (parent.width - Theme.spacingLg) * 0.42
                        title: "标签与徽章"
                        tag: "TAG-02"
                        eyebrow: "TONE / BADGE / DOT"
                        footerText: "点缀色只出现在极小的块上"

                        Column {
                            width: parent.width
                            spacing: Theme.spacingLg

                            Flow {
                                width: parent.width
                                spacing: Theme.spacingSm
                                ZTag { text: "ONLINE"; tone: Theme.Tone.Accent }
                                ZTag { text: "STANDBY" }
                                ZTag { text: "OUTLINE"; tone: Theme.Tone.Outline }
                                ZTag { text: "PENDING"; tone: Theme.Tone.Muted }
                                ZTag { text: "SYNC"; tone: Theme.Tone.Cyan }
                                ZTag { text: "ALERT"; tone: Theme.Tone.Magenta }
                            }

                            Flow {
                                width: parent.width
                                spacing: Theme.spacingSm
                                ZTag { text: "本地"; skew: false }
                                ZTag { text: "远程"; skew: false; tone: Theme.Tone.Accent }
                                ZTag { text: " · 12"; mono: false; tone: Theme.Tone.Outline }
                                ZTag { text: "运行中"; dotColor: Theme.accent }
                                ZTag { text: "异常"; dotColor: Theme.magenta; tone: Theme.Tone.Muted }
                            }

                            Rectangle { width: parent.width; height: 1; color: Theme.lineSoft }

                            Column {
                                width: parent.width
                                spacing: Theme.spacingMd
                                Text { text: "状态点 / STATUS DOT"; font: Theme.fontLabel; color: Theme.muted }
                                Row {
                                    spacing: Theme.spacingLg
                                    Repeater {
                                        model: [
                                            { t: Theme.Tone.Accent,  n: "运行" },
                                            { t: Theme.Tone.Cyan,    n: "同步" },
                                            { t: Theme.Tone.Magenta, n: "异常" },
                                            { t: Theme.Tone.Ink,     n: "空闲" },
                                            { t: Theme.Tone.Muted,   n: "离线" }
                                        ]
                                        Row {
                                            spacing: Theme.spacingSm
                                            ZStatusDot {
                                                anchors.verticalCenter: parent.verticalCenter
                                                tone: modelData.t
                                                blink: modelData.t === Theme.Tone.Magenta
                                            }
                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: modelData.n
                                                font: Theme.fontMonoSm
                                                color: Theme.ink
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // ══════════════════════════════════════════
                //  区块 06 —— 数据展示
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "06"
                    eyebrow: "DATA / TELEMETRY"
                    title: "数据展示"
                    subtitle: "TELEMETRY"
                }

                Row {
                    width: parent.width
                    spacing: Theme.spacingLg

                    ZPanel {
                        width: (parent.width - Theme.spacingLg) * 0.56
                        title: "服务状态表"
                        tag: "TABLE-01"
                        eyebrow: "GRID + YELLOW HIGHLIGHT"
                        footerText: "点击行切换高亮"

                        ZTable {
                            width: parent.width
                            caption: "SERVICE MATRIX / 实时上报"
                            columns: [
                                { title: "模块", key: "name", width: 140 },
                                { title: "状态", key: "state" },
                                { title: "延迟", key: "latency", align: "right" },
                                { title: "版本", key: "ver", align: "right", width: 80 }
                            ]
                            rows: [
                                { name: "GateServer", state: "在线", latency: "12 ms", ver: "v1.4" },
                                { name: "StatusServer", state: "在线", latency: "18 ms", ver: "v1.4" },
                                { name: "ChatServer", state: "在线", latency: "23 ms", ver: "v1.3" },
                                { name: "Kolshi", state: "未响应", latency: "--", ver: "v0.9" },
                                { name: "NapCat", state: "待确认", latency: "41 ms", ver: "v4.2" }
                            ]
                            currentIndex: 2
                            onRowClicked: (i) => console.log("row:", i)
                        }
                    }

                    ZPanel {
                        width: (parent.width - Theme.spacingLg) * 0.44
                        title: "响应时延"
                        tag: "CHART-02"
                        eyebrow: "YELLOW DATALINE"
                        footerText: "采样窗口 60s · 单位 ms"

                        ZLineChart {
                            width: parent.width
                            height: 236
                            caption: "RESPONSE TIME / MS"
                            suffix: " ms"
                            values: [12, 18, 15, 26, 22, 31, 28, 36, 33, 42]
                            labels: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                        }
                    }
                }
            }
        }
    }

    // ════════════════════════════════════════════════════════
    //  底部装饰条
    // ════════════════════════════════════════════════════════
    ZCutRect {
        id: footerBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 28
        color: Theme.accent

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingLg
            anchors.verticalCenter: parent.verticalCenter
            spacing: Theme.spacingLg

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "ARKNIGHTS:ENDFIELD"
                font: Theme.fontMonoSm
                color: Theme.textOnAccent
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "ZMDUI COMPONENT LIBRARY / 24 TYPES / QT 6 QML"
                font: Theme.fontMonoSm
                color: Theme.textOnAccent
                opacity: 0.75
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: Theme.spacingLg
            anchors.verticalCenter: parent.verticalCenter
            spacing: 3
            Repeater {
                model: 6
                Rectangle {
                    width: 3
                    height: 12
                    color: Theme.textOnAccent
                    opacity: 0.25 + index * 0.13
                }
            }
        }
    }

    // ════════════════════════════════════════════════════════
    //  对话框示例
    // ════════════════════════════════════════════════════════
    ZDialog {
        id: demoDialog
        title: "覆盖本地配置"
        code: "SYS-04"
        subtitle: "此操作不可撤销"
        confirmText: "确认覆盖"
        cancelText: "取消"

        onConfirmed: console.log("confirmed")

        Column {
            width: parent.width
            spacing: Theme.spacingMd

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
                spacing: Theme.spacingSm
                ZTag { text: "备份已就绪"; tone: Theme.Tone.Accent }
                ZTag { text: "3.2 KB" }
            }
        }
    }
}
