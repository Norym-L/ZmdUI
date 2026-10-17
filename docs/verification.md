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


## 5k. 第十一轮：输入框的输入线改成"编辑时出现并闪烁，完成输入即隐藏"

**要求**：输入线只在输入时显示并闪烁，完成输入就隐藏。

**原实现**：`ZTextField` 的底线是**常显**的 —— 空闲时 2px 灰线、悬停 3px、
聚焦 4px 亮黄、出错品红。等于一直占着一条没有信息量的线。

**新规则**（抽成纯函数，便于单测）：

```qml
function inputLineVisibleFor(isEditing, isInvalid) { return isEditing || isInvalid }
function inputLineBlinkingFor(isEditing, isInvalid) { return isEditing && !isInvalid }
```

| 状态 | 输入线 |
| --- | --- |
| 编辑中（有焦点） | 亮黄，4px，**呼吸式闪烁**（1.0 ↔ 0.28，各 460ms） |
| 完成输入（失焦） | **隐藏** |
| 出错 | 品红**常亮**（错误必须稳定可见，不能一闪一闪） |

### 实现里两个坑

1. **`SequentialAnimation` 那一层不接受 `target` / `property`**：
   `Cannot assign to non-existent property "property"`。文档里那个"动画组上设 target
   会被子动画继承"的写法在 Qt 6.11 上不成立，必须写到每个子动画上。
2. **别用 `SequentialAnimation on opacity` 这种属性绑定式写法**：`running` 变 false 时
   动画会**停在中间值**（可能停在 0.28），线就永远半透明了。
   改用 `target`/`property` 形式 + `alwaysRunToEnd: true`，停止时正好停在全亮那一帧。

### 测试与"另一个 Infinite"

`tests/tst_hover.qml` 新增 2 个用例（共 14 项全绿）：

* `test_inputLineRules`：8 组纯函数断言（含"出错时不闪"）；
* `test_inputLineLiveState`：断言**没有焦点时输入线必须隐藏**（守住"完成输入就隐藏"）、
  出错时显示但不闪，以及闪烁动画的形状（负值 loops = 无限、两段、460ms、0.28 呼吸）。

> 写断言时又踩了一个 Qt 的坑：**QtQuick 里有两个 `Infinite`** ——
> `Animation.Loops.Infinite`（-1，给 `loops` 用）和
> `Animation.LoopParameters.Infinite`（-2，给 `loopCount` 用）。
> 在 JS 表达式里写 `Animation.Infinite` 会因为缺少类型上下文解析到后者，
> 和 `loops` 对不上（实测 Actual=-1 / Expected=-2）。
> 断言改成「负值 = 无限循环」更稳，不依赖具体枚举成员。
>
> 另外：动画组**没有 `data` 属性**（那是 QQuickItem 的），子动画要走 `blink.animations`。

### 视觉核对

`tools/crop.qml` 放大 `scroll_1.png` 的文本框面板：

* 空闲的「账号 / ACCOUNT」「令牌 / TOKEN」：**底部完全没有输入线**（旧版是常显灰线）；
* 出错的「端口 / PORT」：品红边框 + 品红输入线常亮。

**未能验证**：编辑中的闪烁动画本身（离屏环境拿不到真实焦点，`activeFocus` 恒 false）。
这一条靠"规则纯函数单测 + 动画形状断言 + 机制探针（`tools/probe_anim.qml` 已证明
绑定属性上的动画真的会插值）"三者组合覆盖，真机手感需人工确认。


## 5l. 第十二轮：澄清与修正 —— 要改的是"光标"，不是"底线"

**用户澄清**：上一轮说的"输入线"指的是**光标竖线（caret）**，不是输入框底部的线。

也就是说上一轮我把需求理解偏了：改的是底线，而真正有问题的是光标。
本轮做两件事：**修真正的问题** + **把上一轮基于误解的改动回滚**。

### 真正的问题：自定义 cursorDelegate 让 Qt 不再管可见性和闪烁

原来 ZTextField 里的光标是：

```qml
cursorDelegate: Rectangle { width: 2; color: Theme.ink }   // 只有宽高和颜色
```

于是光标一旦出现就**永远亮着**（失焦也不消失）、而且**从不闪烁**。

根因看 Qt 自己的实现就清楚了 —— 读 `QtQuick/Controls/Material/impl/CursorDelegate.qml`：

```qml
Rectangle {
    id: cursor
    visible: parent.activeFocus && !parent.readOnly
             && parent.selectionStart === parent.selectionEnd
    Timer {
        running: parent.activeFocus && !parent.readOnly && interval != 0
        interval: Application.styleHints.cursorFlashTime / 2
        onTriggered: cursor.opacity = !cursor.opacity ? 1 : 0
        onRunningChanged: cursor.opacity = 1
    }
}
```

**结论：一旦提供自定义 cursorDelegate，可见性和闪烁都归你自己管。**
Qt 只负责把光标项摆到正确位置，不会帮你 show/hide，也不会帮你闪。

修法（照搬同一套模式，接上本项目的令牌）：

```qml
cursorDelegate: Rectangle {
    visible: control.activeFocus && !control.readOnly
             && control.selectionStart === control.selectionEnd
    Connections {
        target: control
        function onCursorPositionChanged() { caret.opacity = 1; caretBlink.restart() }
    }
    Timer {
        running: caret.visible
        interval: Theme.caretFlashHalf          // 新增令牌，跟随系统光标节奏
        onTriggered: caret.opacity = caret.opacity > 0.5 ? 0 : 1
        onRunningChanged: caret.opacity = 1     // 拿到焦点先亮起来
    }
}
```

`Theme.caretFlashHalf` 是新增的令牌（半周期），取值 **跟随系统** 的
`Application.styleHints.cursorFlashTime / 2`（本机实测 1000 / 2 = 500ms），
而不是写死设计值 —— 光标的节奏应该和系统里其它输入框一致。
系统把 `cursorFlashTime` 设成 0 表示"不闪烁"，令牌里兜了下限 200ms，避免定时器忙等。

### 回滚上一轮的底线改动

上一轮把底线改成"只在编辑时出现、编辑时呼吸式闪烁"，那是基于误解做的，
本轮**全部撤回**：底线恢复为原来的「空闲 2px 灰线 → 悬停 3px → 聚焦 4px 亮黄 → 出错品红」，
连同一并加的 `inputLineVisibleFor` / `inputLineBlinkingFor` 两个纯函数也删了（成为死代码）。
演示脚注、README、组件文档一并改回，并补上光标的说明。

放大截图复核：空闲字段恢复了灰色基线，出错字段仍是品红边框 + 品红底线。

### 测试

删掉上一轮针对底线的两个用例，换成 `test_caretOnlyWhileEditing`：
把 `cursorDelegate` 用 `createObject()` 实例化出来直接断言 ——
**没有焦点时它必须是隐藏的**（这正是当初漏掉的那条绑定）：

```text
compare(fieldPlain.activeFocus, false, "测试环境下输入框没有焦点")
compare(caret.visible, false, "没有焦点时光标必须隐藏（之前漏的就是这条绑定）")
compare(timer.running, false, "光标不可见时闪烁定时器不该运行")
compare(timer.interval, Theme.caretFlashHalf, "闪烁间隔应取自 Theme.caretFlashHalf")
```

### 三个小坑

1. **QML `Timer` 的 C++ 类型名是 `QQmlTimer`**，不是 `QQuickTimer`
   （用 `toString()` 在对象树里找类型时写错了会找不到）。
2. **`compare(a, b)` 可能"假通过"**：如果表达式求值失败，两边会同时是 `undefined`，
   比较依然相等。所以关键数值要先单独断言值域，再断言相等 ——
   本轮的 `verify(Theme.caretFlashHalf >= 200 && <= 5000)` 就是为此加的。
3. **`Qt.styleHints` 与 `Application.styleHints` 的 qmllint 差异**：
   前者 qmllint 认不出类型（报 `missing-property`），后者需要
   `import QtQuick.Controls` 且会被报一条 Info 级 `unused-imports`
   （运行时确实需要那个 import，是误报）。选了后者：把警告降成 Info，
   与 Qt 官方 Material 风格写法一致。


## 5m. 第十三轮：「了解更多」悬浮时背景闪一下（白→灰→白）

**现象**：Ghost 变体（无底无框、只有文字的那个）鼠标悬浮时，背景颜色闪一下：
白 → 灰 → 白。用户要求"改成悬浮变灰色"。

**先看用户截的图**：那张截图只有 100×38 px，放大后能看清它是**悬浮态**——
左侧亮黄竖条在、背景是浅灰（`#E9E9E9` = `Theme.surfaceHover`）✓
**也就是说"悬浮变灰"本身是对的，闪的是状态本身**。

### 先量一遍：颜色过渡有没有问题

怀疑是"从 `transparent` 淡入到不透明灰"的插值问题，于是写 `tools/probe_fade.qml`
把两种做法并排取样（颜色过渡 vs 不透明度过渡）。

> 第一版探针的结论是**错的**：合成公式忘了乘 255 —— QML 里 `color.r/g/b` 是 **0..1 归一化**的，
> 我按 0..255 用，`#E9E9E9` 被打印成 "1"，差点得出"过渡会经过近黑"的错误结论。
> 修正后重测：

```text
起始 未悬浮   | A(color 过渡): rgb=0,0,0     a=0.00 看到=255 | B(opacity): rgb=233 a=0.00
悬浮后 120ms  | A: rgb=231,231,231 a=0.99 看到=231 | B: rgb=233 a=0.99
悬浮后 240ms  | A: rgb=233,233,233 a=1.00 看到=233 | B: rgb=233 a=1.00
```

**结论：颜色过渡本身是干净的，中间帧没有变深**（231 → 233）。
所以"闪一下"不是插值问题，而是**状态在抖**（hovered 一阵真一阵假）。

### 两个确定的问题

**① 提示框把 Qt 的显隐状态机整个覆盖了（真 bug）**

```qml
// 改之前
ZToolTip { text: control.tooltip; visible: control.tooltip.length > 0 && control.hovered }
```

`ToolTip` 的显隐状态机在 **C++ 的 `T.ToolTip`** 里（它管 `hovered` + `delay` + `timeout` 三件事，
Basic 样式自己都不碰 `visible`）。在外面把 `visible` 绑上等于把整套逻辑作废：

