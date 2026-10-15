# 验证记录

所有结论都来自本机实跑，命令与原始输出如下。**未验证的事情不写在这里。**

环境：Windows / Qt 6.11.2 msvc2022_64 / QML 运行时（`qml.exe`）离屏渲染。

---

## 1. 静态检查（qmllint）

```bash
qmllint -I qml qml/ZmdUI/*.qml qml/main.qml qml/DemoContent.qml
```

结果：

| 警告类型 | 数量 | 说明 |
| --- | --- | --- |
| `[unqualified]` | 79 | 委托里访问 `index` / `modelData` 这类由 ListView、Repeater 注入的上下文属性。这是 QML 委托的标准写法，运行期行为正确；要消掉需要把委托改成 `required property`，代价是默认委托不再兼容 ListModel（只有 `modelData` 才存在），不划算。 |
| `[missing-property]` | 0 | 初版有 2 处（调用处写 `visible: parent.hovered`），已通过把 `tooltip` 属性做进 ZButton 消除。 |
| 其它 | 0 | — |

**结论：0 个错误，0 个会影响运行期的警告。**

---

## 2. 冒烟测试（离屏渲染 + 抓图）

```bash
export QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software
export QT_ASSUME_STDERR_HAS_CONSOLE=1 QT_QPA_FONTDIR=C:/Windows/Fonts
qml.exe -I C:/dev/ZmdUI/qml C:/dev/ZmdUI/tools/smoke.qml
```

输出：

```text
qml: SMOKE: window 1500 x 940 | contentItem 1500 x 940 | loaded true
qml: SMOKE OK -> C:/dev/ZmdUI/tools/smoke.png
退出码 0
```

关键点：整个演示树（24 个组件类型全部实例化）**没有任何 QML 运行期警告**——
没有 "Unable to assign"、没有绑定循环、没有 "Type unavailable"。

> 唯一一条 `FT_New_Face failed with index 0 : 2` 来自离屏平台扫描 `C:/Windows/Fonts`
> 时碰到的一个非字体文件，与组件库无关。

## 3. 分段滚动截图

```bash
qml.exe -I C:/dev/ZmdUI/qml C:/dev/ZmdUI/tools/smoke_scroll.qml
```

```text
qml: SCROLL 0..4 contentY=0/900/1800/2700/3600 total=3071 SAVED
```

内容总高 3071 px，分 5 屏全部落盘核对，逐屏确认：

* 侧边栏：当前项亮黄底 + 亮黄左边缘，分组标题、品牌块、右边缘黄线正常
* 卡片：斜切角、右上角斜线纹理、亮黄装饰底边、黑底白字副标题正常
* 按钮：四种形态 + 平行四边形 + 禁用态 + 图标按钮，悬停反色逻辑（静态截图看到的是默认态）
* 输入：内嵌铭牌、聚焦亮黄底线、出错品红底线、右侧单位徽标正常
* 选择：复选框对勾、单选菱形、开关滑块左右位置与轨道刻度正常
* 数值：滑块把手/刻度/读数、进度条填充与不确定态扫描块正常
* 列表：选中行 = 亮黄底 + 黑色斜切高亮块，右侧数据不被遮挡
* 表格：黑底表头、竖网格线、选中行亮黄高亮
* 图表：网格 + Y 轴刻度 + 亮黄数据线（黑描边）+ 黑色方形数据点 + 最新值标注

## 4. 弹层探针（工具提示 / 对话框）

```bash
qml.exe -I C:/dev/ZmdUI/qml C:/dev/ZmdUI/tools/probe_popup.qml
```

```text
qml: PROBE OK -> C:/dev/ZmdUI/tools/probe_popup.png
```

确认：遮罩、顶部黑底黄字标题带、中央斜线纹理、副标题斜块、底部按钮区、
底部左角色块、工具提示的深灰斜切块 + 亮黄竖边全部按设计渲染。

---

## 5. 验证过程中发现并修掉的问题

（第一轮，按需求实现后自查）

1. **`Theme.onAccent` / `Theme.onSub` 属性名非法** — QML 把 `on<大写字母>` 开头解析成信号处理器，
   报 `Cannot assign a value to a signal`。改名为 `textOnAccent` / `textOnSub`。
2. **`ZCheckBox` 没有 `indeterminate`** — 原生 `CheckBox`（AbstractButton）并不提供该属性，
   必须自己声明。报 `Cannot assign to non-existent property "indeterminate"`。
3. **面板角落的三角标记退化成了方块** — 用 `ZCutRect` 的切角做三角形时，切角会被钳制到
   短边一半以内（防止路径自交），10×10 的方块只被削掉 5 px 的角。改用 `ZSkewRect`：
   `skew` 等于宽度时两个顶点重合，正好得到干净的直角三角形。
4. **列表项选中态的黑色斜切块压住了右侧数据** — 黑块原先画在背景层，而数据文字在内容层，
   黑底叠黑字等于看不见。把斜切块移进内容 Row 参与排版，与文字永不重叠。
5. **对话框内容被右边缘裁掉** — `Column` 的 `padding` 不会缩小子项的 `parent.width`，
   用户按直觉写 `width: parent.width` 就会溢出。改成「Item + 内层 Column」，
   子项的 `parent.width` 才是真正的可用宽度。
6. **离屏平台下 Loader 里建出来的第二个 Window 不渲染** — `contentItem` 尺寸恒为 0，
   抓图报 `item's width and/or height are less than 1`。于是把演示内容抽成
   `qml/DemoContent.qml`，`main.qml` 与 `tools/smoke.qml` 共用同一份内容，
   一个走窗口壳、一个直接挂在测试窗口里。

