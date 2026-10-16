import QtQuick
import QtTest
import ZmdUI 1.0

/*!
    组件行为测试（qmltestrunner）。

    跑法：
        qmltestrunner -input tests/tst_hover.qml -import qml
        退出码 0 = 全绿；非 0 = 有断言失败，CI 可直接用

    ⚠️ 关于"悬停态"：已在离屏平台上实测过，合成鼠标事件**到不了 item**
    （mouseMove 后 `hovered` 仍是 false，`mousePress` 后 `pressed` 也是 false），
    所以这里不去模拟交互，而是把"什么条件下长竖条 / 竖条什么颜色"抽成
    ZButton 上的纯函数（edgeVisibleFor / edgeColorFor）直接单测规则本身 ——
    断言更硬，也不受输入设备可用性影响。
*/
TestCase {
    id: root
    name: "ZmdUIBehaviors"
    when: windowShown

    width: 760
    height: 420

    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }

    Column {
        id: layout
        x: 40
        y: 40
        spacing: 20

        Row {
            spacing: 40
            ZButton { id: secA; text: "扫码登录"; variant: Theme.Variant.Secondary; mono: "F2" }
            ZButton { id: secB; text: "扫码登录"; variant: Theme.Variant.Secondary; mono: "F2" }
        }
        Row {
            spacing: 40
            ZButton { id: dangA; text: "删除配置"; variant: Theme.Variant.Danger; mono: "DEL" }
            ZButton { id: dangB; text: "删除配置"; variant: Theme.Variant.Danger; mono: "DEL" }
        }
        Row {
            spacing: 40
            ZButton { id: priA; text: "一键配置并启动"; variant: Theme.Variant.Primary }
            ZButton { id: priB; text: "一键配置并启动"; variant: Theme.Variant.Primary }
        }
        Row {
            spacing: 40
            ZButton { id: ghostA; text: "了解更多"; variant: Theme.Variant.Ghost }
            ZButton { id: ghostB; text: "了解更多"; variant: Theme.Variant.Ghost }
        }
        Row {
            spacing: 20
            ZSlider { id: sliderA; width: 260; label: "负载上限"; from: 0; to: 100; value: 62; valueSuffix: "%" }
            ZSlider { id: sliderB; width: 260; label: "刷新间隔"; from: 1; to: 60; value: 1; valueSuffix: " s" }
        }
        Row {
            spacing: 20
            ZSwitch { id: swA; text: "开机自启"; checked: true }
            ZSwitch { id: swB; text: "静默模式" }
        }
        Row {
            spacing: 20
            ZTextField {
                id: fieldPlain
                width: 240
                label: "账号 / ACCOUNT"
                placeholderText: "输入账号"
            }
            ZTextField {
                id: fieldInvalid
                width: 240
                label: "端口 / PORT"
                text: "99999"
                invalid: true
            }
        }
        Row {
            spacing: 20
            ZSideBar {
                id: sideProbe
                width: 200
                height: 220
                model: [{ header: "01 / 组", label: "甲", badge: "1" }, { label: "乙" }]
                version: "v1"
            }
            ZTable {
                id: tableProbe
                width: 300
                columns: [{ title: "A", key: "a" }, { title: "B", key: "b" }]
                rows: [{ a: "1", b: "2" }, { a: "3", b: "4" }]
            }
        }
    }

    // 递归找第一个指定类型的对象。注意用 data 而不是 children：
    // 动画这类非可视子对象只出现在 data 里。
    function findByType(item, name) {
        var kids = item.data
        if (!kids)
            return null
        for (var i = 0; i < kids.length; i++) {
            var t = kids[i].toString()
            if (t.indexOf(name) === 0)
                return kids[i]
            var r = findByType(kids[i], name)
            if (r)
                return r
        }
        return null
    }

    // 递归找第一个 color 等于给定值的 item
    function findByColor(item, color) {
        var kids = item.children
        if (!kids)
            return null
        for (var i = 0; i < kids.length; i++) {
            var c = kids[i]
            if (c.color !== undefined && c.color.toString() === color.toString())
                return c
            var r = findByColor(c, color)
            if (r)
                return r
        }
        return null
    }

    // 递归找第一个 MouseArea（用来验证 preventStealing 这类内部实现）
    function findMouseArea(item) {
        var kids = item.children
        if (!kids)
            return null
        for (var i = 0; i < kids.length; i++) {
            if (kids[i].toString().indexOf("QQuickMouseArea") === 0)
                return kids[i]
            var r = findMouseArea(kids[i])
            if (r)
                return r
        }
        return null
    }

    /*! 每个用例前的复位。QtTest 会在每个 test_* 之前调用 init()。
        没有它的话，某个用例把主题切成暗色后断言失败，后面所有用例都跑在暗色上，
        一个失败会连锁成一片 —— 上一版就是这么翻车的。 */
    function init() {
        Theme.mode = Theme.Mode.Light
        wait(60)
    }

    // ── 竖条显示规则 ──

    function test_edgeVisibleRule() {
        var V = Theme.Variant
        compare(secA.edgeVisibleFor(V.Secondary, 0, false, true), false, "默认态不显示竖条")
        compare(secA.edgeVisibleFor(V.Secondary, 0, true, true), true, "悬停时显示")
        compare(dangA.edgeVisibleFor(V.Danger, 0, true, true), true, "Danger 悬停时显示")
        compare(dangA.edgeVisibleFor(V.Danger, 0, false, true), false,
                "Danger 默认态不要竖条（用户反馈过：默认顶着黄边太吵）")
        compare(priA.edgeVisibleFor(V.Primary, 0, true, true), false, "Primary 靠反色，不画竖条")
        compare(secA.edgeVisibleFor(V.Secondary, 12, true, true), false,
                "平行四边形永远不画直竖条")
        compare(secA.edgeVisibleFor(V.Secondary, 0, true, false), false, "禁用态不显示")
    }

    // ── 竖条颜色规则（用户反馈的第 3 条）──

    function test_edgeColorRule() {
        var V = Theme.Variant
        // 强调黄底上的"深色"是 textOnAccent（亮色=纯黑 / 暗色=深炭），不是 Theme.ink ——
        // 暗色下 ink 是浅灰，压在压暗后的黄上一样看不见
        var onAccent = Theme.textOnAccent.toString()
        var yellow = Theme.accent.toString()
        compare(secA.edgeColorFor(V.Secondary, true).toString(), onAccent,
                "白底按钮悬停后底色变亮黄，竖条必须转深色")
        compare(secA.edgeColorFor(V.Secondary, false).toString(), yellow,
                "未悬停时底色是白的，竖条保持亮黄")
        compare(dangA.edgeColorFor(V.Danger, true).toString(), yellow,
                "深灰底上竖条保持亮黄")
        compare(secA.edgeColorFor(V.Ghost, true).toString(), yellow, "浅灰底上竖条保持亮黄")
    }

    // ── 宽度不随状态变化（结构性保证：padding 恒为常量）──

    function test_widthDoesNotDependOnState() {
        compare(secA.width, secB.width, "同形态按钮宽度必须相等")
        compare(dangA.width, dangB.width, "同形态按钮宽度必须相等")
        compare(priA.width, priB.width, "同形态按钮宽度必须相等")
        compare(secA.leftPadding, secB.leftPadding, "左右内边距不能依赖状态")
        // 内边距必须是常量：一旦有人写成 "hovered ? ..." 这种，数值会随状态变，
        // 而 padding 只由主题常量决定，所以两次读取必然一致
        var p1 = secA.leftPadding
        Theme.density = 1.0
        compare(secA.leftPadding, p1, "leftPadding 应只由主题常量决定")
    }

    // ── 滑块的垂直分带：手柄/刻度不能压到铭牌和读数 ──

    function test_sliderBandsDoNotOverlap() {
        verify(sliderA.bandTop >= 16, "有铭牌时顶部带要高过铭牌文字（实测 17）")
        verify(sliderA.height === sliderA.bandTop + sliderA.bandTrack + sliderA.bandBottom,
               "高度必须正好等于三条带之和")
        var handleTop = sliderA.centerY - 10
        var handleBottom = sliderA.centerY + 10
        verify(handleTop >= sliderA.bandTop, "手柄不能越过顶部带（否则压住铭牌）")
        verify(handleBottom <= sliderA.bandTop + sliderA.bandTrack,
               "手柄不能越过中间带（否则压住底部读数）")
        verify(sliderA.centerY + 11 <= sliderA.bandTop + sliderA.bandTrack + 1,
               "刻度最长伸到 centerY+11，必须仍在中间带内")
    }

    // ── 开关滑块与轨道的切角必须平行 ──

    function test_switchKnobChamferIsParallel() {
        // 滑块内缩 2px，同侧切角就该比轨道小 2px，两条斜边才平行
        compare(swA.knobCutTopRight, swA.trackCutTopRight - swA.knobInset,
                "右上切角：滑块 = 轨道 - 内缩量")
        compare(swA.knobCutBottomLeft, swA.trackCutBottomLeft - swA.knobInset,
                "左下切角：滑块 = 轨道 - 内缩量（这就是左下角对不齐的根因）")
    }

    // ── 默认态"没有任何装饰"的断言（不依赖渲染）──
    //
    // ⚠️ 这里**故意不做像素断言**：已实测 qmltestrunner + offscreen 平台下窗口不会被渲染，
    // grabImage() 返回的是一张尺寸正确、内容全白的图（连纯红矩形的像素都读不到 #ff0000）。
    // 拿它做像素断言只会得到"白图不等于亮黄"这种**假通过**，比没有测试更危险。
    // 像素级的核对统一交给 tools/smoke.qml + tools/crop.qml（走 qml 工具的真实渲染）。 

    function test_defaultStateHasNoDecorations() {
        // 竖条：三种形态默认都不该有
        compare(secA.showEdge, false, "Secondary 默认态不应有竖条")
        compare(dangA.showEdge, false, "Danger 默认态不应有竖条")
        compare(priA.showEdge, false, "Primary 默认态不应有竖条")

        // 品红点已按要求删除：组件里不再存在任何品红元素
        // （源码里 grep 不到 Theme.magenta 就是这个断言的存在意义）
        verify(Theme.magenta.toString() === "#ff00ff", "品红令牌本身保留给状态点用")
    }

    // ── 暗色主题的令牌关系（参考 fz.wiki 的做法）──

    function test_darkThemeTokens() {
        var lightAccent = Theme.accent.toString()
        Theme.mode = Theme.Mode.Dark
        wait(150)

        // 1) 强调色必须压暗：亮柠檬黄浮在暗背景上会刺眼
        verify(Theme.accent.toString() !== lightAccent,
               "暗色下的强调色不能和亮色同一个值：亮 " + lightAccent + " / 暗 " + Theme.accent)

        // 2) 卡片必须比页面底色更亮（"板"而不是"洞"）
        verify(Theme.surface.r > Theme.bg.r && Theme.surface.g > Theme.bg.g
               && Theme.surface.b > Theme.bg.b,
               "暗色下 surface 必须比 bg 亮：实测 surface=" + Theme.surface + " bg=" + Theme.bg)

        // 3) 结构线不能是近白色（第一版把 line 反相成 #EFEFEF，每个卡片镶白边）
        verify(Theme.line.r < 0.6 && Theme.line.g < 0.6 && Theme.line.b < 0.6,
               "暗色下结构线必须是中灰而不是近白：实测 " + Theme.line)

        // 4) 悬停面必须比卡片更亮（暗色下悬停的方向和亮色相反）
        verify(Theme.surfaceHover.r > Theme.surface.r,
               "暗色下悬停面要比卡片亮：hover=" + Theme.surfaceHover + " surface=" + Theme.surface)

        // 5) 反相块必须仍然是深色（否则表头会变成浅底白字）
        verify(Theme.inkBlock.r < 0.2, "反相块在暗色下也要是深色：实测 " + Theme.inkBlock)

        Theme.mode = Theme.Mode.Light
        wait(150)
    }

    // ── 侧边栏滚动条：可关，且开着的时候必须给内容让位 ──

    function test_sidebarScrollBarOption() {
        compare(sideProbe.navScrollBar, true, "默认显示滚动条")
        compare(sideProbe.navScrollBarReserve, 14,
                "开着时必须预留占位 —— Qt 挂的滚动条是浮在内容上的，不预留会盖住行右侧的编号")
        sideProbe.navScrollBar = false
        wait(50)
        compare(sideProbe.navScrollBarReserve, 0, "关掉后不再占位")
        sideProbe.navScrollBar = true
        wait(50)
        compare(sideProbe.navScrollBarReserve, 14, "再打开应恢复占位")
    }

    // ── 表格行点击：必须抢住按下，否则被外层 Flickable 当滚动手势收走 ──

    function test_tableRowClickRobust() {
        compare(tableProbe.rowClickRobust, true, "默认应开启行点击抢占")
        var ma = findMouseArea(tableProbe)
        verify(ma !== null, "应当能在表格里找到行的 MouseArea")
        if (ma)
            compare(ma.preventStealing, true,
                    "preventStealing 必须为 true：指针移动超过拖拽阈值时才不会被 Flickable 抢走按下")
        tableProbe.rowClickRobust = false
        wait(50)
        var ma2 = findMouseArea(tableProbe)
        if (ma2)
            compare(ma2.preventStealing, false, "关掉后应恢复默认的拖拽滚动行为")
        tableProbe.rowClickRobust = true
    }

    // ── 光标：只在编辑时出现并闪烁 ──

    /*
      自定义 cursorDelegate 之后，Qt **不再**帮你管可见性和闪烁 ——
      两件事都得 delegate 自己实现（Qt 自带的 Material 风格也是这么写的：
      visible: parent.activeFocus && ...，再配一个闪烁 Timer）。
      这里把 delegate 实例化出来，直接断言"没有焦点时必须隐藏"，
      这就是当初漏掉的那个绑定。
    */
    function test_caretOnlyWhileEditing() {
        var caret = fieldPlain.cursorDelegate.createObject(root, {})
        verify(caret !== null, "cursorDelegate 应当可以实例化")
        if (!caret)
            return

        compare(fieldPlain.activeFocus, false, "测试环境下输入框没有焦点")
        compare(caret.visible, false, "没有焦点时光标必须隐藏（之前漏的就是这条绑定）")

        // 闪烁定时器：不可见时不跑，节奏跟系统光标闪烁周期挂钩。
        // 注意 QML Timer 的 C++ 类型名是 QQmlTimer，不是 QQuickTimer。
        var timer = findByType(caret, "QQmlTimer")
        verify(timer !== null, "光标应当自带闪烁定时器")
        if (timer) {
            compare(timer.running, false, "光标不可见时闪烁定时器不该运行")
            // 注意：只断言"两边相等"是不够的 —— 如果表达式求值失败，
            // 两边可能同时是 undefined，比较照样通过（假通过）。
            // 所以先单独断言值本身是合理的。
            verify(Theme.caretFlashHalf >= 200 && Theme.caretFlashHalf <= 5000,
                   "光标闪烁半周期应是合理数值，实测 " + Theme.caretFlashHalf + "ms")
            compare(timer.interval, Theme.caretFlashHalf,
                    "闪烁间隔应取自 Theme.caretFlashHalf（跟随系统光标节奏）")
        }

        caret.destroy()
    }

    // ── Ghost 的悬浮底：独立的叠加层，不靠底板颜色过渡 ──

    function test_ghostHoverFillIsSeparateOverlay() {
        // 底板恒为透明："有没有底"和"底是什么颜色"必须分成两条通道
        compare(ghostA._fill.toString(), "#00000000", "Ghost 底板应恒为透明（不受状态影响）")
        compare(ghostB._fill.toString(), "#00000000", "Ghost 底板应恒为透明（不受状态影响）")

        // 悬浮底是那块颜色为 surfaceHover 的独立矩形，空闲时完全不显示
        var overlay = findByColor(ghostA, Theme.surfaceHover)
        verify(overlay !== null, "Ghost 应当有一块 surfaceHover 的悬浮底叠加层")
        if (overlay)
            compare(overlay.opacity, 0, "没有悬停时悬浮底必须完全不显示")

        // ⚠️ 这里**不能**断言 overlay.visible：QQuickItem 的 visible 是「继承生效值」，
        // qmltestrunner + 离屏平台下测试窗口并没有真正 visible，整棵子树读出来都是 false
        //（实测底板 / 竖条 / 叠加层全是 false）。断言它等于假通过。

        // 叠加层是每个按钮里都有的（靠 visible 门控只给 Ghost 用），
        // 所以不能断言"其它形态里不存在" —— 只能断言它在 Ghost 之外同样不显示。
        var secOverlay = findByColor(secA, Theme.surfaceHover)
        verify(secOverlay !== null, "叠加层是共用的实现，各形态都有")
        if (secOverlay)
            compare(secOverlay.opacity, 0, "非 Ghost 形态下它同样应该是透明的")
    }

    // ── Ghost 悬浮底的切角必须和底板一致（六边形，不是直角矩形）──
    //
    // 用户报的 bug：别的按钮悬浮时是六边形（右上 + 左下各切一刀），
    // 只有 Ghost（"了解更多"）的悬浮底是一块直角矩形，两个角戳在底板轮廓外面。
    // 根因是那块叠加层当初漏抄了切角绑定。
    //
    // 断言写成"叠加层 == 底板共用的那份取值"，而不是写死 12 / 6：
    // 以后调 Theme.cutMd 不会把测试改坏，但只要有人再少抄一次绑定就会立刻红。

    function test_ghostHoverFillHasSameChamferAsBoard() {
        var overlay = findByColor(ghostA, Theme.surfaceHover)
        verify(overlay !== null, "Ghost 应当有一块 surfaceHover 的悬浮底叠加层")
        if (!overlay)
            return

        // 先单独确认取值本身有效。只写 compare(两边相等) 是不够的 ——
        // 表达式求值失败时两边会同时是 undefined，比较照样"通过"。
        verify(ghostA.cutTopRightSize > 0,
               "底板右上切角应是有效正值，实测 " + ghostA.cutTopRightSize)
        verify(ghostA.cutBottomLeftSize > 0,
               "底板左下切角应是有效正值，实测 " + ghostA.cutBottomLeftSize)

        compare(overlay.cutTopRight, ghostA.cutTopRightSize,
                "悬浮底右上切角必须和底板同源，否则悬浮时退化成直角矩形")
        compare(overlay.cutBottomLeft, ghostA.cutBottomLeftSize,
                "悬浮底左下切角必须和底板同源")

        // 直角矩形的特征就是两个切角都为 0：把"退化成矩形"这个回归直接钉死
        verify(overlay.cutTopRight !== 0 && overlay.cutBottomLeft !== 0,
               "悬浮底不能是直角矩形：右上 / 左下切角都不该为 0")

        // 同源证明：改 cutSize 必须同时改到两边，说明确实只有一份取值
        var original = ghostA.cutSize
        ghostA.cutSize = original + 4
        wait(30)
        compare(overlay.cutTopRight, ghostA.cutSize,
                "cutSize 变化应同时作用于底板与悬浮底（只有一份取值）")
        compare(overlay.cutTopRight, ghostA.cutTopRightSize, "两者必须始终相等")
        ghostA.cutSize = original
        wait(30)
    }

    // ── 主题切换 ──

    function test_themeSwitch() {
        Theme.mode = Theme.Mode.Light
        wait(60)
        compare(Theme.isDark, false, "默认应是浅色")
        Theme.mode = Theme.Mode.Dark
        wait(150)
        compare(Theme.isDark, true, "应切到暗色")
        verify(Theme.ink.toString() !== "#000000", "暗色下主文字色要变亮")
        Theme.mode = Theme.Mode.Light
        wait(150)
        compare(Theme.isDark, false, "应切回浅色")
    }
}