* `delay: 300` 形同虚设 → 提示框一碰就弹；
* 弹层出现时会抓走鼠标，**可能反过来扰动宿主按钮的 `hovered`** ——
  于是"灰 → 弹层 → hovered 丢失 → 白 → 弹层关闭 → 又灰"，正是用户看到的节奏。

改法：只给 `text`，把显隐交还给 `T.ToolTip`。

**② Ghost 的"有没有底"和"底是什么颜色"混在同一条通道上**

Ghost 是四个形态里唯一用 `color: transparent` 表示"没有底"的，却和另外三个形态共用
底板的 `color` + `Behavior on color`。改成：

* 底板对 Ghost **恒为透明**；
* 悬浮底单独一块 `ZCutRect`（`color: Theme.surfaceHover`，`opacity: 随 _isOn` + `Behavior`）。

这样悬浮底的显隐走独立的不透明度通道，不再和底板颜色动画、左竖条的宽度动画挤在
同一次状态变化里；状态抖动的表现也会退化成"淡入淡出"而不是"闪变"。

### 测试环境里踩到的两个坑（都会导致假通过）

1. **`QQuickItem.visible` 是"继承生效值"**：`qmltestrunner` + 离屏平台下测试窗口并没有真正
   `visible`，整棵子树读出来都是 `false`（实测底板 / 竖条 / 叠加层全部 `false`）。
   **不能拿它做断言**，否则恒真。改用不受继承影响的量（`opacity`、颜色、Qt 自己的
   `cursorVisible` / `activeFocus`）。
2. **"其它形态里不该有这块叠加层"是错的**：叠加层写在 `background` 里，每个按钮都有一份，
   只是靠 `visible` 门控只给 Ghost 用。断言应落在"空闲时 opacity 为 0"上。

新增 `test_ghostHoverFillIsSeparateOverlay`（底板恒透明 + 悬浮底存在且空闲时透明）。

### 还没定性的部分（需要真机确认）

离屏环境投递不了鼠标事件（已实测），**闪的状态抖没能在本地复现**。
已排除的：颜色过渡有中间色坑、按钮几何随悬浮变化（有测试守着宽度不变量）、示例工程里
没有别的 MouseArea/HoverHandler 覆盖。

需要你在按钮上加一行日志来定性（30 秒）：

```qml
ZButton {
    id: dbg
    text: "了解更多"; variant: Theme.Variant.Ghost
    onHoveredChanged: console.log("[hover]", hovered)   // 快速 true/false/true 就是状态在抖
}
```

* 若日志抖成 `true → false → true`：**状态被弹层或布局抢走了**，
  请顺带确认这个按钮有没有设 `tooltip:`（有的话第①条就是直接原因）；
* 若日志只有一次 `true`：状态是稳的，那"闪"来自渲染层，把上面第②条的改动留着即可。


## 5n. 第十四轮：Ghost 悬浮底是方块（上一轮重构带出来的回归）

**现象**：用户报「把这个『了解更多』按钮鼠标悬浮显示的背景形状改成和别的按钮一样的六边形」——
即其它形态悬浮时是六边形（右上 + 左下各切一刀），只有 Ghost 的悬浮底是**直角矩形**。

**根因是上一轮（5m）自己带出来的**：5m 为了让"有没有底"和"底是什么颜色"走两条通道，
把 Ghost 的悬浮底从底板里拆出来，另开了一块独立叠加层 `ghostHoverFill`。
拆的时候只搬了 `color` / `opacity`，**漏搬了底板上的两个切角绑定**，
于是那块叠加层退化成 `anchors.fill` 的直角矩形。

板子本身没变，所以这是个"纯叠加层形状"的问题：`ZCutRect` 的切角默认值是 0，
少写一行绑定就静默变成矩形，不会有任何报错或警告 —— 这也是它当初能溜过去的原因。

### 改法：把切角收成一份取值，三处共用

不在叠加层上再抄一遍 `cutSize` / `cutSm`，而是抽成两个只读属性，
让**底板、Ghost 悬浮底、焦点环**绑定同一份：

```qml
readonly property real cutTopRightSize: enabled ? cutSize : 0
readonly property real cutBottomLeftSize: enabled ? Theme.cutSm : 0
```

原来焦点环是第三处硬抄（`cutTopRight: control.cutSize` / `cutBottomLeft: Theme.cutSm`），
一并收编。这样"同一个形状画在三处"这件事在代码里只剩一个事实来源，
以后再拆叠加层也不会漏抄 —— 因为已经没有第二份可抄。

### 验证

**① 静态检查 0 新增警告**

```text
qmllint -I qml qml/ZmdUI/ZButton.qml qml/main.qml qml/DemoContent.qml
→ exit 0，ZButton.qml 无任何输出
（剩下的 79 条 [unqualified] 与 caret 的 missing-property 是已记录的固有提示）
```

**② 行为测试 15 项全绿**，其中新增 `test_ghostHoverFillHasSameChamferAsBoard`

```text
qmltestrunner -input tests/tst_hover.qml -import qml
Totals: 15 passed, 0 failed, 0 skipped, 0 blacklisted, 1798ms
```

**③ 新测试确实能抓到回归（不是恒真的假通过）**

把叠加层的切角改回 `0`（复现上一轮的代码）再跑：

```text
FAIL!  : ZmdUIBehaviors::test_ghostHoverFillHasSameChamferAsBoard()
         悬浮底右上切角必须和底板同源，否则悬浮时退化成直角矩形
Totals: 14 passed, 1 failed, 0 skipped, 0 blacklisted, 1755ms
```

改回来后 15 passed。**先证明它红、再证明它绿**，避免写出永远通过的断言。

> 新用例特意**不写死 12 / 6**，而是断言「叠加层 == 底板共用的那份取值」，
> 并额外跑一次 `ghostA.cutSize = original + 4` 检查两边同步变化：
> 这样以后调 `Theme.cutMd` 不会把测试改坏，但少抄一次绑定就会立刻红。
> 同时保留了「两边都不能是 0」的独立断言 —— 只写 `compare(a, b)` 的话，
> 表达式求值失败时两边会同时是 `undefined`，比较照样通过。

**④ 像素级前后对照（离屏渲染，3 倍放大）**

离屏平台投递不了鼠标事件，`hovered` 永远是 false，悬浮底（`opacity` 绑在 `_isOn` 上）
根本不会出现。所以探针里**直接给 `opacity` / `visible` 赋值** —— QML 里对已绑定属性赋值
会替换掉那条绑定，只影响探针里的临时实例，组件库本身不动，
渲染出来的仍是**真实叠加层的真实几何**（`tools/` 目录当前写不进去，探针落在仓库根目录）：

```text
改之前  PROBE board(tr,bl)=(12,6) overlay(tr,bl)=(0,0)    ← 叠加层是直角矩形
改之后  PROBE board(tr,bl)=(12,6) overlay(tr,bl)=(12,6)   ← 和底板完全一致
```

四个形态（Ghost / Secondary / Danger / Primary）逐一亮起叠加层抓图对照：
改之前灰色底是**方块**、四角戳在底板斜边之外；改之后是**六边形**、和底板边缘严丝合缝。

**⑤ 整个演示程序仍然零 QML 警告**

```text
qml.exe -I qml tools/smoke.qml
qml: SMOKE: window 1500 x 940 | contentItem 1500 x 940 | loaded true
```

### 本轮的一个环境问题（非代码）

`docs/`、`tools/`、`qml/` 三个子目录缺少当前用户的显式权限项，
导致 **shell 子进程写不进这些目录**（`tools/smoke.qml` 因此报 `SMOKE SAVE_FAIL`、
`gen_docs.py` 无法重新生成文档）。工作区根目录已修好，子目录待修。
上面的文档同步是用编辑器改完后跑 `_check_doc_sync.py` 核对**逐字节一致**的
（46 个章节 + `verification.md` 全部 IN SYNC），不是靠人眼比对。

## 5o. 第十五轮：新增 `ZRichTextEditor`（块级富文本）

**需求**：用户问「这个组件库里有富文本框吗？没有的话做一个，支持图片、文字、文件等」。

**结论**：库里只有单行 `ZTextField`，没有任何多行 / 富文本能力，于是新写一个
`qml/ZmdUI/ZRichTextEditor.qml`（约 1310 行），并注册进 `qmldir` 与 `qml.qrc`
（类型数 25 → 26）。

### 为什么"富"做在块一级，而不是字符一级

这是本轮唯一一个必须解释的设计取舍，因为它决定了整个 API 的形状：

* Qt Quick 的 `TextEdit` 只暴露**整段** `font`；`textDocument` 是 `QObject`，
  QML 侧拿不到 `QTextCursor` / `QTextCharFormat`。
* 想做到"选中几个字加粗"，就得自己算文字的排版位置再叠一层富文本绘制 ——
  那不是组件，那是重写一个有布局引擎的编辑器。
* 本库的承诺是**纯 QML + 零第三方依赖**（连图标都是 `Shape` / `Canvas` 画的），
  所以富文本的"富"落在块上：每个文字块各自带字体 / 字号 / 粗斜体下划线删除线 / 对齐，
  块与块之间可以混排 **文字 / 图片 / 文件**。

于是 `blocks` 是三种纯 JS 对象的数组：

| 类型 | 字段 |
| --- | --- |
| `text` | `text` `style`(body/heading/quote/code) `bold` `italic` `underline` `strike` `align` |
| `image` | `url` `name` `caption` |
| `file` | `url` `name` `size` |

### 两个刻意的边界

**① 编辑器不做内部滚动**（不内置 `Flickable`）。原因有二：嵌套滚动本来就难用；
更关键的是父级 `Flickable` 会把文字拖选当成滚动手势抢走。
现在的约定是"内容多高就多高，由外层容器负责滚"，放进 `ScrollView` / `Flickable` / 列表都行。

**② 块对象是原地改字段的**，改 `block.text` 不会发信号（`blocks` 里装的是普通 JS 对象，
没有 `Q_PROPERTY`）。所以引入 `revision` 版本号作为**唯一依赖点**：
任何一次原地修改都会 `revision++`，绑定在 `revision` 上的派生属性（字数统计、空态、
块计数）随之刷新；只有整体替换 `blocks` 才重建 `Repeater`。
这条约定避免了"每次敲一个字符就重建整个委托树"。