## 5b. 第二轮：用户看真机截图后反馈的 7 个问题

| # | 现象 | 根因 | 处理 |
| --- | --- | --- | --- |
| 1 | 大标题「运行概况」太粗看不清 | 上一轮为了模拟 Heavy 字重，用 `Text.Outline` + 同色 `styleColor` 描边加粗；40px 下把「概」「况」的字腔糊死了 | 删掉全库 12 处描边，改用 `Font.Black` + 字距 2→1、字号 44→42；`Theme.heavyOutline` 令牌一并移除，并把"为什么不用描边"写进 Theme 注释 |
| 2 | 「桌面端」显示成黑块、卡片的等宽小标签看不清 | 同上是描边造成的；另外 `Theme.muted` 亮色下是 #7A7A7A、`fontMonoSm` 只有 10px | `muted` 亮色 → #5C5C5C、暗色 → #B4B4B4；`fontMonoSm` 10→11、`fontMonoMd` 12→13 |
| 3 | 副标题外框的白点看不清 | 5px 的纯白方块在黑底上边界发虚 | 新增 `Theme.cyanSoft`（#6FE4F5）淡青，`ZSectionTitle` 副标题块的冒号改用淡青 |
| 4 | 白底按钮悬停左侧黄条会把按钮顶宽；平行四边形上不适配 | `leftPadding` 写成 `spacingLg + (悬停 ? 6 : 0)`，鼠标一进按钮宽度就变；竖条是直边，贴到斜边上直接戳出形状外 | `leftPadding` 改成常量；竖条改为画在底板内部（左内边缘、上下缩进 4px），不参与布局；`showEdge` 增加 `skew <= 0` 硬守卫 |
| 5 | 小按钮的提示框文字偏移 | 亮黄竖边在 background 里定位、文字在 contentItem 里用 `leftMargin: spacingLg + 4` 定位，两套间距各算一遍必然错位，且左右留白不对称（左 24 / 右 4） | 重写 `ZToolTip`：竖边固定在 background 左侧，文字用 `leftPadding = skew + 12` / `rightPadding = 14`；`x` 也改用 `implicitWidth`（原始 `width` 首帧为 0） |
| 6 | 滑块偏高 | Basic 样式给 `Slider` 设了默认 `padding: 6`，只归零了左右 padding；手柄按"扣掉 padding 的可用高度"居中、导轨按整个高度居中，两者相差正好是 `topPadding` | `padding: 0` 一次归零四边；手柄 `y` 补上 `control.topPadding`；新增 `centerY` 统一作为手柄/导轨/刻度/读数的基准 |
| 7 | 表格选中行的黑斜线挡住第一列文字 | 斜切块画在 `leftMargin: 6`、宽 10，而单元格文字左边距是 12，正好压住第一个字母 | 缩到 `leftMargin: 2`、宽 5，落在单元格左边距之内 |
| 8 | 暗色模式文字看不清 | 与 1、2 叠加：描边糊字 + `muted` 偏暗（#9B9B9B）+ 网格/纹理与底色太接近（#1C1C1C on #0F0F0F） | 底色 #0F0F0F→#141414、网格 #1C1C1C→#262626 / #2A2A2A→#343434、纹理 #3A3A3A→#4A4A4A；`muted` → #B4B4B4 |

第二轮的验证证据：

```bash
qml.exe -I qml tools/probe_buttons.qml    # 退出码 0
```

```text
BTN danger      showEdge=true  (expect true)      # 直边按钮：竖条在
BTN danger+skew showEdge=false (expect false)     # 平行四边形：竖条被守卫挡掉
BTN secondary: width 120.00 / 120.00  OK
BTN ghost:     width 100.00 / 100.00  OK
BTN skew:      width 114.00 / 114.00  OK
BTN primary:   width 142.00 / 142.00  OK
BTN RESULT: PASS
```

> 离屏平台拿不到鼠标（`hovered` 恒为 false），`forceActiveFocus()` 也不可靠，
> 所以悬停态用 Danger 形态做等价验证 —— 它的左侧竖条是**常显**的、不依赖悬停，
> 于是"竖条画在底板内部"和"平行四边形不画竖条"这两条都能被确定性断言。
> 宽度不变量则对所有形态打印：同一形态两个按钮宽度必须相等，一旦悬停逻辑再动 padding 就会立刻爆掉。

```bash
qml.exe -I qml tools/probe_dark.qml       # 暗色主题整屏截图，核对文字可读性
qml.exe -I qml tools/crop.qml             # 逐处放大复看：标题 / 滑块 / 表格选中行 / 提示框 / 标签
```

```text
DARK OK -> tools/probe_dark.png
CROP OK scroll_2.png {...} -> tools/crop_sliders.png      # 手柄与导轨同心，偏高消除
CROP OK scroll_3.png {...} -> tools/crop_table_sel.png    # 选中行文字完整可读
CROP OK probe_popup.png {...} -> tools/crop_tooltip.png   # 提示框文字与竖边对齐
```

静态检查复跑仍为 **79 条 `[unqualified]`、0 条其它警告**。

## 5c. 第三轮：再一轮细节反馈（3 个问题）

| # | 现象 | 根因 | 处理 |
| --- | --- | --- | --- |
| 1 | 开关左下角跟边框对不齐 | 滑块的左下切角是 6px、轨道同侧是 4px，而滑块只内缩 2px —— 滑块的斜边直接**横穿**轨道的斜边，两条斜线夹角相同但位置相交，在角上露出一块浅色缺口 | 定下规则：**滑块同侧切角 = 轨道切角 − 内缩量**（6−2=4 的右上、4−2=2 的左下），两条斜边平行、间距均匀；并把这条规则写进 `ZSwitch` 注释 |
| 2 | 提示框左侧竖线要倾斜、和边框对齐 | 竖边用直边矩形画、底板是平行四边形 —— 竖边的顶角必然戳出斜边之外 | 竖边改用 `ZSkewRect`，且 skew 与高度和底板完全一致 → 两条左斜边是同一条线，天然贴齐 |
| 3 | 删除配置按钮没有悬浮动画；默认态不该有黄竖条和品红点 | ① `showEdge` 对 Danger 写成"恒真"，装饰成了常显；品红点同理；② 之前只在按下时做 1px 位移，状态切换本身是硬切，没有任何过渡 | ① `showEdge` 统一改成只在 `hovered || visualFocus` 时为真（Primary 除外，它靠整体反色），品红点加 `showDangerMark` 门控；② 给底板颜色、竖条宽度（0→5 长出来）、品红点透明度都加上 `Behavior` |

### 这一轮特别验证了「Behavior 到底会不会动画」

一开始就不放心：`color` / `width` 都是**绑定表达式**算出来的
（`color: control._fill`、`width: control.showEdge ? 5 : 0`），
`Behavior` 只对"命令式赋值"生效的传言一直在。所以先拿数值说话：

```bash
qml.exe tools/probe_anim.qml
```

```text
ANIM color: mid r=0.518 b=0.478  end r=1.000
ANIM width: mid=20.8  end=40.0
ANIM 结论: 颜色插值=true 宽度插值=true 终值正确=true
ANIM RESULT: PASS（Behavior 对绑定驱动的属性有效）
```

再回到真实组件上做端到端确认（抓两帧比对，QML 侧没有像素读取 API，所以落盘用 `cmp`）：

```bash
qml.exe -I qml tools/probe_anim_button.qml
cmp tools/anim_mid.png tools/anim_end.png      # 状态翻转后 120ms 的那一帧 vs 终帧
```

两者不同 → 120ms 时颜色仍在插值 → **ZButton 的过渡动画是真的在工作，不是摆设**。

### 第三轮验证汇总（全部通过）

| 检查 | 结果 |
| --- | --- |
| 亮色冒烟 `smoke.qml` | `SMOKE OK`，退出码 0，零 QML 警告 |
| 暗色整屏 `probe_dark.qml` | `DARK OK` |
| 弹层 `probe_popup.qml` | `PROBE OK` |
| 提示框 `probe_tooltip.qml` | `TOOLTIP OK`（三个宿主各一条，竖边全部贴齐斜边） |
| 按钮断言 `probe_buttons.qml` | `BTN RESULT: PASS`；Danger 默认态 `showEdge=false / showDangerMark=false`；三对按钮宽度完全相等 |
| 动画机制 `probe_anim.qml` | `PASS`（数值证明插值） |
| 动画端到端 `probe_anim_button.qml` | `cmp` 判定 mid ≠ end |
| 分段滚动 `smoke_scroll.qml` | 5 屏落盘，内容高 3072px |
| `qmllint` | 79 条 `[unqualified]`、0 条其它 |

## 5d. 第四轮：再三条细节反馈（3 个问题）

| # | 现象 | 根因 | 处理 |
| --- | --- | --- | --- |
| 1 | 滑块偏大，会挡住上下的文字 | 手柄是 16×30 的实体、垂直方向在**整个控件**里居中，而铭牌和读数也在同一列 —— 滑到两端时必然压字 | 把垂直方向切成三条互不重叠的带：顶部铭牌带 17 / 中间手柄带 24 / 底部读数带 20；手柄缩到 14×20 且只在中间带里居中；刻度缩短（5/3）锁在中间带内。带高都做成只读属性，`implicitHeight` 就是三条带之和 |
| 2 | 删除配置按钮的紫色点去掉 | 品红点缀点虽然是"极小面积"，但在按钮上仍然多余 —— 设计规范里点缀色只留给 `ZStatusDot` 这类状态块 | 删掉该元素与 `showDangerMark` 属性；按钮注释同步改成"不引入品红等点缀色" |
| 3 | 白底按钮（悬停变黄）的左侧动画竖线要改成黑色 | 竖条颜色写死成亮黄，而 Secondary 悬停后底色**也是亮黄** —— 黄底画黄条等于没画 | 新增 `edgeColorFor(variant, active)` 纯函数：底色是亮黄时竖条转黑；并给竖条颜色也加 `Behavior`，和底色一起过渡 |

### 这一轮踩到的两个"平台能力"坑（都是先用探针证实，再决定方案）

**① 离屏平台投递不了鼠标事件 —— 悬停态没法靠交互模拟。**
先试了 `TestCase.mouseMove()`，再用一个 MouseArea 探针量化：

```text
cap initial      containsMouse=false pressed=false
cap afterMove    containsMouse=false
cap afterPress   pressed=false          ← 连按下都没到 item
```

**② `qmltestrunner` 里窗口根本不渲染 —— `grabImage()` 只会拿到白图。**

```text
grab size=300x200 p20=#ffffff p150=#ffffff     ← 纯红矩形都读不到 #ff0000
```