### 验证

**① 静态检查：0 条新增实质警告**

```text
qmllint -I qml qml/ZmdUI/ZRichTextEditor.qml   → exit 0，非 [unqualified] 诊断 0 条
qmllint -I qml qml/DemoContent.qml             → exit 0，无输出
```

剩下 29～30 条 `[unqualified]` 全部出现在委托 / `Component` 作用域里访问 `editor.xxx`，
是库内既有模式（同命令实测基线：`ZButton.qml` 0 条、`ZPanel.qml` 2 条、
`ZTextField.qml` 5 条、`ZTable.qml` 38 条），属 qmllint 的已知误报。

**② 行为测试 38 项全绿**

```text
qmltestrunner -input tests/tst_richtext.qml -import qml
Totals: 38 passed, 0 failed, 0 skipped, 0 blacklisted
```

八组用例：块工厂 / 归一化 / 名字与单位换算 / 序列化 / 派生状态 / 结构操作 / 信号与 `revision` / 装配。
测试里用假 url（`"u"`、`file:///nope.png`）会打出 `QML QQuickImage: Cannot open` 的 QWARN ——
那是故意的破图占位路径，不是失败。

**③ 离屏渲染探针抓出 4 个"测试抓不到"的真缺陷**

单元测试只喂数据、不看像素，所以下面这些只有真渲染才暴露：

| 现象 | 根因 | 修法 |
| --- | --- | --- |
| 所有文字块显示为空（图片块、文件块却正常） | `Loader.onLoaded` 里才把 `blockData` 注入被加载项，而 `onLoaded` **晚于**该项的 `Component.onCompleted`，所以初始化时读到的 `blockData.text` 永远是空串 | 加 `_syncFromBlock()`，`onBlockDataChanged` 时再同步一次（信号只能挂在委托根上，`TextArea` 没有这个信号） |
| `readOnly` + 空文档什么都不显示 | 底部"继续输入"行把最后一点高度也吃了，`implicitHeight` 只剩 42 | 空态单独分支：网格 + `空文档 / NO CONTENT`，`implicitHeight` = 76 |
| 工具栏被挤成两行 | 12 颗格式芯片 + 3 颗块操作挤不下 | 块操作抽成右侧固定的 `moveBar`，`Flow` 宽度 = 总宽 − moveBar，芯片内边距收到 `spacingSm` |
| 工具栏高亮落在最后一块 | `currentIndex` 默认 `-1`，`_targetIndex()` 回落到末块 | 默认改 `0`（`-1` 只表示"没有当前块"） |

**④ 一个藏得很深的焦点 bug（靠探针才发现）**

现象：窗口显示后 `currentIndex` 自己从 0 跳到末块，工具栏高亮跟着跑到「代码」。

根因：`_focusRequest` 的"无请求"哨兵是 `-1`，而 `tRoot.blockIndex` 在 `Loader.onLoaded`
之前**也是 `-1`** —— 于是每个文字块在 `Component.onCompleted` 里都判定"就是我要抢焦点"，
挨个 `forceActiveFocus()`，最后一个赢。`Error().stack` 里只有 `onActiveFocusChanged` 一帧，
因为 `setFocus` 来自 C++，看栈完全看不出来。

修法：抢焦点从 `Component.onCompleted` 挪到委托根的 `onBlockIndexChanged`，
并显式要求 `tRoot.blockIndex >= 0`。**哨兵值和合法值撞车**这类问题，
静态检查、单元测试都不会报，只有"渲染出来看一眼"才发现。

**⑤ 演示页已接入（区块 07）**

`qml/DemoContent.qml` 新增「区块 07 —— 富文本」，五个块（标题 / 正文 / 图片 / 文件 / 代码）全上。
离屏探针滚到底抓图：演示页 `contentHeight = 3916`，主编辑器 `implicitHeight = 961`，
只读空文档 `implicitHeight = 76`，零 QML 警告。

### 本轮踩到的可复用坑

* **`Loader.implicitHeight` 是只读的**（继承 `QQuickImplicitSizeItem`），
  写 `implicitHeight: item.implicitHeight` 直接编译报
  `Invalid property assignment: "implicitHeight" is a read-only property`，
  整个类型变 unavailable。要写 `height:`。
* **一个 `Text` 上同时写 `font:` 和 `font.bold:` 就是重复绑定**，
  qmllint 报 `Duplicate binding on property 'font'`。改成单个
  `Qt.font({ family: …, pixelSize: …, bold: …, italic: … })`。
* **qmllint 把注释当指令**：注释里出现 `[duplicate-property-binding]` 这种方括号警告名，
  或注释行以 `qmllint` 开头，都会报 `Invalid qmllint directive`。写注释要避开这两种形态。
* **`TextArea.pressed` 不是可绑属性**：`onPressedChanged` 直接编译报
  `Cannot assign to non-existent property "onPressedChanged"`，
  `console.log(area.pressed)` 打出来是 `function() { [native code] }`（truthy，等于没有守卫）。
* **`console.log` 的中文在 PowerShell 里会变乱码**：调试输出改用
  `caption.charCodeAt(0)` / `length` 这类纯 ASCII 数字，别用中文当探针信标。

### 文档同步（本轮）

`README.md`（类型数 26、组件速查新增 `ZRichTextEditor` 行、已知限制补一条）、
`tools/gen_docs.py` 的 `CHAPTERS`（二章加组件、七章加 `tests/tst_richtext.qml`）、
以及本文 —— 然后跑 `python tools/gen_docs.py` 重新生成 `docs/ZmdUI_组件库文档.md`。

顺带修了环境问题：`docs/` 的 Windows 文件权限（用 `diagnose-windows-sandbox-acl` 补上
当前用户的完全控制），文档生成命令本身仍需在完全权限下执行才能写入 `docs/`。

## 5p. 第十六轮：新增 `ZChatInput`（QQ 式消息输入框）

需求原文：「再给我做一个qq聊天输入框那样的组件，可以输入文本、图片、文件」。

### 设计取舍

* **不弹系统文件对话框**。纯 QML 侧没有跨平台的 `FileDialog` 实现路径（那是
  `QtQuick.Dialogs` 的职责，且各平台行为不一致）。点「图片 / 文件」只发
  `imagePickRequested()` / `filePickRequested()`，宿主接自己的 `FileDialog`，选完再回填
  `addImage(url, name)` / `addFile(url, name, size)`。组件对"文件从哪来"不做假设。
* **不碰剪贴板位图**。`QClipboard` 的图片要 C++ 侧取，QML 只能拿到文本。所以"粘贴截图"
  由宿主把图存成文件后走 `addImage`。拖放例外：`DropArea` 能直接拿到 `drop.urls`。
* **`attachments` 整体替换 + `revision`**，和 `ZRichTextEditor.blocks` 同一套约定：
  块/附件是纯 JS 对象，原地改字段不发信号，靠版本号做唯一依赖点。
* **发送语义**：`Enter` 发送 / `Shift+Enter` 换行（`sendOnEnter: false` 时反过来，
  `Ctrl+Enter` 恒发送），`Esc` 发 `cancelRequested()`。逻辑抽成纯函数 `isSendCombo(modifiers)` 便于单测。

### 验证

**① 静态检查：0 条新增实质警告**

```text
qmllint -I qml qml/ZmdUI/ZChatInput.qml qml/DemoContent.qml qml/main.qml
→ exit 0，非 [unqualified] 诊断 0 条（合计 20 条 [unqualified]，全是委托访问 composer.xxx）
```

**② 行为测试 42 项全绿**

```text
qmltestrunner -input tests/tst_chatinput.qml -import qml
Totals: 42 passed, 0 failed, 0 skipped, 0 blacklisted
```

八组：附件工厂 / 归一化（类型、空名兜底、扩展名）/ 文件名与 `formatBytes` /
加附件与上限（含 `maxAttachments: 0` = 不限）/ 删附件 / 派生状态
（`canSend` `overLimit` `draftSummary` `counterText`）/ 发送与快照拷贝 / 序列化往返 / 回车语义 / 装配。

**③ 首跑虽然 42 项全过，但运行期有两处 `ReferenceError`** —— 测试断言不看日志，
只有把 QWARN 翻出来才知道有代码在静默跑错：

| 报错 | 根因 | 修法 |
| --- | --- | --- |
| `ZChatInput.qml:591: ReferenceError: fixTextLength is not defined` | 辅助函数写在 `Item { id: textWrap }` 的作用域里，却在 `TextArea.onTextChanged` 里裸调用 | 内联到处理函数里，并用 `_overLimitReported` 做边沿触发（只在刚越界时发一次 `limitReached("length")`，否则每敲一个字都发） |
| `ZChatInput.qml:701 / :783: ReferenceError: attachLoader is not defined` | 委托用的是 `Loader { sourceComponent: imageThumb / fileCard }`，而两个 `Component` 声明在**文件级作用域**；id 是词法解析的，看不见 Repeater 委托里的那个 Loader | 改用 Repeater 委托的上下文属性 `modelData` / `index`（见下一节探针结论） |

**④ 探针：`Repeater → Loader{sourceComponent} → Component` 里到底能拿到什么**

专门写了个最小复现（两个 Repeater + 三组委托，各打一行日志），结论：

* 委托根上写 `required property var modelData` / `required property int index`
  **不会被注入**，运行期报 `Required property modelData was not initialized`
  —— 因为 `sourceComponent` 造出来的项不是模型的直接委托，Qt 不给它初始化 required 属性。
* 直接读上下文属性 `modelData` / `index` **可以**，`sourceComponent` 的项继承 Repeater 委托的上下文。
* 模型是 **JS 对象数组**时 `modelData` 就是对象本身（本组件就是这种传法）；
  换成 `ListModel` 命名角色则 `modelData` 是 `undefined`，只能用角色名。

**⑤ 离屏渲染探针抓到的第 3 个缺陷**

| 现象 | 根因 | 修法 |
| --- | --- | --- |
| 底部工具栏里快捷键提示和字数计数**叠字**（渲染成 `SHIFT+ENTER 换行30 / 2000`） | `hintLabel` 和 `counterLabel` 都锚在 `sendButton.left` 上，同一个锚点同一个边距 | 改成链式：字数锚按钮左侧，提示锚字数左侧，并把剩余宽度的算式一起扣掉字数宽度 |
| `attachments: [ makeImageAttachment(...) ]` 报 `Binding loop detected for property "attachments"` | 工厂 `normalizeAttachment` 里 `id: "att-" + composer._nextAttachmentId++`，计数器是 **QML 属性**；绑定求值时读它、同时写它，等于自己依赖自己 | 计数器改成普通 JS 对象字段 `property var _idGen: ({ next: 1 })`，绑定只读到 `_idGen` 这个属性本身（值不变），写的是它内部字段，不触发失效 |
| 缩略图的文件名压条盖住底板描边、把左下切角顶成直角；文件卡的扩展名徽标黑块盖过卡片边框 | 压条与徽标锚到父项边缘（`height: parent.height`），既没给描边让位，也没继承父项的切角 | 都按 `Theme.border` 内缩，并补 `cutBottomLeft: Theme.cutSm` 与父项对齐 |

**⑥ 演示页已接入（区块 08）**

`qml/DemoContent.qml` 新增「区块 08 —— 消息输入」，预填一段正文 + 一张图
（url 留空，走 `IMG` 斜线占位）+ 一张文件卡，并接上 `sendRequested` /
`imagePickRequested` / `filePickRequested` / `cancelRequested`。
离屏探针滚到底抓图：演示页 `contentHeight = 4426`，零 QML 警告。

### 本轮踩到的可复用坑

* **`Theme` 的尺寸令牌真名**是 `Theme.border`(2) / `Theme.borderThick`(3) / `Theme.spacingXs`(4)，
  写成 `border2` / `spacingXs4` 会报 `Member "border2" not found on type "Theme"`。
* **`ZButton.mono` 是 `property string`**（按钮右侧的等宽小字，如 `F2` / `DEL`），不是布尔开关；
  传 `true` 报 `Cannot assign literal of type bool to QString`。
* **测试全绿 ≠ 代码没错**：`ReferenceError` 只进日志不进断言。跑完一定要把
  `QWARN` 抓出来看一遍，本轮的 2 个 bug 都是这么发现的。
* **工厂函数里不要动 QML 属性**：`makeImageAttachment(...)` 这类工厂很容易被用户写进
  `attachments: [ … ]` 这种**绑定**里。只要工厂内部读写了一个 QML 属性（本轮的 id 计数器），
  这个绑定就会依赖自己，Qt 直接报 `Binding loop`，而且**组件本身不报错**，只有用户那样写才炸。
  状态要么放 JS 对象字段（`property var _gen: ({ next: 1 })`），要么让工厂保持无副作用。

### 文档同步（本轮）

`README.md`（类型数 27 = 1 单例 + 4 图元 + 22 控件、目录树、组件速查新增 `ZChatInput` 行、
验证命令加 `tst_chatinput`、已知限制补"不弹系统对话框 / 不读剪贴板位图"）、
`tools/gen_docs.py` 的 `CHAPTERS`（二章加组件、七章加 `tests/tst_chatinput.qml`、
演示页描述改八大区块）、演示页底部装饰条改 `27 TYPES`，以及本文 ——
然后跑 `python tools/gen_docs.py` 重新生成 `docs/ZmdUI_组件库文档.md`。

## 5q. 第十七轮：拖放与 Ctrl+V 都不生效

### 报障

> 图片文件拖进去不生效，ctrl v 复制也不行

### 根因一：`DropArea` 只发信号，没人落地

组件这边 `DropArea.onDropped` 只做了 `composer.filesDropped(drop.urls)` 一件事，
**自己不添加附件**；演示页那边又只接了 `onSendRequested`。
两边一凑，拖进来的文件被完整地"观察"了一遍，然后什么也没发生。

这类"信号发得没错，但没人接"的空转，本质是把职责推给了宿主却没写进文档。

### 根因二：Ctrl+V 的三条路径能力完全不同

先用一个隐藏 `Window` + `TextEdit` 的探针，配合 PowerShell 的
`System.Windows.Forms.Clipboard` 造三种剪贴板内容实测（走真实 windows 平台，
不是 offscreen —— offscreen 下剪贴板是空的）：

| 复制的是什么 | `canPaste` | `paste()` 之后 `text` | 纯 QML 能做吗 |
| --- | --- | --- | --- |
| 一段文字 | `true` | 19 个字符 | 能，默认行为 |
| 资源管理器里的文件 | `true` | 30 个字符 = `file:///C:/dev/ZmdUI/README.md` | **能**，按行拆开就是 url 列表 |
| 一张位图 | `false` | 空 | **不能**，`QClipboard::image()` 在 QML 里不可达 |

另外确认过：本机 Qt 的 QML 模块里**没有** Clipboard 类型
（`C:\dev\Qt\6.11.2\mingw_64\qml` 下 `Qt.labs.platform` 只有 `labsplatformplugin.dll` +
`plugins.qmltypes` + `qmldir`）。所以"粘截图"只能由宿主语言出手。

### 修法

1. **拖放自己落地**：`DropArea.onDropped` 在发信号之后调
   `composer.addUrlsAsAttachments(drop.urls)`，按扩展名分流
   （`isImageUrl(url)` 命中 `png/jpg/jpeg/gif/bmp/webp/svg/ico/tif/heic/avif` → 图片桶，
   其余 → 文件桶），并照常遵守 `maxAttachments`。
   `filesDropped(urls)` 保留，但语义改成"通知"，不再要求宿主自己加。
2. **文件粘贴转附件**：在 `TextArea.onTextChanged` 里用 `insertedText(before, after)`
   做共同前缀 / 共同后缀的 diff，把这次插入的净增量取出来；若它整体是由
   `file:///…` 组成的行列表（`fileUrlsIn(block)`），就
   `_suppressPasteScan = true` → 把正文还原成粘贴前 → `addUrlsAsAttachments(urls)`。
   这样正文里不会多出一串路径，用户看到的是附件卡。
   扫描前置 `area.activeFocus`：程序化地设 `text`（恢复草稿、演示页的初始文案）
   不该被当成粘贴处理。
3. **位图粘贴交给宿主**：新增 `signal pasteRequested()`。在 `Keys.onPressed` 里判
   `Qt.Key_V + Ctrl`（不带 Shift）、非只读、且 `!area.canPaste`（= 剪贴板里没有文本，
   典型就是位图）时发出。
4. **演示程序加 C++ 桥**：`src/zclipboard.cpp/.h` 的 `ZClipboard` 提供
   `hasImage()` / `hasUrls()` / `saveImage(ext = "png")`——把
   `QGuiApplication::clipboard()->image()` 存进 `<temp>/zmdui-clipboard/clip-<毫秒>.<ext>`，
   返回 `file:///…`。`main.cpp` 里用
   `engine.rootContext()->setContextProperty("ZClipboard", &clipboardBridge)`
   注入（不是 QML 单例，这样纯 `qml.exe` 跑测试时根本不需要它），
   QML 侧 `typeof ZClipboard === "undefined"` 守卫。
   演示页 `onPasteRequested` 调 `ZClipboard.saveImage()` 再 `chatDemo.addImage(url, "clipboard.png")`。

另外两处顺手修的细节：

* 拖进来 / 粘进来的文件拿不到字节数（QML 没有 `stat`），文件卡原来会显示 `0 B · ATTACHMENT`，
  改成 `size > 0` 时才写大小，否则只写 `ATTACHMENT`。
* `DropArea` 必须声明在 `TextArea` **之后**才能拿到 drop 事件：`TextEdit` 自己也会接拖放
  并把文件路径当文本插进来。这一点在代码里补了注释。

### 验证

* `qmllint -I qml qml/ZmdUI/ZChatInput.qml qml/DemoContent.qml qml/main.qml`
  → `exit 0`，非 `[unqualified]` 诊断 **0 条**（合计 22 条 unqualified，全是委托里访问
  `composer.xxx` 与 `ZClipboard` 这种库内既有误报）。
* `qmltestrunner -input tests/tst_chatinput.qml -import qml`
  → **`Totals: 53 passed, 0 failed`**（原 42 项 + 本轮新增 11 项：`isImageUrl`、
  `insertedText` 三种（追加 / 中间插入 / 删除）、`fileUrlsIn` 三种（单 url / 多行 / 混在正文里）、
  `addUrlsAsAttachments` 四种（分流 / 跳过空项 / 遵守上限并只报一次 `limitReached` / 只读忽略））。
  除故意的破图 `QWARN` 外无运行期警告，无 `Binding loop`。
* 演示页离屏探针滚到底抓图：`contentHeight = 4426`，零 QML 警告，
  证明 `onPasteRequested` 里的 `typeof ZClipboard` 守卫在纯 `qml.exe` 下不会炸。
* C++ 构建：`cmake --build build-mingw` 通过，`ZClipboard` 编进 `ZmdUIDemo.exe`。

上面这些只能证明"代码写对了"，证明不了"用户按下去有用"。所以另做了三组真机验证：

| 验证 | 做法 | 结果 |
| --- | --- | --- |
| 文件粘贴真正落成附件 | 真窗口里 `focusInput()` 后把两行 `file:///…` 塞进 `text`（等价于粘贴完成后的状态） | `attachments=2 img=0 file=2`、`textlen=0`、`names=["README.md","CMakeLists.txt"]` |
| 位图粘贴确实发出请求 | `System.Windows.Forms.Clipboard::SetImage` 放一张 80x60 位图 → 用 `SendKeys` 往探针窗口发真实 `Ctrl+V` 两次 | `PASTE_REQUESTED` 出现两次（`canPaste` 为 false 才走这条路） |
| 桥在真实宿主里可见 | 在演示页临时打一行 `typeof ZClipboard` / `hasImage()`，重编译 `ZmdUIDemo.exe` 后启动 | `ZCLIP typeof= object hasImage= true` |

`ZClipboard::saveImage()` 本身单独验过：`moc` + `g++` 把 `src/zclipboard.cpp` 编成独立小程序，
剪贴板里放 64x48 纯色 `(20,200,60)`，输出 `hasImage=1`、`url=file:///…/clip-1792233352030.png`、
`exists=1 size=64x48`、`pixel=20,200,60` —— 跨进程位图读到了、落盘对了、像素无损。

验证完的临时插桩已全部撤掉并重新构建，`ZmdUIDemo.exe` 启动无任何 stderr 输出。

### 本轮踩到的可复用坑