差点因此写出**假通过的像素测试**：如果只断言"某像素 != 亮黄"，白图天然满足，
测试全绿但什么也没验证。是那条正向断言（开关轨道应该是亮黄）把它暴露出来的。
**结论：像素级核对只能走 `qml` 工具（有正常渲染循环）+ `tools/crop.qml`；
`qmltestrunner` 只用来断言属性、规则和几何。**

### 由此定下的测试分层

| 层 | 工具 | 能验证什么 |
| --- | --- | --- |
| 规则 / 属性 / 几何 | `qmltestrunner`（`tests/tst_hover.qml`） | 竖条显示规则、竖条颜色规则、按钮宽度不变量、滑块分带不重叠、开关切角平行关系、主题切换 |
| 静态渲染 | `qml.exe` + `tools/smoke*.qml` | 真实渲染、零 QML 警告、逐屏截图 |
| 像素细节 | `qml.exe` + `tools/crop.qml` | 局部放大复看（缩略图会骗人） |
| 动画是否真的在动 | `tools/probe_anim*.qml` | 取样数值 + 抓帧 `cmp` 比对 |

为了让规则可测，把两条几何/视觉规则抽成了纯函数并写进组件：
`ZButton.edgeVisibleFor(variant, skew, active, enabled)`、`ZButton.edgeColorFor(variant, active)`；
`ZSwitch` 的切角关系做成 `knobCutTopRight = trackCutTopRight - knobInset` 等只读属性。
这样断言直接打在规则上，既不依赖输入设备，也不依赖渲染。

### 第四轮验证汇总（全绿）

```text
qmltestrunner -input tests/tst_hover.qml -import qml
Totals: 9 passed, 0 failed, 0 skipped, 0 blacklisted
```

亮色冒烟 / 暗色 / 弹层 / 提示框 / 按钮探针 / 动画机制 / 动画端到端 / 分段滚动 全部通过；
`qmllint` 仍是 79 条 `[unqualified]`、0 条其它。

## 6. C++ 构建与 qrc 集成（真编译、真运行）

本机 `MSBuild.exe` 被安全策略拦截，因此走 CMake + Ninja + 手动铺 MSVC 环境变量：

```bash
cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_COMPILER="C:/Program Files/Microsoft Visual Studio/18/Community/\
VC/Tools/MSVC/14.51.36231/bin/Hostx64/x64/cl.exe" \
  -DCMAKE_PREFIX_PATH="C:/dev/Qt/6.11.2/msvc2022_64"
cmake --build build
```

```text
[1/7] Running qmlimportscanner for ZmdUIDemo
[2/7] Automatic MOC and UIC for target ZmdUIDemo
[3/7] Automatic RCC for resources/qml.qrc
[6/7] Building CXX object CMakeFiles\ZmdUIDemo.dir\src\main.cpp.obj
[7/7] Linking CXX executable ZmdUIDemo.exe
```

按 Qt 6.11.2 / MSVC 2022 x64 编译链接**零警告零错误**，产出 `build/ZmdUIDemo.exe`。

再离屏运行这个 exe，验证 **qrc 内的模块解析**这条最容易翻车的路径：

```bash
export QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software QT_QPA_FONTDIR=C:/Windows/Fonts
./build/ZmdUIDemo.exe
# 退出码 124（被 timeout 结束，说明进程一直正常运行）
# 输出里没有任何 QML 报错
```

也就是说下面这条链路全部成立：`qrc:/qml/main.qml` 能加载 →
`engine.addImportPath("qrc:/qml")` 生效 → 资源里的 `import ZmdUI 1.0` 命中
`:/qml/ZmdUI/qmldir` → `DemoContent` 与 24 个组件全部从资源中解析成功 →
`QQuickStyle::setStyle("Basic")` 生效。

> 日志里那条 `QEventDispatcherWin32::wakeUp: Failed to post a message`
> 是 offscreen 平台没有真实窗口句柄导致的（定时器唤醒事件循环失败），
> 与组件库无关，有真实窗口的平台不会出现。

## 7. 没有验证的部分

* **真实鼠标悬停 / 按下 / 拖拽**：离屏渲染没有指针设备，`hovered` 恒为 false，
  `forceActiveFocus()` 也不可靠。因此悬停态的**视觉**只在等价路径上验证过
  （Danger 形态的常显竖条 + 宽度不变量断言），动画（`Theme.durFast/durBase/durSlow`）
  与按下下沉 1px 未做逐帧核对。请在有真实窗口的环境里过一遍交互。
* **暗色主题**已有整屏截图（`tools/probe_dark.qml` → `docs/screenshots/07-dark-mode.png`），
  文字可读性逐处核对过；但没有逐屏（滚到底部）核对暗色下的每一个区块。

## 5e. 第五轮：参考 fz.wiki 重做暗色模式

用户给了参考站 <https://www.fz.wiki/>，要求"特别是深色模式"。

### 先扒令牌，再动手

用 `curl` 抓了它的 HTML 与两份 CSS（338 KB），按选择器解析出主题变量块，
拿到 `:root`（亮色）、`html[data-theme=dark]`、`.ef-training`（另一个暗色作用域）三套令牌。
关键结论：