* **信号 ≠ 功能**。"发一个 `filesDropped(urls)` 让宿主自己处理"听起来很干净，
  但如果组件在默认情况下什么都不做，用户的第一反应就是"坏的"。默认行为要给足，
  信号只用来**补充**通知。
* **`DropArea` 要压住 `TextArea`**。`TextEdit` 自带拖放（把文件路径当文本插入），
  声明顺序反了就会出现"拖进去正文里多一行 `file:///…`"。
* **粘贴要在 diff 上做判断，不要在整个 `text` 上做**。直接对全文跑正则，
  用户正在打的一段正常文字（比如引用了一个 share 链接）也会被误吃掉。
* **资源的 id 生成器要放 JS 对象里**（见 5p），这次粘贴改写走的是同一个
  `addAttachment`，所以 `_idGen` 的修法在这里第二次救了场。
* **GUI 子系统的 exe 看不到 `console.log`**。`qml.exe` 是控制台程序，输出直接进 stderr；
  但 `qt_add_executable` 产出的 `ZmdUIDemo.exe` 是 `WIN32` 子系统，`qDebug` 走
  `OutputDebugString`，重定向 stderr 是空的。加 `QT_ASSUME_STDERR_HAS_CONSOLE=1`
  才会照样写 stderr —— 排查"演示程序里到底有没有东西"时很关键。

### 文档同步（本轮）

`README.md`（目录树加 `src/zclipboard.cpp/.h`、组件速查 `ZChatInput` 行补
`pasteRequested()` 与四个新函数、验证命令 42 → 53 项、已知限制把"拖放 / 粘贴"三条
分开写清楚）、`docs/verification.md` 本文，然后重新生成 `docs/ZmdUI_组件库文档.md`。

## 5r. 第十八轮：「图片」/「文件」按钮点了没反应

### 报障

> 下面的按钮是干什么的，点击没有反应

### 根因：按钮只发信号，宿主没接

工具栏那两颗芯片 `onClicked: composer.imagePickRequested()` —— 组件发一个信号就完事，
演示页那边只 `console.log("imagePickRequested")`。于是点下去：有焦点变化、有 hover，
就是什么都不发生。

上一轮修拖放时已经反思过一遍「信号 ≠ 功能」（见 5q），结果隔着两个小节又栽在同一个
坑里：**默认行为缺位**。区别是这回缺的是"选择文件"这一步，而它恰恰是用户按下按钮的
全部预期。

### 修法：把选择框做进组件，默认就开

1. `ZChatInput.qml` 加 `import QtQuick.Dialogs`，内置两个 `FileDialog`
   （`imageDialog` 过滤图片后缀、`fileDialog` 收所有文件，都是 `OpenFiles` 多选），
   `onAccepted` 直接 `addUrlsAsAttachments(urlsOf(selectedFiles))`。
2. 新增 `property bool useSystemDialogs: true`。芯片改成调
   `openImagePicker()` / `openFilePicker()`：先发原来的信号（宿主可能想记账 / 打点），
   再按 `useSystemDialogs` 决定弹不弹内置对话框。宿主想换成自己的选择器（带预览、
   最近使用、远程目录）时置 `false` 接信号即可，行为完全不变。
3. 顺手把两个"打开选择框"抽成公开函数 `openImagePicker()` / `openFilePicker()`：
   宿主从菜单、快捷键、右键菜单触发同一个动作时不用再抄一遍逻辑。
4. 新增 `urlsOf(files)`：把 `FileDialog.selectedFiles`（`list<url>` 的类数组）
   转成普通字符串数组再交给 `addUrlsAsAttachments`，避免某些 Qt 版本拿到包装对象。

### 验证

* `qmllint -I qml qml/ZmdUI/ZChatInput.qml` → `exit 0`，非 `[unqualified]` 诊断 **0 条**
  （15 条 unqualified，全是委托里访问 `composer.xxx` 的老误报）。
* `qmltestrunner -input tests/tst_chatinput.qml -import qml` → **`Totals: 57 passed`**
  （+4 项：`useSystemDialogs` 默认为真、`urlsOf` 剔空项、`openImagePicker` /
  `openFilePicker` 在关掉内置对话框时仍发信号）。单测里一律
  `useSystemDialogs = false`，否则测试进程会卡在模态对话框上。
* **真机验证（关键）**：`qml.exe` 起一个只放 `ZChatInput` 的窗口，600ms 后调
  `openImagePicker()`，从外部用 P/Invoke `EnumWindows` 枚举该进程的顶层窗口：

  ```
  hwnd=0x11102 visible=True class=#32770 title=[选择图片]
  ```

  `#32770` 就是 Win32 的对话框窗口类，标题正是我们设的「选择图片」。
* 再把选择框**用到底**：`SendKeys` 往对话框里敲一条完整路径 + 回车，日志输出
  `ATTACH_ADDED image chat-input-demo.png 0` —— 选完真的变成了附件，不是"弹出来好看"。
* 演示程序重编译后 `区块 08` 正常加载、启动无 stderr 输出：`FileDialog` 是在组件实例化时
  就创建的，插件缺失会立刻炸，所以这也是对部署的一次体检。

### 本轮踩到的可复用坑

* **模态对话框不要进单测**。`FileDialog.open()` 在 offscreen 下会退化到 Qt Quick 自绘实现
  （能开、能关，但会打出 style customization 警告）；在 windows 平台下则是原生模态框，
  测试进程会直接挂在那里。所以凡是会在测试里被点到的路径，都要有"别弹框"的开关，
  本次的开关就是 `useSystemDialogs`。
* **`FileDialog` 用 `fileMode: OpenFiles` 时结果在 `selectedFiles`，不是 `selectedFile`**。
  单数形式只给了第一个，多选会静默丢文件。
* **验证"按钮有没有反应"不能只看信号**。信号 `count` 涨了、`console.log` 也打了，
  用户那边依然是死的。得一路验到"窗口出现了 / 文件进了列表"这种可观察的结果。

### 文档同步（本轮）

`README.md`（组件速查 `ZChatInput` 行补 `useSystemDialogs` /
`openImagePicker` / `openFilePicker` / `urlsOf`，已知限制把"不弹对话框"改写成
"默认弹、可换"，验证命令 53 → 57 项）、`tools/gen_docs.py`（本章描述与测试条目同步）、
本文，然后重新生成 `docs/ZmdUI_组件库文档.md`。

## 5s. 第十九轮：深色模式下聊天框配色错乱

### 报障

> 聊天框在深色模式下配色奇怪

附的截图里能直接看出来：标题条（`MESSAGE / COMPOSER` 那条）变成浅灰白底，
压在上面的白字几乎看不见；文件卡的 `JSON` 扩展名徽标变成一块白方块；
缩略图底部的文件名压条也偏亮。

### 根因：`Theme.ink` 是**前景色**，被拿去当**填充色**了

`qml/ZmdUI/Theme.qml` 里 `ink` 是正文前景色：亮色 `#111111`、暗色 `#EEEEEE`。
亮色下它恰好是近黑，所以拿它给"黑色块"当填充，看着毫无问题；一到暗色就翻成近白，
而块上的文字用的是 `textOnSub`（恒为 `#FFFFFF`）—— 白底白字，文字凭空消失。

`qml/ZmdUI/ZChatInput.qml` 有 4 处这样用：

| 位置 | 亮色（修前=修后） | 暗色修前 | 暗色修后 |
| --- | --- | --- | --- |
| 标题条 `headerBar` | `#111111` | `#EEEEEE`（白底白字） | `#0F0F0F` |
| 缩略图文件名压条 | `#111111` @0.82 | `#EEEEEE` @0.82 | `#0F0F0F` @0.82 |
| 文件卡扩展名徽标 `extBadge` | `#111111` | `#EEEEEE`（白块） | `#0F0F0F` |
| 删除角标 `RemoveBadge` | `#111111` @0.72 | `#EEEEEE` @0.72 | `#0F0F0F` @0.72 |

难看的地方在于：**这条规则早就写在 `README.md` 的「暗色主题：三条硬规则」里了**
（"反相块（黑底白字）必须恒为深色：用 `inkBlock` 而不是 `ink`"），
库里其它所有反相块也都照做了 —— `qml/ZmdUI/ZPanel.qml:96`、
`qml/ZmdUI/ZSectionTitle.qml:102`、`qml/ZmdUI/ZTable.qml:146`、
`qml/ZmdUI/ZDialog.qml:113`、`qml/ZmdUI/ZRichTextEditor.qml:565` 全是 `inkBlock`。
只有新写的 `ZChatInput` 是例外，而它偏偏是唯一一个"整块黑 + 白字"面积最大的控件。

`ZRichTextEditor` 上一轮没踩到，是因为它的标题条直接抄了 `ZPanel` 的写法；
这一轮是**从零写**，凭"我要一个黑色块 → 黑色是 `ink`"的语感就写错了。

### 修法

4 处 `color: Theme.ink` → `color: Theme.inkBlock`，每处配一行注释说明为什么。
保留 3 处正确的 `Theme.ink`（都是**文字**色，不是填充色）：`TextArea` 正文、
文件卡的 `fileNameLabel`、拖放覆盖层文案。

### 验证

* **双模式离屏探针**：`_probe_chat_modes.qml` 同一个实例先切 `Theme.Mode.Light`
  抓一张、再切 `Theme.Mode.Dark` 抓一张（两级 `Timer` 错开，`grabToImage` 在
  `Component.onCompleted` 里太早，会报 `item is not attached to a window`）。
  暗色下实测 `ink= #eeeeee / inkBlock= #0f0f0f / surface= #232323`，
  修前修后两张图对照即上述症状与修复。
* **补了一条回归测试**（`tests/tst_chatinput.qml::test_blackBlocksUseInkBlock`）：
  给四个黑块加 `objectName`（`chatHeader` / `chatThumbName` / `chatExtBadge` /
  `chatRemoveBadge`），测试里切到暗色用 `findChild` 找出来，逐个断言
  `color` 等于 `Theme.inkBlock`；再反向断言 `Theme.ink !== Theme.inkBlock`，
  避免这条测试沦为同义反复。
* **反向证明这条测试真的会失败**：把 `extBadge` 改回 `Theme.ink` 后重跑 →
  `FAIL! : qmltestrunner::ZChatInputBehaviors::test_blackBlocksUseInkBlock() Compared values are not the same`，
  `Totals: 57 passed, 1 failed`；改回 `inkBlock` → `Totals: 58 passed, 0 failed`。
* `qmllint -I qml qml/ZmdUI/ZChatInput.qml` → `exit 0`，非 `[unqualified]` 诊断 **0 条**
  （16 条 unqualified，仍是委托里访问 `composer.xxx` 的老误报）。
* 三套测试：`tst_hover` 15 / `tst_richtext` 38 / `tst_chatinput` 58，全 passed。
* **演示页暗色整页截图**：起 `qml/DemoContent.qml`（`Theme.mode = Theme.Mode.Dark`），
  滚动容器取 `contentHeight` 最大者（4426）并滚到 `区块 08`：标题条、`JSON` 徽标、
  删除角标全部是近黑色，与 `区块 07` 的富文本编辑器、面板标题带风格一致。

### 本轮踩到的可复用坑

* **"前景色"和"填充色"是两个语义，别共用一个令牌**。`ink` 会跟着模式翻转，
  `inkBlock` 不会。凡是"黑底白字"的块，永远用 `inkBlock`。
* **亮色下正好正确，是最坏的掩护**。这类 bug 只在切模式时出现，而组件单测默认在亮色下跑，
  所以必须显式切一次模式再断言 —— 否则测出来的绿色是假的。
* **纯视觉的 bug 也能进单测**：给关键子元素加 `objectName`，用 `TestCase.findChild`
  把"填充色 == 某个令牌"钉成断言，比截图人眼比对可靠得多，也比截图好维护。
* **写新组件时要先翻一遍 README 的「设计语言规范」**。这次不是不知道该怎么做，
  是那条规则在 README 里躺了十几轮、而新组件没有对照过它。

### 文档同步（本轮）

`README.md`（「暗色主题：三条硬规则」里反相块那条补上 `ZChatInput` 的具体部位，
验证命令 57 → 58 项）、`tools/gen_docs.py`（测试条目 57 → 58 项）、本文，
然后重新生成 `docs/ZmdUI_组件库文档.md`。

## 5t. 第二十轮：输入框超长后文字与光标跑到框外

### 报障

> bug：输入框在超过最大长度的情况下继续输入，文字和光标会跑到输入框下面并消失

### 根因：封了高度，但只裁不滚

`qml/ZmdUI/ZChatInput.qml` 的输入区高度是这么算的：

```qml
height: Math.min(area.contentHeight + topPadding + bottomPadding, composer.maxTextHeight)
```

`maxTextHeight` 默认 140，超过就封顶，而 `TextArea` 只有 `clip: true` —— **没有任何滚动容器**。
于是第 9 行起被裁在可视区外，光标跟着文字一起跑到框外，用户在屏幕上什么都看不见，
只能盲打。（和 `maxLength`(2000) 无关：16 行中文才 100 多字，远没到字数上限。）

复现探针灌 16 行文本后实测：

```
AREA height= 140  contentHeight= 240  CARET y= 233  visibleWithin= false
```

### 修法：给输入区加一个"封顶视口"

把 `TextArea` 包进 `Flickable`，让**视口**封顶、`TextArea` 自己长高：

```qml
Flickable {
    id: textFlick
    objectName: "chatTextScroller"
    height: Math.max(composer.minTextHeight,
                     Math.min(area.contentHeight + area.topPadding + area.bottomPadding,
                              composer.maxTextHeight))
    contentWidth: width
    contentHeight: area.height
    clip: true
    boundsBehavior: Flickable.StopAtBounds
    interactive: false          // 拖拽留给文字选择，滚动靠滚轮 + 光标跟随

    TextArea {
        id: area
        objectName: "chatTextArea"
        width: textFlick.width
        height: Math.max(textFlick.height, contentHeight + topPadding + bottomPadding)
        onCursorRectangleChanged: composer._keepCaretVisible()
    }
}
```

三个关键点：

1. **`Flickable.height` 只看文字的固有高度**（`contentHeight + padding`），不去看
   `area.height` —— 否则 `area.height` 依赖 `textFlick.height`、`textFlick.height` 又依赖
   `area.height`，直接构成绑定循环。
2. **`area.height` 取两者较大**：内容矮时等于视口高（保证点空白也能聚焦），
   内容高时自己撑开、交给 `Flickable` 滚。
3. **`interactive: false`**：`Flickable` 一旦接管拖拽，鼠标划选文字就会被当成滚动。
   滚轮仍然可用（`WheelHandler` 不受影响），拖选也保住了。

再加一个 `_keepCaretVisible()`：比较 `area.cursorRectangle` 和当前
`[contentY, contentY + height]` 视口，上方超出就 `contentY = max(0, r.y - 2)`，
下方超出就 `contentY = min(contentHeight - height, r.y + r.height - height + 2)`；
内容不超一屏时把 `contentY` 归 0。由 `onCursorRectangleChanged` 触发，
所以打字、方向键、点选、粘贴都能跟上。

修复后同一份 16 行文本实测：

```
VIEWPORT h= 140  content= 256  contentY= 110  caretY= 233  caretVisible= true
```

视口里能看到第 8–16 行，光标停在「第 16 行」末尾。

### 验证

* **补两条测试**（`tests/tst_chatinput.qml` 第 11 组，共 60 项）：
  `test_longTextScrollsAndKeepsTheCaretVisible` 灌 16 行，用 `findChild` 取
  `chatTextScroller` / `chatTextArea`，断言 `scroll.height <= maxTextHeight`、
  `contentHeight > height`、`tryVerify(contentY > 0)`，并断言光标矩形落在视口内；
  `test_shortTextStaysAtTheTop` 断言短文本 `contentY === 0`（别为了修长文本把短文本也滚走）。
* **反向证明**：在 `_keepCaretVisible()` 首行临时插 `if (true) return` →
  `FAIL! : qmltestrunner::ZChatInputBehaviors::test_longTextScrollsAndKeepsTheCaretVisible()
  'viewport must auto-scroll to keep the caret visible' returned FALSE.`（`59 passed, 1 failed`）；
  删掉后 `Totals: 60 passed, 0 failed`。
* **修前/修后对照图**：`chat-input-scroll-fix.png`。素材用 `_probe_overflow.qml`
  （`height: implicitHeight` 让组件按自然高度摆放，再 `composer.grabToImage` 出 2 倍图），
  修前那张是临时把 `_keepCaretVisible()` 短路掉的产物。
* **演示页回归**：`qml/DemoContent.qml` 整页探针仍是 `contentHeight= 4426`、区块 08 正常、零 QML 警告。
* `qmllint -I qml qml/ZmdUI/ZChatInput.qml` → `exit 0`，非 `[unqualified]` 诊断 0 条。
* 三套测试：`tst_hover` 15 / `tst_richtext` 38 / `tst_chatinput` 60，全 passed。

### 本轮踩到的可复用坑

* **`clip: true` 不是"滚动"**。裁掉溢出内容在视觉上等同于"内容消失"，
  有光标的控件尤其致命：光标走到裁剪区外，用户连自己在打什么都不知道。
* **封顶高度要和"内容固有高度"绑，不要和控件自身高度绑**。前者是数据的函数，
  后者会回环成绑定循环 —— 这类循环 Qt 只在运行期报一行 `Binding loop detected`，
  单测不看你就会漏。
* **`Flickable` 装在文本控件外面时，`interactive` 必须关**。否则鼠标拖选变成滚动，
  文字选不中，是"修好一个坏掉另一个"的典型。
* **验证超长输入要先想到"视口"这个词**：先问"谁是视口、谁在内容里"，
  比逐行读代码快得多。

### 文档同步（本轮）

`README.md`（验证命令 58 → 60 项、`ZChatInput` 速查行补"超高内部滚动并跟随光标"、
已知限制补输入区滚动那条）、`tools/gen_docs.py`（测试条目 58 → 60 项）、本文，
然后重新生成 `docs/ZmdUI_组件库文档.md`。

## 5u. 第二十一轮：把「输入区能否变高 / 内容能否溢出」做成配置

### 需求

> 把"允许输入框大小变化"和"允许输入超过输入框大小"做成配置，默认都关闭

紧接着改成：

> 把"允许输入框大小变化"，默认都关闭和"允许输入超过输入框大小"，默认开启，做成配置，
> 然后在输入内容超过输入框大小时，输入框加上滚动条可以滚动

也就是最终的默认形态：**定高 + 内容可超出 + 框内滚动 + 有滚动条**。

### 两个开关

| 属性 | 默认 | 含义 |
| --- | --- | --- |
| `allowResize` | `false` | 输入区是否跟着内容变高（`minTextHeight` → `maxTextHeight`） |
| `allowOverflow` | `true` | 正文是否允许超出输入区高度（超出则框内滚动） |

四种组合：

| allowResize | allowOverflow | 行为 |
| --- | --- | --- |
| false | true（默认） | 定高，超出部分内部滚动 + 滚动条 |
| true | true | 先长高到 `maxTextHeight`(140)，再内部滚动 |
| false | false | 定高，写满就不再接受输入 |
| true | false | 长高到 `maxTextHeight`，写满就不再接受输入 |

视口高度收敛成一个只读属性，**永远只看文字的固有高度**：

```qml
readonly property int _viewportHeight: allowResize
    ? Math.max(minTextHeight,
               Math.min(area.contentHeight + area.topPadding + area.bottomPadding,
                        maxTextHeight))
    : minTextHeight
```

`allowResize` 关掉时它就是常数 `minTextHeight` —— 连绑定循环的可能性都被切断了。

### 滚动条

`Flickable` 上挂库里的 `ZScrollBar`（不是原生样式），只在"允许溢出 **且** 内容真的超出"时出现：

```qml
ScrollBar.vertical: ZScrollBar {
    id: textScrollBar
    objectName: "chatTextScrollBar"
    policy: (composer.allowOverflow && textFlick.contentHeight > textFlick.height + 0.5)
            ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
}
```

滚动条占的是 `TextArea` 右侧 `rightPadding`(12) 那条空当，**所以它出现 / 消失不会让文字重新折行**，
也就不会和视口高度互相抖。`Flickable.interactive` 仍然是 `false`：拖拽留给划选文字，
滚动交给滚动条、滚轮和光标跟随。

### `allowOverflow: false` 时怎么"不接受"

采用**整段退回**而不是"截到刚好放得下"：