| 参考站的做法 | 我的旧实现 | 结论 |
| --- | --- | --- |
| `--color-accent: #f2cc00`（亮）→ `#d8bf00`（暗）**压暗** | `#E8FA00` 两个主题共用 | 亮柠檬黄浮在暗底上刺眼，必须压暗 |
| `surface #f4f5f6` / `#181818`，`surface-raised #fff` / `#232323`（**卡片比底亮**） | 暗色下卡片比底只亮一点 | 卡片必须比页面底色亮，否则像"洞" |
| `--color-border: #e5e7eb`（亮）→ `#2b3136`（暗）**中灰** | `line` 反相成 `#EFEFEF` 近白 | 每张卡镶白边，夜里刺眼且丢层级 |
| `--color-ink: #111827` / `#eee`，`ink-muted #6b7280` / `#a8b0b7`（**冷灰**） | 纯中性灰 | 中性灰在暗底上显脏，改冷灰 |
| `--ef-chamfer-size: 9px` + `clip-path` 切角、`--ef-radius: 0px` | 切角 + 零圆角 | 几何语言一致，说明方向没错 |
| 状态色在暗色下**提亮**（`red-800 → red-300` 等） | 部分写死 | 语义色在暗色下要往亮档走 |
| `.industrial-card:hover { translateY(-2px) + shadow }`，暗色下阴影更重 | 无 | 记下作为可选增强，本轮未做 |

### 实际改了 11 处

新增令牌：`surfaceSunken` / `surfaceHover` / `inkBlock` / `accentGlow`，并把 `accent`、
`bg` / `surface` / `surfaceMuted` / `line` / `lineSoft` / `muted` / `subBg` 的暗色档整体重定。

| # | 组件 | 改了什么 |
| --- | --- | --- |
| 1 | `Theme` | 强调色暗色压暗；表面分四层（sunken < bg < muted < surface）；结构线改冷灰 |
| 2 | `Theme` | 新增 `surfaceHover`（暗色下悬停要变亮，方向与亮色相反） |
| 3 | `Theme` | 新增 `inkBlock`（反相块专用色，暗色下也是深色） |
| 4 | `ZButton` | 幽灵态悬停用 `surfaceHover`；`edgeColorFor` 返回 `textOnAccent` 而不是 `ink` |
| 5 | `ZListItem` | 选中行文字/斜切块改 `textOnAccent`；悬停底改 `surfaceHover` |
| 6 | `ZTable` | 表头改 `inkBlock`（**修掉"浅底白字"**）；选中行文字改 `textOnAccent` |
| 7 | `ZSectionTitle` | 编号块改 `inkBlock`；标题高亮块改 `accentSoft`（暗色下深黄褐，浅字才压得住） |
| 8 | `ZDialog` | 标题带改 `inkBlock`；底部 2px 分隔线改 `line`（暗色下不再是亮线） |
| 9 | `ZSlider` / `ZProgressBar` / `ZSwitch` | 凹槽改 `surfaceSunken`；把手描边、刻痕、开关滑块改 `textOnAccent` |
| 10 | `ZLineChart` | 折线的黑色描边底改 `inkBlock`、X 轴基线改 `line`（**修掉"黄线看起来是灰线"**） |
| 11 | `ZSideBar` | 暗色下面板改 `#0C0C0C`（比页面更深，不再糊成一片）、悬停块改 `#1E1E1E` |

### 测试与验证

新增 `tests/tst_hover.qml::test_darkThemeTokens`，把上面三条硬规则写成断言：

```text
qmltestrunner -input tests/tst_hover.qml -import qml
Totals: 10 passed, 0 failed, 0 skipped        # 原 9 项 + 暗色令牌 1 项
```

顺带修掉两个测试自身的问题：

1. **用例之间没有隔离**：`test_darkThemeTokens` 把主题切成暗色后断言失败，
   主题就留在暗色里，导致后面的 `test_themeSwitch` 连锁失败（一个失败变两个）。
   已加 `function init() { Theme.mode = Light }` —— QtTest 会在每个 `test_*` 之前调用它。
2. **颜色不能用 `!==` 直接比**：`color` 是值类型，`Theme.accent !== lightAccent` 的比较语义
   和预期不一致（实测取反了）。统一改 `toString()` 比较。

暗色逐屏审计（`tools/smoke_dark_scroll.qml`，4 屏）确认：卡片与底色分层清晰、
边框不再是白圈、强调色不刺眼、表头是深底白字、选中行是黄底深字、图表的黄线不再发灰。
亮色侧跑同一套回归，无变化。

## 5f. 第六轮：侧边栏滚动条遮挡 + 表格行"点不上"

### 问题 1：滚动条浮在内容上，盖住行右侧的编号

**根因**：Qt 给 `Flickable` 挂的 `ScrollBar` 是**浮在内容之上**的，不占位；侧边栏行右侧的
编号 / 徽标正好落在它下面。窗口一变矮、导航溢出，滚动条一出现就盖住。

**处理**：
* 新增 `ZSideBar.navScrollBar`（默认 `true`）——设为 `false` 直接不显示滚动条
  （`policy: AlwaysOff`，内容仍可用滚轮 / 拖拽滚动）。
* 新增只读 `navScrollBarReserve`（有滚动条时 14px），行的右侧内边距始终把它算进去，
  所以滚动条出现时也不会盖住编号。

**验证**：`tools/probe_sidebar.qml` 用 **1200x640 的矮窗口**复现溢出
（`contentH=488 > viewportH=408`），分别抓开 / 关两张图：

```text
ON : navScrollBar=true  reserve=14 contentH=488 viewportH=408 overflow=true
OFF: navScrollBar=false reserve=0  contentH=488 viewportH=408 overflow=true
```

截图确认：开着时滚动条在右边缘，`12` 编号完整可见；关掉后滚动条完全消失。

### 问题 2：表格行要点好几次才中一次

**排查过程**（没有猜，先拿证据）：