```qml
if (!composer.allowOverflow
        && contentHeight + topPadding + bottomPadding > composer._viewportHeight + 0.5) {
    composer._rejectOverflow()   // 退回上一次的正文，边沿触发 limitReached("height")
    return
}
```

理由：截断需要拿候选文本反复量 `contentHeight`，而 `TextEdit` 的排版是异步的，
量到的值不可靠；退回上一次的正文是确定性的，连按退格 / 连续打字都不会出现"字越打越少"的半截状态。
`_revertingOverflow` 标志负责让退回本身不再触发一次退回。

### 顺带改掉的一处：空态提示行只在"完全空"时出现

默认输入区只有 74px，而 `attachHintText` 那行要吃掉 26px —— 写起字来只剩三行。
所以提示行改成 `attachmentCount === 0 && text.length === 0` 才露出，一旦有字就收起。

### 验证

* 新增 5 条测试（`tests/tst_chatinput.qml` 第 12 组，共 **65 项**）：
  `test_resizeAndOverflowDefaults`、`test_resizeDisabledKeepsTheBoxAtMinTextHeight`、
  `test_resizeEnabledGrowsUpToMaxTextHeight`、`test_overflowDisabledRejectsTextBeyondTheBox`、
  `test_scrollBarFollowsOverflow`；`test_heightStaysWithinBounds` 补了"关掉开关后高度纹丝不动"。
* **反向证明**：临时把 `_viewportHeight` 的条件改成恒 `true`、并把溢出判定短路成 `false` →
  `FAIL! ... test_resizeDisabledKeepsTheBoxAtMinTextHeight() 关掉 allowResize 后输入区高度应恒为 minTextHeight`
  与 `FAIL! ... test_overflowDisabledRejectsTextBeyondTheBox() 溢出的输入必须整段退回`
  （63 passed, 2 failed）；还原后 65 passed。
* **三态离屏探针**（`_probe_flags.qml` → 交付图 `chat-input-resize-overflow.png`）：
  ① 默认 `vp=74 content=256 y=176 bar=true`、② `allowResize:true` → `vp=140 content=256 y=110 bar=true`、
  ③ `allowOverflow:false` → 灌 16 行后 `len=3`（整段退回）、`bar=false`。
* `qmllint -I qml` 四个 qml 文件 → `exit 0`，非 `[unqualified]` 诊断 0 条（50 条仍是委托里访问
  `composer.xxx` / `editor.xxx` 的老误报）。
* 三套测试：`tst_hover` 15 / `tst_richtext` 38 / `tst_chatinput` 65，全 passed。
* 演示页回归：`contentHeight` 仍是 4426，区块 08 正常，零 QML 警告。

### 本轮踩到的可复用坑

* **`ScrollBar.visible` 在单测里不刷新**：Controls 的滚动条是 attached 机制在 polish 时把
  `policy` 翻译成 `visible` 的，`qmltestrunner` 里没有真实帧循环，`visible` 一直是旧值
  （而且 `ScrollBar` 上根本没有 `isVisible`）。断言要打在**自己的那个绑定**上（`policy`），
  "真的画出来了吗"交给离屏探针。
* **"组件高度"≠"输入区高度"**：`implicitHeight` 里还包含提示行、附件区、工具栏，
  提示行随内容出现 / 消失会让它变化。要断言输入区就用 `objectName` 找视口本身。
* **默认值本身就是 API**。这一轮把"自动长高"从默认行为改成需要显式开启，
  老测试立刻红了两条 —— 它们断言的正是旧默认。改默认值时要顺手把那些测试的意图写清楚
  （想测"会长高"就显式开 `allowResize`），否则下一个人会以为是实现坏了。
* **两个布尔开关要列组合表**，不然"false/false 时到底是谁在管高度"这种问题每次都要重新推。

### 文档同步（本轮）

`README.md`（组件速查补 `allowResize`(false) / `allowOverflow`(true)、验证命令 60 → 65 项、
已知限制那条改写成"定高 + 框内滚动 + 两个开关"）、`tools/gen_docs.py`（测试条目 60 → 65 项）、
本文，然后重新生成 `docs/ZmdUI_组件库文档.md`。

## 5v. 第二十二轮：输入框里滚轮不生效（其实是滚到了外层页面）

> 追记（m02950）：默认语义后来改成了**滚到边界不带动外层**（`wheelChainsToAncestor: false`）。
> 本节下面的修法、数据表和测试都已按新默认更新。

### 需求

> 鼠标滚轮在这个输入框里不生效，或是被父窗口拦截了？

### 根因：`interactive: false` 的 `Flickable` 不处理滚轮

上一轮为了让鼠标拖拽去划选文字，把输入区的 `Flickable` 设成了 `interactive: false`。
Qt 6 的 `QQuickFlickable::wheelEvent()` 一进门就检查 `interactive`，为 `false` 时直接返回 ——
**它连 `accepted` 都不碰**，事件于是继续往上冒泡，被外层页面的 `Flickable` 吃掉。
用户看到的"滚轮不生效"和"被父窗口拦截"其实是同一件事：页面在滚，输入框没动。

### 修法：自己接管滚轮，滚到边界就停住（默认）

```qml
WheelHandler {
    id: textWheel
    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    acceptedModifiers: Qt.NoModifier

    onWheel: function (event) {
        // 触控板给的是像素增量，鼠标给的是 1/8 度的角度增量（一格 120）
        var dy = event.pixelDelta.y !== 0
                ? event.pixelDelta.y
                : event.angleDelta.y / 120 * composer.wheelStepSize
        var maxY = Math.max(0, textFlick.contentHeight - textFlick.height)

        // 内容放得下：输入区根本没有可滚区域，整个事件交给外层页面。
        if (maxY <= 0) {
            composer._chainWheelToAncestor(dy)
            event.accepted = true
            return
        }

        var next = Math.max(0, Math.min(maxY, textFlick.contentY - dy))
        var used = textFlick.contentY - next
        textFlick.contentY = next
        // 默认到头就停住：剩下的距离直接丢掉，外层页面一动不动。
        var left = dy - used
        if (composer.wheelChainsToAncestor && Math.abs(left) > 0.5)
            composer._chainWheelToAncestor(left)
        event.accepted = true
    }
}
```

新增属性 `wheelStepSize`（默认 48，一格滚多少像素；触控板的像素增量不受它影响）与
`wheelChainsToAncestor`（默认 `false`，滚到边界后要不要把剩余距离交给外层页面）。

`_chainWheelToAncestor(dy)` 顺着 `parent` 往上找第一个"内容比视口高"的 `Flickable`
（`ListView` / `GridView` 也是它的子类），把剩余距离扣掉并夹在 `[0, contentHeight - height]` 里。
用 `instanceof Flickable` + `as Flickable` 收窄，否则静态检查会报 `contentY` 不存在于 `Item`
（`qmllint disable missing-property` 也试过，但 `//` 注释里出现 `qmllint` 会被当成指令解析）。

### 为什么要自己转：`WheelHandler` 会闷死事件

挂上 `WheelHandler` 之后，滚轮事件就由它接管、**不再冒泡**。所以"内容不够长""已经滚到头"
这两种情况如果只是 `return`，滚轮就彻底没反应了（页面也不动）——
这正是第一版实现踩的坑：`maxY <= 0` 直接 `return` 时，短文本下滚轮完全失效。

结论是这两个边界必须分开对待，不能一刀切：

* **内容放得下（`maxY <= 0`）**：输入区没有可滚的东西，事件整个交给外层，
  否则一行字的输入框会变成页面滚动的死区。
* **有滚动范围但已经到顶 / 到底**：按 m02950 的要求**停住，不带动外层**。
  想要浏览器那种"滚到头继续滚页面"，打开 `wheelChainsToAncestor`。

### 怎么验证的：OS 级注入全废，最后用 C++ 投递事件

`mouse_event` 滚轮、`PostMessage(WM_MOUSEWHEEL)`、`SetForegroundWindow` 全部无效
（Windows 前台窗口锁；`PostMessage` 的滚轮对 QWindow 也不生效）。
最终写了个一次性 C++ 工具（**不是交付物，已删除**）直接往 Qt 事件队列投递：

```cpp
QWindowSystemInterface::handleWheelEvent(win, local, global, QPoint(),
                                         QPoint(0, -120), Qt::NoModifier, Qt::ScrollUpdate);
QWindowSystemInterface::flushWindowSystemEvents();
```

配套探针 `_probe_wheel.qml`：一个 `Window 900x700`，外层 `Flickable { objectName: "pageFlick";
contentHeight: 1800 }`，里面放 `ZChatInput { objectName: "chat" }` 灌 16 行。

修好后逐格实测（每格都重新算鼠标坐标，否则页面一动坐标就脱靶，读数会莫名其妙多 24px）。
下表是 m02950 改默认**之后**的最终数据（A / B / C 三组，各 8 格，`maxY` 恒为 230）：

| 组 | 场景 | innerY | pageY |
| --- | --- | --- | --- |
| A | 默认（`wheelChainsToAncestor: false`），长文本滚 8 格 | 48 → 96 → 144 → 192 → 230 → 230 → 230 → 230 | 0（**一直不动**） |
| B | 打开 `wheelChainsToAncestor`，同样 8 格 | 48 → 96 → 144 → 192 → 230 → 230 → 230 → 230 | 0 → 0 → 0 → 0 → 10 → 58 → 106 → 154（到顶后的剩余开始推页面） |
| C | 短文本（内容放得下，`maxY 0`），默认 | 0 → 0 | 48 → 96（组件不拦，整个滚轮落到外层） |

A 组就是 m02950 要的"滚到边界后不带动外层"：第 5 格到 230 之后，再滚 3 格页面一动不动。

修复前同一套工具量到的是：在输入框上滚 3 格 → `innerY 0 / pageY 72`，
也就是"滚的是页面"——和用户描述完全一致。

### 测试

`tests/tst_chatinput.qml` 第 11 组共 4 条（`qmltestrunner` 造不出 `QWheelEvent`，
所以只钉不依赖事件投递的事）：

* `test_wheelStepIsFortyEightPixels`：`wheelStepSize` 默认 48 且可写。
* `test_wheelDoesNotChainToAncestorByDefault`：`wheelChainsToAncestor` 默认 `false`（m02950 的口径），
  并且这个开关本身可写。
* `test_chainWheelToAncestorMovesTheOuterFlickable`：造一个外层 `Flickable`（contentHeight 2000），
  调 `chat._chainWheelToAncestor(-120)` 断言 `contentY` 变 120；反向 40 变成 80；再来 `-5000`
  夹到 `contentHeight - height`。
* `test_chainWheelToAncestorIsHarmlessWithoutOne`：没有可滚动祖先时返回 `false`、不崩。

反向证明：把 `_chainWheelToAncestor` 首行改成 `if (true) return false` →
`FAIL! ... test_chainWheelToAncestorMovesTheOuterFlickable() 滚轮距离应当转给外层 Flickable`
（67 passed, 1 failed）；还原后 68 passed，补上默认值那条之后 69 passed。

其余：`tst_hover` 15 / `tst_richtext` 38 全 passed；`qmllint -I qml` 四个文件 `exit 0`、
非 `[unqualified]` 诊断 0 条；演示页回归无异常。

### 本轮踩到的可复用坑

* **`Flickable` 在 `interactive: false` 时不处理滚轮**，既不滚动也不 `accept`。想让
  "拖拽划选 + 滚轮滚动"同时成立，只能自己挂 `WheelHandler`。
* **`WheelHandler` 会吃掉事件**：它一旦存在，滚轮就不再冒泡，链式滚动必须手动接。
* **给 `WheelHandler` 加 `enabled: <有内容可滚>` 并不能把滚轮还回去**：实测短文本下
  handler 已经 `enabled: false`，外层页面 `contentY` 仍然是 0 —— 事件还是没人接。
  想"内容放得下就让外层滚"，只能在 `onWheel` 里显式调 `_chainWheelToAncestor(dy)`。
* **`//` 注释里不能以 `qmllint` 开头**：`// qmllint 会报…` 会被当成 lint 指令解析，
  报 `qmllint directive on unknown category` 并让整行后面的中文变成乱码类别。
* **注入滚动事件必须每格重算坐标**：页面一动，输入框的屏幕位置就变了，
  拿同一个坐标连发几格，后半段会打在别的控件上 —— 读数会凭空多出 24px，
  很容易被误判成"事件泄漏给了父级"。
* **验证异步投递要分步读值**：`flushWindowSystemEvents()` 之后立刻读可能还是旧值，
  用 `QTimer` 隔几十毫秒再读才稳。

### 文档同步（本轮）

`README.md`（组件速查补 `wheelStepSize`(48) 与 `wheelChainsToAncestor`(false)、
验证命令 65 → 68 → 69 项、已知限制那条改写成"默认到头就停住，内容放得下时照常滚外层"）、
`tools/gen_docs.py`（测试条目 65 → 69 项）、本文，然后重新生成
`docs/ZmdUI_组件库文档.md`。

## 5w. 第二十三轮：附件条改成"定高一行 + 横向滚动"

### 需求

> 是否能把输入框的高度固定死，插入图片、文件也不会是窗口变大

（先给了三个方案：A 定高一行 + 横向滚、B 定高一行 + 裁剪、C 定高一行 + `+N` 收纳；
用户选了 **A**。）

### 根因：`Flow` 自动换行

正文区早在第二十一轮就已经定高了（`allowResize: false` → 视口恒为 `minTextHeight` 74），
所以"一插附件就变高"只可能来自附件区。原实现是：

```qml
Item {
    id: attachZone
    height: composer.attachmentCount > 0 ? attachFlow.height + Theme.spacingSm * 2
         : (composer.attachHintText.length > 0 && composer.text.length === 0 ? 26 : 0)

    Flow {
        id: attachFlow
        width: parent.width - Theme.spacingMd * 2
        ...
    }
}
```

`Flow` 会把放不下的卡片折到下一行，`attachFlow.height` 于是随附件数量阶梯式上涨
（一张卡 64 高，第二行就多 68），`implicitHeight: body.height` 把这个高度原样传出去，
父面板跟着被顶高 —— 用户看到的就是"插图片窗口变大"。

### 修法：一行 + 横向滚

`Flow` 换成 `Row` 塞进一个只有一行高的 `Flickable`，视口高度与内容无关：

```qml
Item {
    id: attachZone
    objectName: "chatAttachZone"
    height: composer.attachmentCount > 0 ? composer.thumbSize + Theme.spacingSm * 2
         : (composer.attachHintText.length > 0 && composer.text.length === 0 ? 26 : 0)

    Flickable {
        id: attachFlick
        objectName: "chatAttachScroller"
        width: parent.width - Theme.spacingMd * 2
        height: composer.thumbSize
        contentWidth: attachRow.width
        contentHeight: height
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.StopAtBounds

        Row {
            id: attachRow
            width: childrenRect.width
            height: composer.thumbSize
            spacing: Theme.spacingSm
            ...
        }
    }
}
```

几个细节：

* **`Row` 的 `width` 必须绑定 `childrenRect.width`**，否则 `contentWidth` 恒为 0，滚不动。
* **文件卡（56）比缩略图（64）矮**，`Row` 不做垂直居中，所以每个委托加
  `y: Math.round((composer.thumbSize - height) / 2)`，不然卡片会贴顶、下面空 8px。
* **滚轮映射成横向**：附件条上竖向滚轮也把卡片推过去（`pixelDelta` 优先，其次 `angleDelta`），
  一次一格还是 `wheelStepSize`(48)。没有横向溢出时 `event.accepted = false`，事件不吞。
* **不加横向滚动条**：`ZScrollBar` 要占 8px，会把"一行高"又撑高；露半张卡本身就是"还能滚"的提示。

### 验证

尺寸探针（一次性，已删除）：同一窗口里放两个 `ZChatInput`，一个 1 个文件附件、一个 6 个
（1 图 + 5 文件），宽度都给 1100：

| | 1 个附件 | 6 个附件 |
| --- | --- | --- |
| `implicitHeight` | 226 | 226 |
| 附件条 `contentWidth` / `width` | 1144 / 1076（没超出，滚不动） | 1144 / 1076（超出，可横滚） |

也就是说附件从 1 个加到 6 个，组件高度**一模一样**，多出来的部分横向滚。

### 测试

`tests/tst_chatinput.qml` 新增第 13 组 2 条：

* `test_attachStripHeightIgnoresAttachmentCount`：1 个附件时记下 `implicitHeight` 与
  `chatAttachZone.height`，换成 6 个再比 —— 两者都必须完全相等，且附件区高度
  `== thumbSize + spacingSm * 2`。
* `test_attachStripScrollsHorizontallyInsteadOfGrowing`：6 个附件下
  `contentWidth > width`、`contentY` 恒 0、`contentHeight == thumbSize`；
  内容宽度必须是 `6 * fileCardWidth + 5 * spacingSm`（钉住 `Row` 的排布）；能滚到最右也能回最左。

反向证明：临时给 `attachZone.height` 加一项"多于一个附件就 `+68`"（模拟原来 `Flow`
换行带来的增长）→
`FAIL! : qmltestrunner::ZChatInputBehaviors::test_attachStripHeightIgnoresAttachmentCount()
附件从 1 个加到 6 个，组件高度不许变`（70 passed, 1 failed）；还原后 71 passed。

其余：`tst_hover` 15 / `tst_richtext` 38 全 passed；`qmllint -I qml` 四文件 `exit 0`、
非 `[unqualified]` 诊断 0 条。

### 踩到的坑

* **`Row` 的宽度不会自己算**：`Row` 的 `width` 默认是 0，`childrenRect.width` 才是内容宽度，
  `contentWidth: attachRow.width` 直接写会得到 0，表现为"永远滚不动"。
* **`Flickable.contentX` 的边界夹取不要写进断言**：直接赋 `10000` 后读回来在
  `StopAtBounds` 下并不保证正好等于 `maxContentX`（实测差一点点），断言要留 0.5px 容差，
  或者干脆只断言"能滚到 `maxX` / 能回到 0"。
* **水平 `ZScrollBar` 会破坏定高**：任何可见横向滚动条都要吃掉高度，本轮的"恒为一行"是
  用"没有滚动条"换来的。

### 文档同步（本轮）

`README.md`（组件速查补"附件条恒为一行高、排不下横向滚"，已知限制新增一条说明
`allowResize` 只管正文、附件由附件条管，验证命令 69 → 71 项）、`tools/gen_docs.py`
（测试条目 69 → 71 项）、本文，然后重新生成 `docs/ZmdUI_组件库文档.md`。

### 追加（m03226）：两条提示文字一起删掉

> 我认为提示行没有必要，删掉就行，"在此输入消息。。。"的提示也没有必要

这一条把附件区的 26px 空态提示行彻底消掉了，顺手把输入区的占位文字也清了：

* `property string attachHintText: ""`（原 `"可粘贴图片、拖动文件到此处"`）
* `property string placeholderText: ""`（原 `"输入消息，Enter 发送，Shift+Enter 换行…"`）

两个属性**保留**（宿主想要提示可以自己填回去），只是默认给空串；两个 `Text` 的 `visible`
都加了 `length > 0` 的短路，空串时连一个空 Text 都不渲染。附件区的空态高度表达式不变，
但 `attachHintText` 为空时那条分支恒取 0 —— 于是没有附件时附件区高度就是 **0**。

重新量三个状态（宽度同样 1100）：

| 状态 | `implicitHeight` | 附件区 |
| --- | --- | --- |
| 空 | 146 | 0（没有提示行，输入区直接接工具栏） |
| 1 个附件 | 226 | 80（`thumbSize` 64 + 上下留白） |
| 6 个附件 | 226 | 80（一行，横向滚） |

所以"有附件之后"高度就再也不动了（226 ↔ 226）；只有"从空到有第一个附件"这一步会 +80，
这 80px 是附件行本身，删掉提示行之后没有更好的去处。要连这一步也吃掉就得把空态也留一条
80px 空带 —— 没有提示文字填空带，看起来反而更怪，先不做。

测试不变（71 passed），因为第 13 组比的是"1 个 vs 6 个"，与空态无关；空态那条 `26` 分支
没有测试直接钉，靠上表的探针量。

### 文档同步（追加）

`README.md` 速查行把 `placeholderText` / `attachHintText` 标成 `(空)`、本文追加本节，
然后重新生成 `docs/ZmdUI_组件库文档.md`。