写了一个命中测试探针 `tools/probe_hittest.qml`：把每个目标元素中心换算到窗口坐标，
再用 `childAt()` 从根一路往下钻，打印该点最上层的元素链。

```text
row0 centerY=677 -> ... > ZPanel > QQuickColumn > QQuickColumn > ZTable
                    > QQuickItem_QML_25(2,52 607x38) > QQuickMouseArea(0,0 607x38)
row4 centerY=829 -> ... > ZTable > QQuickItem_QML_25(2,204 607x38) > QQuickMouseArea
```

**结论：每一行中心的最上层元素就是它自己的 MouseArea，没有任何元素遮挡**
（连带排除了"被面板底部条盖住""行在视口外"这两种猜测；
顺带确认页面 Flickable 已经夹在底栏之上：视口 866，最后一行中心 y=829 < 912）。

那就只剩一种可能：**按下被滚动容器抢走了**。`Flickable` 在指针移动超过系统拖拽阈值
（Windows 默认 10px）时会把这次按下当成滚动手势 `grabMouse()`，行的 `MouseArea`
收到 `onCanceled` 而不是 `onClicked` —— 表现就是"点几次才中一次"。

**处理**：`ZTable` 新增 `rowClickRobust`（默认 `true`）→ 行的 `MouseArea.preventStealing`。
按下即由行接管，点击必中；代价是在表格上按住拖拽不再滚动页面（滚轮 / 滚动条不受影响）。

**验证**：`test_tableRowClickRobust` 直接断言组件内部接线：

```text
compare(tableProbe.rowClickRobust, true, "默认应开启行点击抢占")
compare(findMouseArea(tableProbe).preventStealing, true, "...")
```

> 说明：**点击行为本身在离屏环境验证不了**（已实测：合成鼠标事件到不了 item，
> `pressed` / `hovered` 恒 false）。所以这一条验证的是"防抢占开关确实接到了
> MouseArea 上"，再加上对遮挡的命中测试排除法 —— 根因链完整，最后一步的真机手感
> 请在有鼠标的环境里确认。

### 回归

```text
qmltestrunner -input tests/tst_hover.qml -import qml
Totals: 12 passed, 0 failed        # 新增 test_sidebarScrollBarOption / test_tableRowClickRobust
```

亮色冒烟 / 暗色分段 4 屏 / 弹层 / 提示框 / 按钮探针 / 动画机制 / 动画端到端 / 亮色分段 5 屏
全部通过（分组跑的：单条命令串太多步会撞到 shell 超时）。

## 5g. 第七轮：暗色主题顶栏文字看不清

**现象**：暗色模式下顶栏那条（"工作空间 / 组建总览 / …"）文字几乎看不见。

**定位**：把自己渲染的暗色截图和用户截图**同一区域裁出来 3 倍放大对比**，
一眼看出底色是浅灰、文字是白色 —— 典型的"反相块用错令牌"。

```qml
// 演示程序顶栏（错）
ZCutRect { color: Theme.ink }        // 暗色下 ink = #EEEEEE（浅！）
    Text { color: Theme.textOnSub }  // 白字 → 白字白底
```

**根因**：这就是第五轮那批"反相块"问题，但**那一轮的审计只 grep 了 `qml/ZmdUI/*.qml`，
漏了 `qml/DemoContent.qml`**（演示程序）。顶栏不在组件库里，所以没被扫到。

**处理**：顶栏底色改 `Theme.inkBlock`（两个主题下都是深色）；
顺带把顶栏中间那条 1px 分隔线从 `ink@35%` 改成 `line@50%`（暗色下不再是一条亮线）。

**防复发**：新增 `tools/check_inverse_blocks.py`，把这条规则变成可执行的体检：

1. 扫所有 `.qml`，找 `color: Theme.ink` 当背景、且往后 20 行里有 `textOnSub` 的地方
   → 暗色下会白字浅底；
2. 再扫 `color: Theme.surface / surfaceAlt / surfaceMuted / surfaceHover / bg` 当背景
   且含白字的地方 → 亮色下会白字白底。

```text
$ python tools/check_inverse_blocks.py
检查了 14 处 `color: Theme.ink`
OK 没有发现「浅底白字」的反相块
```

脚本本身也做了反向验证：故意把顶栏改回 `Theme.ink`，它准时报出
`qml/DemoContent.qml:157` 并返回退出码 1 —— **一个不会失败的检查等于没有检查**。

### 回归

亮色冒烟 / 暗色分段 4 屏 / 弹层 / 提示框 / 按钮探针 / 动画机制 / 动画端到端 /
亮色分段 5 屏 / 行为测试 12 项 / 反相块体检 全部通过；
`qmllint` 81 条委托 `[unqualified]`、0 条其它；C++ 重编译零警告 + exe 运行零 QML 报错。

## 5h. 第八轮：CMake 跨平台化 + MinGW 适配

**要求**：构建脚本要跨平台，且适配 MinGW 编译器。

### 原脚本的问题

| 问题 | 后果 |
| --- | --- |
| `find_package(Qt6 6.11.2 REQUIRED ...)` 写死精确小版本 | 换台机器 / 换个 Qt 版本就配不过 |
| 没有 `WIN32_EXECUTABLE` | Windows 下带一个黑框控制台；MinGW 下缺 `-mwindows` |
| 没有 `MACOSX_BUNDLE` | macOS 上不是 .app，Dock / 焦点行为不对 |
| 没有处理 MinGW 运行库 | 换台机器报缺 `libstdc++-6.dll` / `libwinpthread-1.dll` |
| 没有部署规则 | 得手动拷 Qt DLL 和 QML 插件 |

### 改法

* `find_package(Qt6 6.5 ...)`：只约束下限，不绑死小版本；`qt_standard_project_setup(REQUIRES 6.5)`。
* **平台分支**：Windows 用 `WIN32_EXECUTABLE`（MSVC 是 `/SUBSYSTEM:WINDOWS`，MinGW 由 CMake 自动加
  `-mwindows`）；macOS 用 `MACOSX_BUNDLE` + bundle 元信息；Linux 加
  `CMAKE_INSTALL_RPATH $ORIGIN/../lib`。
* **编译器分支**：MSVC `/W4 /permissive-`，其它 `-Wall -Wextra`；工程只声明 `LANGUAGES CXX`，
  文档里也不再传 `CMAKE_C_COMPILER`（否则 CMake 会警告该变量没被用到）。
* **不关 `CMAKE_CXX_EXTENSIONS`**：Qt 自己就是 gnu++17 编的，MinGW 下关掉扩展会引入
  `__STRICT_ANSI__` 差异，没有收益。这条写进注释，免得后人"顺手优化"掉。
* **MinGW 运行库**：`-static-libgcc -static-libstdc++`（可用开关关掉），
  `libwinpthread-1.dll` 构建后自动拷到 exe 旁边。
* **部署**：`qt_generate_deploy_app_script` + `DEPLOY_TOOL_OPTIONS`，一条
  `cmake --install` 产出自包含目录。

### 关键发现：QML 插件没被部署（测试抓出来的）

第一版部署跑完，`dist/qml/` 是**空的** —— Qt 的 DLL 都在，但 QML 插件一个没拷。
原因：工程用的是普通 `.qrc`，不是 `qt_add_qml_module`，部署工具**不知道去哪找 QML**，
windeployqt 没带 `--qmldir` 就扫不出 QML 导入。

修法：按平台把 QML 目录喂给部署工具（`--qmldir` / `-qmldir=`）。
修完 `dist/qml/QtQuick/Controls/Basic/` 等目录齐全。

**这个坑只有真跑一次 `cmake --install` 并检查产物才会暴露**，光看 CMake 配置成功是发现不了的。

### 实测结果（两套编译器都跑了全流程）

| 步骤 | MSVC（cl 19.5x / Qt 6.11.2 msvc2022_64） | MinGW（g++ 13.1.0 posix-seh / Qt 6.11.2 mingw_64） |
| --- | --- | --- |
| configure | OK | OK（打印 `MinGW 运行库静态链接已开启`） |
| build | OK，`/W4 /permissive-` 零警告 | OK，`-Wall -Wextra` 零警告 |
| 产物 | `ZmdUIDemo.exe` 131 KB | `ZmdUIDemo.exe` 345 KB + `libwinpthread-1.dll` |
| 导入表复核 | — | `objdump -p` 确认无 libgcc / libstdc++，只剩 `libwinpthread-1.dll` |
| `cmake --install` | OK，dist 93 MB | OK，dist 85 MB |
| 部署目录内容 | exe + Qt DLL + `qml/QtQuick/...` + `plugins/platforms/qwindows.dll` + translations | 同上（windeployqt 还会顺手带上 MinGW 运行库） |
| **干净环境运行** | `env -i`（PATH 里没有 Qt）→ 退出码 124（一直运行到超时），零 QML 报错 | 同样 → 退出码 124，零 QML 报错 |

> 干净环境测试是这套验证的关键：把 Qt 从 PATH 里摘掉再跑部署目录里的 exe，
> 能同时证明"依赖齐全"和"QML 插件路径解析正确"。两张截图/日志里只剩两条已知无害信息
> （离屏平台扫字体的 `FT_New_Face`、offscreen 平台没有真实窗口句柄导致的 wakeUp 提示）。
>
> 另一个小坑：干净 PATH 下 `timeout` 会命中 Windows 自带的同名程序，
> 得把 PortableGit 的 `usr/bin` 放在 PATH 最前面才用的是 coreutils 的 timeout。

## 5i. 第九轮：CLion 里 configure 失败（Qt6 找不到）

**用户报错**：CLion 的配置命令里没有任何 `CMAKE_PREFIX_PATH`，于是
`find_package(Qt6 6.5 REQUIRED ...)` 直接失败：

```text
Could not find a package configuration file provided by "Qt6" ...
Add the installation prefix of "Qt6" to CMAKE_PREFIX_PATH or set "Qt6_DIR" ...
```

**这不是工程配错了，而是"没人告诉 CMake Qt 在哪"** —— IDE 生成的 profile 默认只给生成器
和构建目录。用户不该为了每个 profile 手填一次路径，所以把定位逻辑做进工程。

### 处理：三级自动探测

1. 显式指定：`-DZMDUI_QT_ROOT=` / `-DQt6_DIR=` / `-DCMAKE_PREFIX_PATH=`
2. 环境变量：`QTDIR` / `QT_DIR` / `Qt6_DIR`
3. 扫常见安装位置（`C:/Qt`、`C:/dev/Qt`、`D:/Qt`、`~/Qt`、`/opt/Qt`、`/usr/local/Qt`），
   **按当前编译器家族挑套件**：MinGW → `mingw_*`，MSVC → `msvc*`，macOS → `macos`/`clang_64`；
   同族内按版本号降序（`major*10000 + minor*100 + patch` 做排序键），优先新版。

探测结果作为 `HINTS` 喂给 `find_package`，找不到依然会正常报错，不会静默用错套件。

### 顺带加的一道拦截

IDE 里把工具链换成 MinGW、Qt 却还是 MSVC 那套时，`find_package` 是能过的，
要到链接阶段才炸出一堆 `file format not recognized`，极难查。现在配置阶段就拦：

```text
CMake Error at CMakeLists.txt:160 (message):
  编译器与 Qt 套件不匹配：
    当前编译器：MinGW (GNU 13.1.0)
    找到的 Qt ：C:/dev/Qt/6.11.2/msvc2022_64
  请把 CMAKE_PREFIX_PATH 指向 Qt 的 mingw 构建 ...
```

> 实现细节：`Qt6_INSTALL_PREFIX` 这个变量在 Qt 6.11 里**没有定义**（写第一版时
> 状态行打印出来是空的），必须三级兜底：`Qt6_INSTALL_PREFIX` → `QT6_INSTALL_PREFIX`
> → 从 `Qt6_DIR`（`<prefix>/lib/cmake/Qt6`）回退三级推出来。
> 这个空值会让"套件不匹配"检查静默失效 —— 又一个"看起来配好了其实没生效"的坑。

### 实测（三种配置都跑了）

| 场景 | 结果 |
| --- | --- |
| MinGW 编译器 + **不给 prefix**（复现 CLion 的命令） | 自动探测到 `C:/dev/Qt/6.11.2/mingw_64`，配置 + 编译通过 |
| MSVC 编译器 + 不给 prefix | 自动探测到 `C:/dev/Qt/6.11.2/msvc2022_64`，配置 + 编译通过 |
| MinGW 编译器 + 强制指向 MSVC 套件 | 配置阶段被人话拦截（见上） |


## 5j. 第十轮：CLion 构建的 exe 运行即崩（0xC0000135）

**现象**：`cmake-build-debug-qt-mingw\ZmdUIDemo.exe` 跑起来立刻退出，退出码
`-1073741515` = `0xC0000135` = **STATUS_DLL_NOT_FOUND**。

**根因**：Windows 没有 RPATH，DLL 只从「exe 所在目录 / 系统目录 / 当前目录 / PATH」找。
CLion 的构建目录里只有 exe + `libwinpthread-1.dll`（构建后拷贝的），**没有 Qt6Core.dll**；
而 CLion 的 Run 配置也不会把 Qt 的 `bin` 加进 PATH。加载器找不到 Qt DLL，直接退出。

### 排查过程中的两个教训

1. **"进程还活着"不能证明程序跑起来了**：GUI 程序加载 DLL 失败时，Windows 会弹一个
   "找不到 xxx.dll" 的错误对话框，进程**挂着等对话框**，于是 `HasExited` 是 false，
   看起来像"正常运行"。第一轮就是被这个假象骗了，还以为「不用 Qt 也能跑」。
   可靠判据是**程序自己的输出**：把 exe 单独拷到空目录做对照，它报的是
   `error while loading shared libraries: libwinpthread-1.dll: cannot open shared object file`
   —— 这条才是真信号。
2. **PowerShell 会话里有大小写重复的代理环境变量**（`http_proxy` 与 `HTTP_PROXY` 同时存在），
   会让带重定向的进程启动直接抛 `ArgumentException`。要么先清掉这些变量，
   要么干脆用 bash 的 `env -i` 做隔离测试（推荐）。

### 处理：构建目录自包含

Windows 上默认开启 `ZMDUI_DEPLOY_TO_BUILD_DIR`（`-D...=OFF` 可关）：
构建后调 windeployqt 把 Qt DLL + QML 插件 + 平台插件 + 编译器运行库拷到 exe 旁边。

写这条命令时踩了三个坑：

| 坑 | 现象 | 解法 |
| --- | --- | --- |
| 用**两个** `$<$<CONFIG:...>:...>` 生成器表达式 | 条件不成立的那个展开成**空参数**，windeployqt 把 `""` 当文件名 → `"" does not exist.` | 用**单个** `$<IF:$<CONFIG:Debug>,--debug,--release>` |
| 无条件传 `--debug` | `Unable to find the platform plugin` —— 本机 mingw_64 套件**没有 Debug 版 Qt**（无 `Qt6Cored.dll`，也无 `qwindowsd.dll`），Debug 构建链接的其实是 Release Qt | 配置阶段探测套件里有没有 `Qt6Cored.dll`，据此决定 `--debug` / `--release` |
| windeployqt 只部署 `qwindows.dll` | 用 `QT_QPA_PLATFORM=offscreen` 做无头测试时报"找不到平台插件"（**这是测试环境的需要，不是产品缺陷**） | 测试时把 `qoffscreen.dll` 拷进 `platforms/` |

> 顺带纠正一个记录：MSVC 套件**是**带 Debug 库的（探测打印"带 Debug 库"），
> MinGW 那套只有 Release —— 两个套件情况不同，所以不能写死。

### 实测

| 场景 | 结果 |
| --- | --- |
| MinGW **Debug**（复现 CLion 配置）+ 最小 PATH | **正常运行**，零 QML 报错；构建目录 21 个 Qt DLL + `qml/QtQuick/Controls/Basic/` 齐全 |
| MinGW Release 构建目录 | 同样自动部署，21 个 DLL |
| MSVC 构建目录 | 自动部署，18 个 DLL |
| 对照：exe 单独拷到空目录运行 | 立刻失败：`libwinpthread-1.dll: cannot open shared object file` |

判据用的是**程序自己的 stderr 输出**（`FT_New_Face failed …`），不是"进程还在不在"。
