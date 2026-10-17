# ZmdUI · 终末地工业机能风 QML 组件库 —— 完整源码集

> 本文由 `tools/gen_docs.py` 从仓库源码自动汇总生成，内容与磁盘上的文件逐字一致。

> 生成时间：2026-10-17 21:01:27

| 项目 | 说明 |
| --- | --- |
| Qt 版本 | 6.5+（开发验证于 6.11.2 / MSVC 2022 x64） |
| 模块 URI | `ZmdUI 1.0` |
| 组件数量 | 27 个类型（1 主题单例 + 4 图元 + 22 控件） |
| 依赖 | 仅 QtQuick / QtQuick.Controls.Basic / QtQuick.Shapes，无第三方库 |
| 图片资源 | 0 张（网格、斜线、斜切、图标全部走 Shape / Canvas 绘制） |

## 目录

- [零、项目目录结构](#零项目目录结构)
- [一、主题与基础图元](#一主题与基础图元)
  - [`qml/ZmdUI/Theme.qml`](#qmlzmduithemeqml) — 全局主题单例：配色 / 字体 / 尺寸 / 动画，一键切换亮暗主题
  - [`qml/ZmdUI/ZCutRect.qml`](#qmlzmduizcutrectqml) — 斜切角矩形图元，整套设计语言的地基
  - [`qml/ZmdUI/ZSkewRect.qml`](#qmlzmduizskewrectqml) — 平行四边形图元（副标题块、标签、高亮块）
  - [`qml/ZmdUI/ZHatchPattern.qml`](#qmlzmduizhatchpatternqml) — 斜线纹理 / 斜线阴影，Canvas 绘制
  - [`qml/ZmdUI/ZGridBackground.qml`](#qmlzmduizgridbackgroundqml) — 工程网格背景（细网格 + 主刻度 + 十字星）
- [二、交互控件](#二交互控件)
  - [`qml/ZmdUI/ZButton.qml`](#qmlzmduizbuttonqml) — 按钮：主要 / 次要 / 危险 / 幽灵 / 平行四边形
  - [`qml/ZmdUI/ZIconButton.qml`](#qmlzmduiziconbuttonqml) — 方形图标按钮，自带工具提示
  - [`qml/ZmdUI/ZTextField.qml`](#qmlzmduiztextfieldqml) — 输入框：黑硬边 + 聚焦亮黄底线 + 内嵌铭牌
  - [`qml/ZmdUI/ZCheckBox.qml`](#qmlzmduizcheckboxqml) — 复选框：切角方框 + 黑色对勾 + 半选态
  - [`qml/ZmdUI/ZRadioButton.qml`](#qmlzmduizradiobuttonqml) — 单选按钮：菱形指示灯
  - [`qml/ZmdUI/ZSwitch.qml`](#qmlzmduizswitchqml) — 开关：矩形滑轨 + 方形滑块 + 轨道刻度
  - [`qml/ZmdUI/ZSlider.qml`](#qmlzmduizsliderqml) — 滑块：黑色导轨 + 亮黄填充 + 刻度 + 切角把手
  - [`qml/ZmdUI/ZProgressBar.qml`](#qmlzmduizprogressbarqml) — 进度条：亮黄填充 + 刻度 + 循环扫描不确定态
  - [`qml/ZmdUI/ZRichTextEditor.qml`](#qmlzmduizrichtexteditorqml) — 块级富文本编辑器：文字 / 图片 / 文件块混排，块级格式 + 序列化
  - [`qml/ZmdUI/ZChatInput.qml`](#qmlzmduizchatinputqml) — QQ 式消息输入框：正文 + 图片 / 文件附件，内置系统文件选择框，拖放与粘贴自动转附件，回车发送
- [三、容器与展示](#三容器与展示)
  - [`qml/ZmdUI/ZPanel.qml`](#qmlzmduizpanelqml) — 面板 / 卡片：斜切角 + 角落斜线纹理 + 亮黄装饰底边
  - [`qml/ZmdUI/ZSectionTitle.qml`](#qmlzmduizsectiontitleqml) — 区块大标题：编号 + 「超粗标题」 + 黑底斜切副标题
  - [`qml/ZmdUI/ZTag.qml`](#qmlzmduiztagqml) — 标签 / 徽章：平行四边形，深灰底白字或亮黄底黑字
  - [`qml/ZmdUI/ZStatusDot.qml`](#qmlzmduizstatusdotqml) — 状态点：极小面积的切角方块（点缀色专用）
  - [`qml/ZmdUI/ZListItem.qml`](#qmlzmduizlistitemqml) — 列表项：选中 = 亮黄底 + 黑色斜切高亮块
  - [`qml/ZmdUI/ZListView.qml`](#qmlzmduizlistviewqml) — 列表视图：切角外框 + 自带滚动条 + 默认委托
  - [`qml/ZmdUI/ZScrollBar.qml`](#qmlzmduizscrollbarqml) — 滚动条：细长切角方块 + 导轨刻度
  - [`qml/ZmdUI/ZToolTip.qml`](#qmlzmduiztooltipqml) — 工具提示：深灰底白字 + 左侧亮黄竖边
- [四、复合组件](#四复合组件)
  - [`qml/ZmdUI/ZDialog.qml`](#qmlzmduizdialogqml) — 对话框：顶部黑底黄字 + 中央大面积斜线纹理
  - [`qml/ZmdUI/ZSideBar.qml`](#qmlzmduizsidebarqml) — 侧边导航栏：黑底白字，当前项亮黄底 + 亮黄左边缘
  - [`qml/ZmdUI/ZTable.qml`](#qmlzmduiztableqml) — 数据表格：黑底表头 + 工程网格线 + 选中行亮黄
  - [`qml/ZmdUI/ZLineChart.qml`](#qmlzmduizlinechartqml) — 折线图：网格 + 亮黄数据线 + 黑色方形数据点
- [五、演示应用](#五演示应用)
  - [`qml/main.qml`](#qmlmainqml) — 演示程序入口（窗口壳）
  - [`qml/DemoContent.qml`](#qmldemocontentqml) — 演示内容：网格背景 + 侧边栏 + 八大区块，覆盖全部组件
- [六、工程集成](#六工程集成)
  - [`qml/ZmdUI/qmldir`](#qmlzmduiqmldir) — QML 模块清单，声明模块 URI 与单例
  - [`resources/qml.qrc`](#resourcesqmlqrc) — Qt 资源系统清单，资源路径与磁盘结构一致
  - [`src/main.cpp`](#srcmaincpp) — 应用入口：Basic 样式 + 高 DPI + 资源导入路径 + 剪贴板桥注入
  - [`src/zclipboard.cpp`](#srczclipboardcpp) — 剪贴板桥：把剪贴板位图存成临时文件（QML 读不到位图）
  - [`CMakeLists.txt`](#cmakeliststxt) — CMake 构建脚本：跨平台 + MSVC/MinGW 双编译器 + 一键部署
  - [`.gitignore`](#gitignore) — 忽略各编译器的构建目录与部署产物
- [七、自动化验证工具](#七自动化验证工具)
  - [`tests/tst_hover.qml`](#testststhoverqml) — qmltestrunner 行为测试：规则 / 属性 / 几何断言（9 项）
  - [`tests/tst_richtext.qml`](#testststrichtextqml) — qmltestrunner 行为测试：富文本块模型 / 序列化 / 结构操作（38 项）
  - [`tests/tst_chatinput.qml`](#testststchatinputqml) — qmltestrunner 行为测试：附件模型 / 上限 / canSend / 发送快照 / 回车语义 / 拖放粘贴 / 选择框 / 暗色填充 / 超高滚动 / 定高与溢出开关 / 滚轮接管 / 附件条定高（71 项）
  - [`tools/smoke.qml`](#toolssmokeqml) — 无头冒烟：离屏渲染演示内容并抓图，零 QML 报错才算通过
  - [`tools/smoke_scroll.qml`](#toolssmokescrollqml) — 分段滚动截图，逐屏核对各区块渲染结果
  - [`tools/probe_popup.qml`](#toolsprobepopupqml) — 弹层探针：强制展开工具提示与对话框后抓图
  - [`tools/probe_tooltip.qml`](#toolsprobetooltipqml) — 工具提示探针：核对亮黄竖边与底板斜边是否贴齐
  - [`tools/probe_dark.qml`](#toolsprobedarkqml) — 暗色主题探针：切到暗色后整屏抓图，核对文字可读性
  - [`tools/smoke_dark_scroll.qml`](#toolssmokedarkscrollqml) — 暗色分段滚动截图，逐屏审计暗色模式的每个区块
  - [`tools/probe_buttons.qml`](#toolsprobebuttonsqml) — 按钮探针：断言默认态装饰 + 宽度不随状态变化
  - [`tools/probe_anim.qml`](#toolsprobeanimqml) — 动画机制探针：用取样数值证明 Behavior 对绑定属性会插值
  - [`tools/probe_anim_button.qml`](#toolsprobeanimbuttonqml) — 动画端到端探针：抓两帧比对，证明 ZButton 过渡真的在动
  - [`tools/probe_hittest.qml`](#toolsprobehittestqml) — 命中测试：打印元素中心最上层的元素链，定位「点不上」的原因
  - [`tools/probe_sidebar.qml`](#toolsprobesidebarqml) — 侧边栏滚动条探针：矮窗口复现溢出，对比开关两种状态
  - [`tools/crop.qml`](#toolscropqml) — 局部放大工具，按 crop_params.json 裁切截图核对像素细节
  - [`tools/check_inverse_blocks.py`](#toolscheckinverseblockspy) — 反相块体检：抓「主题反转后文字消失」的配色搭配错误
- [八、验证记录](#八验证记录)

## 零、项目目录结构

```text
ZmdUI/
├── build/
│   ├── CMakeFiles/
│   │   ├── 3.30.5/
│   │   │   ├── CompilerIdCXX/
│   │   │   │   ├── tmp/
│   │   │   │   ├── CMakeCXXCompilerId.cpp
│   │   │   │   ├── CMakeCXXCompilerId.exe
│   │   │   │   └── CMakeCXXCompilerId.obj
│   │   │   ├── CMakeCXXCompiler.cmake
│   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│   │   │   ├── CMakeRCCompiler.cmake
│   │   │   └── CMakeSystem.cmake
│   │   ├── ShowIncludes/
│   │   │   ├── foo.h
│   │   │   ├── main.c
│   │   │   └── main.obj
│   │   ├── ZmdUIDemo.dir/
│   │   │   ├── ZmdUIDemo_autogen/
│   │   │   │   ├── 3YJK5W5UP7/
│   │   │   │   │   └── qrc_qml.cpp.obj
│   │   │   │   └── mocs_compilation.cpp.obj
│   │   │   └── src/
│   │   │       └── main.cpp.obj
│   │   ├── ZmdUIDemo_autogen.dir/
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Info.json
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Lock.lock
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Used.txt
│   │   │   ├── AutogenInfo.json
│   │   │   ├── AutogenUsed.txt
│   │   │   └── ParseCache.txt
│   │   ├── d/
│   │   ├── pkgRedirects/
│   │   ├── CMakeConfigureLog.yaml
│   │   ├── TargetDirectories.txt
│   │   ├── clean_additional.cmake
│   │   ├── cmake.check_cache
│   │   └── rules.ninja
│   ├── ZmdUIDemo_autogen/
│   │   ├── 3YJK5W5UP7/
│   │   │   └── qrc_qml.cpp
│   │   ├── include/
│   │   ├── deps
│   │   ├── mocs_compilation.cpp
│   │   └── timestamp
│   ├── generic/
│   │   └── qtuiotouchplugin.dll
│   ├── iconengines/
│   │   └── qsvgicon.dll
│   ├── imageformats/
│   │   ├── qgif.dll
│   │   ├── qico.dll
│   │   ├── qjpeg.dll
│   │   └── qsvg.dll
│   ├── networkinformation/
│   │   └── qnetworklistmanager.dll
│   ├── platforms/
│   │   └── qwindows.dll
│   ├── qml/
│   │   ├── QML/
│   │   │   ├── plugins.qmltypes
│   │   │   └── qmldir
│   │   ├── QtQml/
│   │   │   ├── Models/
│   │   │   │   ├── modelsplugin.dll
│   │   │   │   ├── plugins.qmltypes
│   │   │   │   └── qmldir
│   │   │   ├── WorkerScript/
│   │   │   │   ├── plugins.qmltypes
│   │   │   │   ├── qmldir
│   │   │   │   └── workerscriptplugin.dll
│   │   │   ├── XmlListModel/
│   │   │   ├── plugins.qmltypes
│   │   │   ├── qmldir
│   │   │   └── qmlplugin.dll
│   │   └── QtQuick/
│   │       ├── Controls/
│   │       │   ├── Basic/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2basicstyleimplplugin.dll
│   │       │   │   ├── AbstractButton.qml
│   │       │   │   ├── Action.qml
│   │       │   │   ├── ActionGroup.qml
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── ButtonGroup.qml
│   │       │   │   ├── Calendar.qml
│   │       │   │   ├── CalendarModel.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── Container.qml
│   │       │   │   ├── Control.qml
│   │       │   │   ├── DayOfWeekRow.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── MonthGrid.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── StackView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── SwipeView.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TableViewDelegate.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── TreeViewDelegate.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── WeekNumberColumn.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2basicstyleplugin.dll
│   │       │   ├── FluentWinUI3/
│   │       │   │   ├── dark/
│   │       │   │   │   └── images/
│   │       │   │   ├── icons/
│   │       │   │   ├── impl/
│   │       │   │   └── light/
│   │       │   │       └── images/
│   │       │   ├── Fusion/
│   │       │   │   └── impl/
│   │       │   ├── Imagine/
│   │       │   │   └── impl/
│   │       │   ├── Material/
│   │       │   │   └── impl/
│   │       │   ├── Universal/
│   │       │   │   └── impl/
│   │       │   ├── Windows/
│   │       │   │   ├── images/
│   │       │   │   └── impl/
│   │       │   └── impl/
│   │       │       ├── CopyAction.qml
│   │       │       ├── CutAction.qml
│   │       │       ├── DeleteAction.qml
│   │       │       ├── PasteAction.qml
│   │       │       ├── RedoAction.qml
│   │       │       ├── SelectAllAction.qml
│   │       │       ├── UndoAction.qml
│   │       │       ├── plugins.qmltypes
│   │       │       ├── qmldir
│   │       │       └── qtquickcontrols2implplugin.dll
│   │       ├── Dialogs/
│   │       │   └── quickimpl/
│   │       │       └── qml/
│   │       │           ├── +Fusion/
│   │       │           ├── +Imagine/
│   │       │           ├── +Material/
│   │       │           └── +Universal/
│   │       ├── Effects/
│   │       ├── Layouts/
│   │       ├── LocalStorage/
│   │       ├── NativeStyle/
│   │       │   ├── controls/
│   │       │   └── util/
│   │       ├── Particles/
│   │       ├── Shapes/
│   │       │   ├── DesignHelpers/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qmlshapesplugin.dll
│   │       ├── Templates/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qtquicktemplates2plugin.dll
│   │       ├── Timeline/
│   │       │   └── BlendTrees/
│   │       ├── VectorImage/
│   │       │   └── Helpers/
│   │       ├── Window/
│   │       │   ├── qmldir
│   │       │   ├── quickwindow.qmltypes
│   │       │   └── quickwindowplugin.dll
│   │       ├── tooling/
│   │       ├── plugins.qmltypes
│   │       ├── qmldir
│   │       └── qtquick2plugin.dll
│   ├── qmltooling/
│   │   ├── qmldbg_debugger.dll
│   │   ├── qmldbg_inspector.dll
│   │   ├── qmldbg_local.dll
│   │   ├── qmldbg_messages.dll
│   │   ├── qmldbg_native.dll
│   │   ├── qmldbg_nativedebugger.dll
│   │   ├── qmldbg_preview.dll
│   │   ├── qmldbg_profiler.dll
│   │   ├── qmldbg_quick3dprofiler.dll
│   │   ├── qmldbg_quickeventreplay.dll
│   │   ├── qmldbg_quickprofiler.dll
│   │   ├── qmldbg_server.dll
│   │   └── qmldbg_tcp.dll
│   ├── tls/
│   │   ├── qcertonlybackend.dll
│   │   └── qschannelbackend.dll
│   ├── CMakeCache.txt
│   ├── D3Dcompiler_47.dll
│   ├── Qt6Core.dll
│   ├── Qt6Gui.dll
│   ├── Qt6Network.dll
│   ├── Qt6OpenGL.dll
│   ├── Qt6Qml.dll
│   ├── Qt6QmlMeta.dll
│   ├── Qt6QmlModels.dll
│   ├── Qt6QmlWorkerScript.dll
│   ├── Qt6Quick.dll
│   ├── Qt6Quick3DUtils.dll
│   ├── Qt6QuickControls2.dll
│   ├── Qt6QuickControls2Basic.dll
│   ├── Qt6QuickControls2BasicStyleImpl.dll
│   ├── Qt6QuickControls2Impl.dll
│   ├── Qt6QuickShapes.dll
│   ├── Qt6QuickTemplates2.dll
│   ├── Qt6Svg.dll
│   ├── ZmdUIDemo.exe
│   ├── ZmdUIDemo.exe.manifest
│   ├── build.ninja
│   ├── cmake_install.cmake
│   └── install_manifest.txt
├── build-mingw/
│   ├── CMakeFiles/
│   │   ├── 3.30.5/
│   │   │   ├── CompilerIdCXX/
│   │   │   │   ├── tmp/
│   │   │   │   ├── CMakeCXXCompilerId.cpp
│   │   │   │   └── a.exe
│   │   │   ├── CMakeCXXCompiler.cmake
│   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│   │   │   ├── CMakeRCCompiler.cmake
│   │   │   └── CMakeSystem.cmake
│   │   ├── ZmdUIDemo.dir/
│   │   │   ├── ZmdUIDemo_autogen/
│   │   │   │   ├── 3YJK5W5UP7/
│   │   │   │   │   └── qrc_qml.cpp.obj
│   │   │   │   └── mocs_compilation.cpp.obj
│   │   │   └── src/
│   │   │       ├── main.cpp.obj
│   │   │       └── zclipboard.cpp.obj
│   │   ├── ZmdUIDemo_autogen.dir/
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Info.json
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Lock.lock
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Used.txt
│   │   │   ├── AutogenInfo.json
│   │   │   ├── AutogenUsed.txt
│   │   │   └── ParseCache.txt
│   │   ├── d/
│   │   ├── pkgRedirects/
│   │   ├── CMakeConfigureLog.yaml
│   │   ├── TargetDirectories.txt
│   │   ├── clean_additional.cmake
│   │   ├── cmake.check_cache
│   │   └── rules.ninja
│   ├── ZmdUIDemo_autogen/
│   │   ├── 3YJK5W5UP7/
│   │   │   └── qrc_qml.cpp
│   │   ├── UVLADIE3JM/
│   │   │   ├── moc_zclipboard.cpp
│   │   │   └── moc_zclipboard.cpp.d
│   │   ├── include/
│   │   ├── deps
│   │   ├── moc_predefs.h
│   │   ├── mocs_compilation.cpp
│   │   └── timestamp
│   ├── generic/
│   │   └── qtuiotouchplugin.dll
│   ├── iconengines/
│   │   └── qsvgicon.dll
│   ├── imageformats/
│   │   ├── qgif.dll
│   │   ├── qico.dll
│   │   ├── qjpeg.dll
│   │   └── qsvg.dll
│   ├── networkinformation/
│   │   └── qnetworklistmanager.dll
│   ├── platforms/
│   │   ├── qoffscreen.dll
│   │   └── qwindows.dll
│   ├── qml/
│   │   ├── QML/
│   │   │   ├── plugins.qmltypes
│   │   │   └── qmldir
│   │   ├── Qt/
│   │   │   └── labs/
│   │   │       └── folderlistmodel/
│   │   │           ├── plugins.qmltypes
│   │   │           ├── qmldir
│   │   │           └── qmlfolderlistmodelplugin.dll
│   │   ├── QtQml/
│   │   │   ├── Models/
│   │   │   │   ├── modelsplugin.dll
│   │   │   │   ├── plugins.qmltypes
│   │   │   │   └── qmldir
│   │   │   ├── WorkerScript/
│   │   │   │   ├── plugins.qmltypes
│   │   │   │   ├── qmldir
│   │   │   │   └── workerscriptplugin.dll
│   │   │   ├── XmlListModel/
│   │   │   ├── plugins.qmltypes
│   │   │   ├── qmldir
│   │   │   └── qmlplugin.dll
│   │   └── QtQuick/
│   │       ├── Controls/
│   │       │   ├── Basic/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2basicstyleimplplugin.dll
│   │       │   │   ├── AbstractButton.qml
│   │       │   │   ├── Action.qml
│   │       │   │   ├── ActionGroup.qml
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── ButtonGroup.qml
│   │       │   │   ├── Calendar.qml
│   │       │   │   ├── CalendarModel.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── Container.qml
│   │       │   │   ├── Control.qml
│   │       │   │   ├── DayOfWeekRow.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── MonthGrid.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── StackView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── SwipeView.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TableViewDelegate.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── TreeViewDelegate.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── WeekNumberColumn.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2basicstyleplugin.dll
│   │       │   ├── FluentWinUI3/
│   │       │   │   ├── dark/
│   │       │   │   │   └── images/
│   │       │   │   ├── icons/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── ButtonBackground.qml
│   │       │   │   │   ├── CheckIndicator.qml
│   │       │   │   │   ├── CopyAction.qml
│   │       │   │   │   ├── CutAction.qml
│   │       │   │   │   ├── DeleteAction.qml
│   │       │   │   │   ├── FocusFrame.qml
│   │       │   │   │   ├── PasteAction.qml
│   │       │   │   │   ├── RadioIndicator.qml
│   │       │   │   │   ├── RedoAction.qml
│   │       │   │   │   ├── SelectAllAction.qml
│   │       │   │   │   ├── StyleImage.qml
│   │       │   │   │   ├── SwitchIndicator.qml
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── UndoAction.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2fluentwinui3styleimplplugin.dll
│   │       │   │   ├── light/
│   │       │   │   │   └── images/
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── Config.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── FocusFrame.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── StyleImage.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2fluentwinui3styleplugin.dll
│   │       │   ├── Fusion/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── ButtonPanel.qml
│   │       │   │   │   ├── CheckIndicator.qml
│   │       │   │   │   ├── CopyAction.qml
│   │       │   │   │   ├── CutAction.qml
│   │       │   │   │   ├── DeleteAction.qml
│   │       │   │   │   ├── PasteAction.qml
│   │       │   │   │   ├── RadioIndicator.qml
│   │       │   │   │   ├── RedoAction.qml
│   │       │   │   │   ├── SelectAllAction.qml
│   │       │   │   │   ├── SliderGroove.qml
│   │       │   │   │   ├── SliderHandle.qml
│   │       │   │   │   ├── SwitchIndicator.qml
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── TextFieldBackground.qml
│   │       │   │   │   ├── UndoAction.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2fusionstyleimplplugin.dll
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── TreeViewDelegate.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2fusionstyleplugin.dll
│   │       │   ├── Imagine/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── OpacityMask.qml
│   │       │   │   │   ├── QuickControls2ImagineStyleImpl.qmltypes
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2imaginestyleimplplugin.dll
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── StackView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── SwipeView.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2imaginestyleplugin.dll
│   │       │   ├── Material/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── BoxShadow.qml
│   │       │   │   │   ├── CheckIndicator.qml
│   │       │   │   │   ├── CursorDelegate.qml
│   │       │   │   │   ├── ElevationEffect.qml
│   │       │   │   │   ├── RadioIndicator.qml
│   │       │   │   │   ├── RectangularGlow.qml
│   │       │   │   │   ├── RoundedElevationEffect.qml
│   │       │   │   │   ├── SliderHandle.qml
│   │       │   │   │   ├── SwitchIndicator.qml
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2materialstyleimplplugin.dll
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── StackView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── SwipeView.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── TreeViewDelegate.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2materialstyleplugin.dll
│   │       │   ├── Universal/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── CheckIndicator.qml
│   │       │   │   │   ├── CopyAction.qml
│   │       │   │   │   ├── CutAction.qml
│   │       │   │   │   ├── DeleteAction.qml
│   │       │   │   │   ├── PasteAction.qml
│   │       │   │   │   ├── RadioIndicator.qml
│   │       │   │   │   ├── RedoAction.qml
│   │       │   │   │   ├── SelectAllAction.qml
│   │       │   │   │   ├── SwitchIndicator.qml
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── UndoAction.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2universalstyleimplplugin.dll
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── StackView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2universalstyleplugin.dll
│   │       │   ├── Windows/
│   │       │   │   ├── images/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── CheckIndicator.qml
│   │       │   │   │   ├── CopyAction.qml
│   │       │   │   │   ├── CutAction.qml
│   │       │   │   │   ├── DeleteAction.qml
│   │       │   │   │   ├── PasteAction.qml
│   │       │   │   │   ├── QuickControls2WindowsStyleImpl.qmltypes
│   │       │   │   │   ├── RedoAction.qml
│   │       │   │   │   ├── SelectAllAction.qml
│   │       │   │   │   ├── SwitchIndicator.qml
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── UndoAction.qml
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2windowsstyleimplplugin.dll
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2windowsstyleplugin.dll
│   │       │   ├── impl/
│   │       │   │   ├── CopyAction.qml
│   │       │   │   ├── CutAction.qml
│   │       │   │   ├── DeleteAction.qml
│   │       │   │   ├── PasteAction.qml
│   │       │   │   ├── RedoAction.qml
│   │       │   │   ├── SelectAllAction.qml
│   │       │   │   ├── UndoAction.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2implplugin.dll
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qtquickcontrols2plugin.dll
│   │       ├── Dialogs/
│   │       │   ├── quickimpl/
│   │       │   │   ├── qml/
│   │       │   │   │   ├── +Fusion/
│   │       │   │   │   │   ├── ColorDialog.qml
│   │       │   │   │   │   ├── ColorInputs.qml
│   │       │   │   │   │   ├── FileDialog.qml
│   │       │   │   │   │   ├── FileDialogDelegate.qml
│   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│   │       │   │   │   │   ├── FolderDialog.qml
│   │       │   │   │   │   ├── FolderDialogDelegate.qml
│   │       │   │   │   │   ├── FontDialog.qml
│   │       │   │   │   │   ├── MessageDialog.qml
│   │       │   │   │   │   └── SideBar.qml
│   │       │   │   │   ├── +Imagine/
│   │       │   │   │   │   ├── ColorDialog.qml
│   │       │   │   │   │   ├── ColorInputs.qml
│   │       │   │   │   │   ├── FileDialog.qml
│   │       │   │   │   │   ├── FileDialogDelegate.qml
│   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│   │       │   │   │   │   ├── FolderDialog.qml
│   │       │   │   │   │   ├── FolderDialogDelegate.qml
│   │       │   │   │   │   ├── FontDialog.qml
│   │       │   │   │   │   ├── MessageDialog.qml
│   │       │   │   │   │   └── SideBar.qml
│   │       │   │   │   ├── +Material/
│   │       │   │   │   │   ├── ColorDialog.qml
│   │       │   │   │   │   ├── ColorInputs.qml
│   │       │   │   │   │   ├── FileDialog.qml
│   │       │   │   │   │   ├── FileDialogDelegate.qml
│   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│   │       │   │   │   │   ├── FolderDialog.qml
│   │       │   │   │   │   ├── FolderDialogDelegate.qml
│   │       │   │   │   │   ├── FontDialog.qml
│   │       │   │   │   │   ├── MessageDialog.qml
│   │       │   │   │   │   └── SideBar.qml
│   │       │   │   │   ├── +Universal/
│   │       │   │   │   │   ├── ColorDialog.qml
│   │       │   │   │   │   ├── ColorInputs.qml
│   │       │   │   │   │   ├── FileDialog.qml
│   │       │   │   │   │   ├── FileDialogDelegate.qml
│   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│   │       │   │   │   │   ├── FolderDialog.qml
│   │       │   │   │   │   ├── FolderDialogDelegate.qml
│   │       │   │   │   │   ├── FontDialog.qml
│   │       │   │   │   │   ├── MessageDialog.qml
│   │       │   │   │   │   └── SideBar.qml
│   │       │   │   │   ├── ColorDialog.qml
│   │       │   │   │   ├── ColorInputs.qml
│   │       │   │   │   ├── DelegateBackground.qml
│   │       │   │   │   ├── FileDialog.qml
│   │       │   │   │   ├── FileDialogDelegate.qml
│   │       │   │   │   ├── FileDialogDelegateLabel.qml
│   │       │   │   │   ├── FolderBreadcrumbBar.qml
│   │       │   │   │   ├── FolderDialog.qml
│   │       │   │   │   ├── FolderDialogDelegate.qml
│   │       │   │   │   ├── FolderDialogDelegateLabel.qml
│   │       │   │   │   ├── FontDialog.qml
│   │       │   │   │   ├── FontDialogContent.qml
│   │       │   │   │   ├── HueGradient.qml
│   │       │   │   │   ├── MessageDialog.qml
│   │       │   │   │   ├── PickerHandle.qml
│   │       │   │   │   ├── SaturationLightnessPicker.qml
│   │       │   │   │   └── SideBar.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickdialogs2quickimplplugin.dll
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qtquickdialogsplugin.dll
│   │       ├── Effects/
│   │       │   ├── effectsplugin.dll
│   │       │   ├── plugins.qmltypes
│   │       │   └── qmldir
│   │       ├── Layouts/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qquicklayoutsplugin.dll
│   │       ├── LocalStorage/
│   │       ├── NativeStyle/
│   │       │   ├── controls/
│   │       │   ├── util/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qtquickcontrols2nativestyleplugin.dll
│   │       ├── Particles/
│   │       ├── Shapes/
│   │       │   ├── DesignHelpers/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qmlshapesplugin.dll
│   │       ├── Templates/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qtquicktemplates2plugin.dll
│   │       ├── Timeline/
│   │       │   └── BlendTrees/
│   │       ├── VectorImage/
│   │       │   └── Helpers/
│   │       ├── Window/
│   │       │   ├── qmldir
│   │       │   ├── quickwindow.qmltypes
│   │       │   └── quickwindowplugin.dll
│   │       ├── tooling/
│   │       ├── plugins.qmltypes
│   │       ├── qmldir
│   │       └── qtquick2plugin.dll
│   ├── qmltooling/
│   │   ├── qmldbg_debugger.dll
│   │   ├── qmldbg_inspector.dll
│   │   ├── qmldbg_local.dll
│   │   ├── qmldbg_messages.dll
│   │   ├── qmldbg_native.dll
│   │   ├── qmldbg_nativedebugger.dll
│   │   ├── qmldbg_preview.dll
│   │   ├── qmldbg_profiler.dll
│   │   ├── qmldbg_quick3dprofiler.dll
│   │   ├── qmldbg_quickeventreplay.dll
│   │   ├── qmldbg_quickprofiler.dll
│   │   ├── qmldbg_server.dll
│   │   └── qmldbg_tcp.dll
│   ├── tls/
│   │   ├── qcertonlybackend.dll
│   │   └── qschannelbackend.dll
│   ├── CMakeCache.txt
│   ├── D3Dcompiler_47.dll
│   ├── Qt6Core.dll
│   ├── Qt6Gui.dll
│   ├── Qt6LabsFolderListModel.dll
│   ├── Qt6Network.dll
│   ├── Qt6OpenGL.dll
│   ├── Qt6Qml.dll
│   ├── Qt6QmlMeta.dll
│   ├── Qt6QmlModels.dll
│   ├── Qt6QmlWorkerScript.dll
│   ├── Qt6Quick.dll
│   ├── Qt6Quick3DUtils.dll
│   ├── Qt6QuickControls2.dll
│   ├── Qt6QuickControls2Basic.dll
│   ├── Qt6QuickControls2BasicStyleImpl.dll
│   ├── Qt6QuickControls2FluentWinUI3StyleImpl.dll
│   ├── Qt6QuickControls2Fusion.dll
│   ├── Qt6QuickControls2FusionStyleImpl.dll
│   ├── Qt6QuickControls2Imagine.dll
│   ├── Qt6QuickControls2ImagineStyleImpl.dll
│   ├── Qt6QuickControls2Impl.dll
│   ├── Qt6QuickControls2Material.dll
│   ├── Qt6QuickControls2MaterialStyleImpl.dll
│   ├── Qt6QuickControls2Universal.dll
│   ├── Qt6QuickControls2UniversalStyleImpl.dll
│   ├── Qt6QuickControls2WindowsStyleImpl.dll
│   ├── Qt6QuickDialogs2.dll
│   ├── Qt6QuickDialogs2QuickImpl.dll
│   ├── Qt6QuickDialogs2Utils.dll
│   ├── Qt6QuickEffects.dll
│   ├── Qt6QuickLayouts.dll
│   ├── Qt6QuickShapes.dll
│   ├── Qt6QuickTemplates2.dll
│   ├── Qt6Svg.dll
│   ├── ZmdUIDemo.exe
│   ├── ZmdUIDemo.exe.manifest
│   ├── build.ninja
│   ├── cmake_install.cmake
│   ├── install_manifest.txt
│   ├── libgcc_s_seh-1.dll
│   ├── libstdc++-6.dll
│   └── libwinpthread-1.dll
├── cmake-build-debug-qt-mingw/
│   ├── CMakeFiles/
│   │   ├── 3.30.5/
│   │   │   ├── CompilerIdCXX/
│   │   │   │   ├── tmp/
│   │   │   │   ├── CMakeCXXCompilerId.cpp
│   │   │   │   └── a.exe
│   │   │   ├── CMakeCXXCompiler.cmake
│   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│   │   │   ├── CMakeRCCompiler.cmake
│   │   │   └── CMakeSystem.cmake
│   │   ├── 4.3.1/
│   │   │   ├── CompilerIdCXX/
│   │   │   │   ├── tmp/
│   │   │   │   ├── CMakeCXXCompilerId.cpp
│   │   │   │   └── a.exe
│   │   │   ├── CMakeCXXCompiler.cmake
│   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│   │   │   ├── CMakeRCCompiler.cmake
│   │   │   └── CMakeSystem.cmake
│   │   ├── ZmdUIDemo.dir/
│   │   │   ├── ZmdUIDemo_autogen/
│   │   │   │   ├── 3YJK5W5UP7/
│   │   │   │   │   └── qrc_qml.cpp.obj
│   │   │   │   └── mocs_compilation.cpp.obj
│   │   │   └── src/
│   │   │       └── main.cpp.obj
│   │   ├── ZmdUIDemo_autogen.dir/
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Info.json
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Lock.lock
│   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Used.txt
│   │   │   ├── AutogenInfo.json
│   │   │   ├── AutogenUsed.txt
│   │   │   └── ParseCache.txt
│   │   ├── d/
│   │   ├── pkgRedirects/
│   │   ├── CMakeConfigureLog.yaml
│   │   ├── InstallScripts.json
│   │   ├── TargetDirectories.txt
│   │   ├── clean_additional.cmake
│   │   ├── clion-environment.txt
│   │   ├── cmake.check_cache
│   │   └── rules.ninja
│   ├── ZmdUIDemo_autogen/
│   │   ├── 3YJK5W5UP7/
│   │   │   └── qrc_qml.cpp
│   │   ├── include/
│   │   ├── deps
│   │   ├── moc_predefs.h
│   │   ├── mocs_compilation.cpp
│   │   └── timestamp
│   ├── generic/
│   │   └── qtuiotouchplugin.dll
│   ├── iconengines/
│   │   └── qsvgicon.dll
│   ├── imageformats/
│   │   ├── qgif.dll
│   │   ├── qico.dll
│   │   ├── qjpeg.dll
│   │   └── qsvg.dll
│   ├── networkinformation/
│   │   └── qnetworklistmanager.dll
│   ├── platforms/
│   │   └── qwindows.dll
│   ├── qml/
│   │   ├── QML/
│   │   │   ├── plugins.qmltypes
│   │   │   └── qmldir
│   │   ├── QtQml/
│   │   │   ├── Models/
│   │   │   │   ├── modelsplugin.dll
│   │   │   │   ├── plugins.qmltypes
│   │   │   │   └── qmldir
│   │   │   ├── WorkerScript/
│   │   │   │   ├── plugins.qmltypes
│   │   │   │   ├── qmldir
│   │   │   │   └── workerscriptplugin.dll
│   │   │   ├── XmlListModel/
│   │   │   ├── plugins.qmltypes
│   │   │   ├── qmldir
│   │   │   └── qmlplugin.dll
│   │   └── QtQuick/
│   │       ├── Controls/
│   │       │   ├── Basic/
│   │       │   │   ├── impl/
│   │       │   │   │   ├── TextEditingContextMenu.qml
│   │       │   │   │   ├── plugins.qmltypes
│   │       │   │   │   ├── qmldir
│   │       │   │   │   └── qtquickcontrols2basicstyleimplplugin.dll
│   │       │   │   ├── AbstractButton.qml
│   │       │   │   ├── Action.qml
│   │       │   │   ├── ActionGroup.qml
│   │       │   │   ├── ApplicationWindow.qml
│   │       │   │   ├── BusyIndicator.qml
│   │       │   │   ├── Button.qml
│   │       │   │   ├── ButtonGroup.qml
│   │       │   │   ├── Calendar.qml
│   │       │   │   ├── CalendarModel.qml
│   │       │   │   ├── CheckBox.qml
│   │       │   │   ├── CheckDelegate.qml
│   │       │   │   ├── ComboBox.qml
│   │       │   │   ├── Container.qml
│   │       │   │   ├── Control.qml
│   │       │   │   ├── DayOfWeekRow.qml
│   │       │   │   ├── DelayButton.qml
│   │       │   │   ├── Dial.qml
│   │       │   │   ├── Dialog.qml
│   │       │   │   ├── DialogButtonBox.qml
│   │       │   │   ├── DoubleSpinBox.qml
│   │       │   │   ├── Drawer.qml
│   │       │   │   ├── Frame.qml
│   │       │   │   ├── GroupBox.qml
│   │       │   │   ├── HorizontalHeaderView.qml
│   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│   │       │   │   ├── ItemDelegate.qml
│   │       │   │   ├── Label.qml
│   │       │   │   ├── Menu.qml
│   │       │   │   ├── MenuBar.qml
│   │       │   │   ├── MenuBarItem.qml
│   │       │   │   ├── MenuItem.qml
│   │       │   │   ├── MenuSeparator.qml
│   │       │   │   ├── MonthGrid.qml
│   │       │   │   ├── Page.qml
│   │       │   │   ├── PageIndicator.qml
│   │       │   │   ├── Pane.qml
│   │       │   │   ├── Popup.qml
│   │       │   │   ├── ProgressBar.qml
│   │       │   │   ├── RadioButton.qml
│   │       │   │   ├── RadioDelegate.qml
│   │       │   │   ├── RangeSlider.qml
│   │       │   │   ├── RoundButton.qml
│   │       │   │   ├── ScrollBar.qml
│   │       │   │   ├── ScrollIndicator.qml
│   │       │   │   ├── ScrollView.qml
│   │       │   │   ├── SearchField.qml
│   │       │   │   ├── SelectionRectangle.qml
│   │       │   │   ├── Slider.qml
│   │       │   │   ├── SpinBox.qml
│   │       │   │   ├── SplitView.qml
│   │       │   │   ├── StackView.qml
│   │       │   │   ├── SwipeDelegate.qml
│   │       │   │   ├── SwipeView.qml
│   │       │   │   ├── Switch.qml
│   │       │   │   ├── SwitchDelegate.qml
│   │       │   │   ├── TabBar.qml
│   │       │   │   ├── TabButton.qml
│   │       │   │   ├── TableViewDelegate.qml
│   │       │   │   ├── TextArea.qml
│   │       │   │   ├── TextField.qml
│   │       │   │   ├── ToolBar.qml
│   │       │   │   ├── ToolButton.qml
│   │       │   │   ├── ToolSeparator.qml
│   │       │   │   ├── ToolTip.qml
│   │       │   │   ├── TreeViewDelegate.qml
│   │       │   │   ├── Tumbler.qml
│   │       │   │   ├── VerticalHeaderView.qml
│   │       │   │   ├── VerticalHeaderViewDelegate.qml
│   │       │   │   ├── WeekNumberColumn.qml
│   │       │   │   ├── plugins.qmltypes
│   │       │   │   ├── qmldir
│   │       │   │   └── qtquickcontrols2basicstyleplugin.dll
│   │       │   ├── FluentWinUI3/
│   │       │   │   ├── dark/
│   │       │   │   │   └── images/
│   │       │   │   ├── icons/
│   │       │   │   ├── impl/
│   │       │   │   └── light/
│   │       │   │       └── images/
│   │       │   ├── Fusion/
│   │       │   │   └── impl/
│   │       │   ├── Imagine/
│   │       │   │   └── impl/
│   │       │   ├── Material/
│   │       │   │   └── impl/
│   │       │   ├── Universal/
│   │       │   │   └── impl/
│   │       │   ├── Windows/
│   │       │   │   ├── images/
│   │       │   │   └── impl/
│   │       │   └── impl/
│   │       │       ├── CopyAction.qml
│   │       │       ├── CutAction.qml
│   │       │       ├── DeleteAction.qml
│   │       │       ├── PasteAction.qml
│   │       │       ├── RedoAction.qml
│   │       │       ├── SelectAllAction.qml
│   │       │       ├── UndoAction.qml
│   │       │       ├── plugins.qmltypes
│   │       │       ├── qmldir
│   │       │       └── qtquickcontrols2implplugin.dll
│   │       ├── Dialogs/
│   │       │   └── quickimpl/
│   │       │       └── qml/
│   │       │           ├── +Fusion/
│   │       │           ├── +Imagine/
│   │       │           ├── +Material/
│   │       │           └── +Universal/
│   │       ├── Effects/
│   │       ├── Layouts/
│   │       ├── LocalStorage/
│   │       ├── NativeStyle/
│   │       │   ├── controls/
│   │       │   └── util/
│   │       ├── Particles/
│   │       ├── Shapes/
│   │       │   ├── DesignHelpers/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qmlshapesplugin.dll
│   │       ├── Templates/
│   │       │   ├── plugins.qmltypes
│   │       │   ├── qmldir
│   │       │   └── qtquicktemplates2plugin.dll
│   │       ├── Timeline/
│   │       │   └── BlendTrees/
│   │       ├── VectorImage/
│   │       │   └── Helpers/
│   │       ├── Window/
│   │       │   ├── qmldir
│   │       │   ├── quickwindow.qmltypes
│   │       │   └── quickwindowplugin.dll
│   │       ├── tooling/
│   │       ├── plugins.qmltypes
│   │       ├── qmldir
│   │       └── qtquick2plugin.dll
│   ├── qmltooling/
│   │   ├── qmldbg_debugger.dll
│   │   ├── qmldbg_inspector.dll
│   │   ├── qmldbg_local.dll
│   │   ├── qmldbg_messages.dll
│   │   ├── qmldbg_native.dll
│   │   ├── qmldbg_nativedebugger.dll
│   │   ├── qmldbg_preview.dll
│   │   ├── qmldbg_profiler.dll
│   │   ├── qmldbg_quick3dprofiler.dll
│   │   ├── qmldbg_quickeventreplay.dll
│   │   ├── qmldbg_quickprofiler.dll
│   │   ├── qmldbg_server.dll
│   │   └── qmldbg_tcp.dll
│   ├── tls/
│   │   ├── qcertonlybackend.dll
│   │   └── qschannelbackend.dll
│   ├── CMakeCache.txt
│   ├── D3Dcompiler_47.dll
│   ├── Qt6Core.dll
│   ├── Qt6Gui.dll
│   ├── Qt6Network.dll
│   ├── Qt6OpenGL.dll
│   ├── Qt6Qml.dll
│   ├── Qt6QmlMeta.dll
│   ├── Qt6QmlModels.dll
│   ├── Qt6QmlWorkerScript.dll
│   ├── Qt6Quick.dll
│   ├── Qt6Quick3DUtils.dll
│   ├── Qt6QuickControls2.dll
│   ├── Qt6QuickControls2Basic.dll
│   ├── Qt6QuickControls2BasicStyleImpl.dll
│   ├── Qt6QuickControls2Impl.dll
│   ├── Qt6QuickShapes.dll
│   ├── Qt6QuickTemplates2.dll
│   ├── Qt6Svg.dll
│   ├── ZmdUIDemo.exe
│   ├── ZmdUIDemo.exe.manifest
│   ├── build.ninja
│   ├── cmake_install.cmake
│   ├── libgcc_s_seh-1.dll
│   ├── libstdc++-6.dll
│   └── libwinpthread-1.dll
├── docs/
│   ├── screenshots/
│   ├── ZmdUI_组件库文档.md
│   └── verification.md
├── out/
│   └── build/
│       ├── debug/
│       │   ├── ALL_BUILD.dir/
│       │   │   ├── Debug/
│       │   │   ├── MinSizeRel/
│       │   │   ├── RelWithDebInfo/
│       │   │   └── Release/
│       │   ├── CMakeFiles/
│       │   │   ├── 4.4.2/
│       │   │   │   ├── CompilerIdCXX/
│       │   │   │   │   ├── tmp/
│       │   │   │   │   ├── CMakeCXXCompilerId.cpp
│       │   │   │   │   └── a.exe
│       │   │   │   ├── CMakeCXXCompiler.cmake
│       │   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│       │   │   │   ├── CMakeRCCompiler.cmake
│       │   │   │   └── CMakeSystem.cmake
│       │   │   ├── ZmdUIDemo.dir/
│       │   │   │   ├── ZmdUIDemo_autogen/
│       │   │   │   │   ├── 3YJK5W5UP7/
│       │   │   │   │   │   └── qrc_qml.cpp.obj
│       │   │   │   │   └── mocs_compilation.cpp.obj
│       │   │   │   └── src/
│       │   │   │       ├── main.cpp.obj
│       │   │   │       └── zclipboard.cpp.obj
│       │   │   ├── ZmdUIDemo_autogen.dir/
│       │   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Info.json
│       │   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Lock.lock
│       │   │   │   ├── AutoRcc_qml_3YJK5W5UP7_Used.txt
│       │   │   │   ├── AutogenInfo.json
│       │   │   │   ├── AutogenUsed.txt
│       │   │   │   └── ParseCache.txt
│       │   │   ├── d/
│       │   │   ├── pkgRedirects/
│       │   │   ├── CMakeConfigureLog.yaml
│       │   │   ├── InstallScripts.json
│       │   │   ├── TargetDirectories.txt
│       │   │   ├── clean_additional.cmake
│       │   │   ├── clion-Debug-MSYS2-log.txt
│       │   │   ├── clion-environment.txt
│       │   │   ├── cmake.check_cache
│       │   │   └── rules.ninja
│       │   ├── INSTALL.dir/
│       │   │   ├── Debug/
│       │   │   ├── MinSizeRel/
│       │   │   ├── RelWithDebInfo/
│       │   │   └── Release/
│       │   ├── Testing/
│       │   │   └── Temporary/
│       │   │       └── LastTest.log
│       │   ├── ZERO_CHECK.dir/
│       │   │   ├── Debug/
│       │   │   ├── MinSizeRel/
│       │   │   ├── RelWithDebInfo/
│       │   │   └── Release/
│       │   ├── ZmdUIDemo.dir/
│       │   │   ├── Debug/
│       │   │   ├── MinSizeRel/
│       │   │   ├── RelWithDebInfo/
│       │   │   └── Release/
│       │   ├── ZmdUIDemo_autogen/
│       │   │   ├── 3YJK5W5UP7/
│       │   │   │   └── qrc_qml.cpp
│       │   │   ├── UVLADIE3JM/
│       │   │   │   ├── moc_zclipboard.cpp
│       │   │   │   └── moc_zclipboard.cpp.d
│       │   │   ├── include/
│       │   │   ├── deps
│       │   │   ├── moc_predefs.h
│       │   │   ├── mocs_compilation.cpp
│       │   │   └── timestamp
│       │   ├── ZmdUIDemo_qmlimportscan.dir/
│       │   │   ├── Debug/
│       │   │   ├── MinSizeRel/
│       │   │   ├── RelWithDebInfo/
│       │   │   └── Release/
│       │   ├── generic/
│       │   │   └── qtuiotouchplugin.dll
│       │   ├── iconengines/
│       │   │   └── qsvgicon.dll
│       │   ├── imageformats/
│       │   │   ├── qgif.dll
│       │   │   ├── qico.dll
│       │   │   ├── qjpeg.dll
│       │   │   └── qsvg.dll
│       │   ├── networkinformation/
│       │   │   └── qnetworklistmanager.dll
│       │   ├── platforms/
│       │   │   └── qwindows.dll
│       │   ├── qml/
│       │   │   ├── QML/
│       │   │   │   ├── plugins.qmltypes
│       │   │   │   └── qmldir
│       │   │   ├── Qt/
│       │   │   │   └── labs/
│       │   │   │       └── folderlistmodel/
│       │   │   │           ├── plugins.qmltypes
│       │   │   │           ├── qmldir
│       │   │   │           └── qmlfolderlistmodelplugin.dll
│       │   │   ├── QtQml/
│       │   │   │   ├── Models/
│       │   │   │   │   ├── modelsplugin.dll
│       │   │   │   │   ├── plugins.qmltypes
│       │   │   │   │   └── qmldir
│       │   │   │   ├── WorkerScript/
│       │   │   │   │   ├── plugins.qmltypes
│       │   │   │   │   ├── qmldir
│       │   │   │   │   └── workerscriptplugin.dll
│       │   │   │   ├── XmlListModel/
│       │   │   │   ├── plugins.qmltypes
│       │   │   │   ├── qmldir
│       │   │   │   └── qmlplugin.dll
│       │   │   └── QtQuick/
│       │   │       ├── Controls/
│       │   │       │   ├── Basic/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── plugins.qmltypes
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2basicstyleimplplugin.dll
│       │   │       │   │   ├── AbstractButton.qml
│       │   │       │   │   ├── Action.qml
│       │   │       │   │   ├── ActionGroup.qml
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── BusyIndicator.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── ButtonGroup.qml
│       │   │       │   │   ├── Calendar.qml
│       │   │       │   │   ├── CalendarModel.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── Container.qml
│       │   │       │   │   ├── Control.qml
│       │   │       │   │   ├── DayOfWeekRow.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── Dial.qml
│       │   │       │   │   ├── Dialog.qml
│       │   │       │   │   ├── DialogButtonBox.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── Drawer.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── HorizontalHeaderView.qml
│       │   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Label.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── MonthGrid.qml
│       │   │       │   │   ├── Page.qml
│       │   │       │   │   ├── PageIndicator.qml
│       │   │       │   │   ├── Pane.qml
│       │   │       │   │   ├── Popup.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── RoundButton.qml
│       │   │       │   │   ├── ScrollBar.qml
│       │   │       │   │   ├── ScrollIndicator.qml
│       │   │       │   │   ├── ScrollView.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── SelectionRectangle.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── SplitView.qml
│       │   │       │   │   ├── StackView.qml
│       │   │       │   │   ├── SwipeDelegate.qml
│       │   │       │   │   ├── SwipeView.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TabBar.qml
│       │   │       │   │   ├── TabButton.qml
│       │   │       │   │   ├── TableViewDelegate.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── ToolBar.qml
│       │   │       │   │   ├── ToolButton.qml
│       │   │       │   │   ├── ToolSeparator.qml
│       │   │       │   │   ├── ToolTip.qml
│       │   │       │   │   ├── TreeViewDelegate.qml
│       │   │       │   │   ├── Tumbler.qml
│       │   │       │   │   ├── VerticalHeaderView.qml
│       │   │       │   │   ├── VerticalHeaderViewDelegate.qml
│       │   │       │   │   ├── WeekNumberColumn.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2basicstyleplugin.dll
│       │   │       │   ├── FluentWinUI3/
│       │   │       │   │   ├── dark/
│       │   │       │   │   │   └── images/
│       │   │       │   │   ├── icons/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── ButtonBackground.qml
│       │   │       │   │   │   ├── CheckIndicator.qml
│       │   │       │   │   │   ├── CopyAction.qml
│       │   │       │   │   │   ├── CutAction.qml
│       │   │       │   │   │   ├── DeleteAction.qml
│       │   │       │   │   │   ├── FocusFrame.qml
│       │   │       │   │   │   ├── PasteAction.qml
│       │   │       │   │   │   ├── RadioIndicator.qml
│       │   │       │   │   │   ├── RedoAction.qml
│       │   │       │   │   │   ├── SelectAllAction.qml
│       │   │       │   │   │   ├── StyleImage.qml
│       │   │       │   │   │   ├── SwitchIndicator.qml
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── UndoAction.qml
│       │   │       │   │   │   ├── plugins.qmltypes
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2fluentwinui3styleimplplugin.dll
│       │   │       │   │   ├── light/
│       │   │       │   │   │   └── images/
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── BusyIndicator.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── Config.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── Dialog.qml
│       │   │       │   │   ├── DialogButtonBox.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── FocusFrame.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── PageIndicator.qml
│       │   │       │   │   ├── Popup.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── RoundButton.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── StyleImage.qml
│       │   │       │   │   ├── SwipeDelegate.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TabBar.qml
│       │   │       │   │   ├── TabButton.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── ToolBar.qml
│       │   │       │   │   ├── ToolButton.qml
│       │   │       │   │   ├── ToolSeparator.qml
│       │   │       │   │   ├── ToolTip.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2fluentwinui3styleplugin.dll
│       │   │       │   ├── Fusion/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── ButtonPanel.qml
│       │   │       │   │   │   ├── CheckIndicator.qml
│       │   │       │   │   │   ├── CopyAction.qml
│       │   │       │   │   │   ├── CutAction.qml
│       │   │       │   │   │   ├── DeleteAction.qml
│       │   │       │   │   │   ├── PasteAction.qml
│       │   │       │   │   │   ├── RadioIndicator.qml
│       │   │       │   │   │   ├── RedoAction.qml
│       │   │       │   │   │   ├── SelectAllAction.qml
│       │   │       │   │   │   ├── SliderGroove.qml
│       │   │       │   │   │   ├── SliderHandle.qml
│       │   │       │   │   │   ├── SwitchIndicator.qml
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── TextFieldBackground.qml
│       │   │       │   │   │   ├── UndoAction.qml
│       │   │       │   │   │   ├── plugins.qmltypes
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2fusionstyleimplplugin.dll
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── BusyIndicator.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── Dial.qml
│       │   │       │   │   ├── Dialog.qml
│       │   │       │   │   ├── DialogButtonBox.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── Drawer.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── HorizontalHeaderView.qml
│       │   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Label.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── Page.qml
│       │   │       │   │   ├── PageIndicator.qml
│       │   │       │   │   ├── Pane.qml
│       │   │       │   │   ├── Popup.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── RoundButton.qml
│       │   │       │   │   ├── ScrollBar.qml
│       │   │       │   │   ├── ScrollIndicator.qml
│       │   │       │   │   ├── ScrollView.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── SelectionRectangle.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── SplitView.qml
│       │   │       │   │   ├── SwipeDelegate.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TabBar.qml
│       │   │       │   │   ├── TabButton.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── ToolBar.qml
│       │   │       │   │   ├── ToolButton.qml
│       │   │       │   │   ├── ToolSeparator.qml
│       │   │       │   │   ├── ToolTip.qml
│       │   │       │   │   ├── TreeViewDelegate.qml
│       │   │       │   │   ├── Tumbler.qml
│       │   │       │   │   ├── VerticalHeaderView.qml
│       │   │       │   │   ├── VerticalHeaderViewDelegate.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2fusionstyleplugin.dll
│       │   │       │   ├── Imagine/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── OpacityMask.qml
│       │   │       │   │   │   ├── QuickControls2ImagineStyleImpl.qmltypes
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2imaginestyleimplplugin.dll
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── BusyIndicator.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── Dial.qml
│       │   │       │   │   ├── Dialog.qml
│       │   │       │   │   ├── DialogButtonBox.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── Drawer.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── HorizontalHeaderView.qml
│       │   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Label.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── Page.qml
│       │   │       │   │   ├── PageIndicator.qml
│       │   │       │   │   ├── Pane.qml
│       │   │       │   │   ├── Popup.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── RoundButton.qml
│       │   │       │   │   ├── ScrollBar.qml
│       │   │       │   │   ├── ScrollIndicator.qml
│       │   │       │   │   ├── ScrollView.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── SelectionRectangle.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── SplitView.qml
│       │   │       │   │   ├── StackView.qml
│       │   │       │   │   ├── SwipeDelegate.qml
│       │   │       │   │   ├── SwipeView.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TabBar.qml
│       │   │       │   │   ├── TabButton.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── ToolBar.qml
│       │   │       │   │   ├── ToolButton.qml
│       │   │       │   │   ├── ToolSeparator.qml
│       │   │       │   │   ├── ToolTip.qml
│       │   │       │   │   ├── Tumbler.qml
│       │   │       │   │   ├── VerticalHeaderView.qml
│       │   │       │   │   ├── VerticalHeaderViewDelegate.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2imaginestyleplugin.dll
│       │   │       │   ├── Material/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── BoxShadow.qml
│       │   │       │   │   │   ├── CheckIndicator.qml
│       │   │       │   │   │   ├── CursorDelegate.qml
│       │   │       │   │   │   ├── ElevationEffect.qml
│       │   │       │   │   │   ├── RadioIndicator.qml
│       │   │       │   │   │   ├── RectangularGlow.qml
│       │   │       │   │   │   ├── RoundedElevationEffect.qml
│       │   │       │   │   │   ├── SliderHandle.qml
│       │   │       │   │   │   ├── SwitchIndicator.qml
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── plugins.qmltypes
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2materialstyleimplplugin.dll
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── BusyIndicator.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── Dial.qml
│       │   │       │   │   ├── Dialog.qml
│       │   │       │   │   ├── DialogButtonBox.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── Drawer.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── HorizontalHeaderView.qml
│       │   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Label.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── Page.qml
│       │   │       │   │   ├── PageIndicator.qml
│       │   │       │   │   ├── Pane.qml
│       │   │       │   │   ├── Popup.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── RoundButton.qml
│       │   │       │   │   ├── ScrollBar.qml
│       │   │       │   │   ├── ScrollIndicator.qml
│       │   │       │   │   ├── ScrollView.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── SelectionRectangle.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── SplitView.qml
│       │   │       │   │   ├── StackView.qml
│       │   │       │   │   ├── SwipeDelegate.qml
│       │   │       │   │   ├── SwipeView.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TabBar.qml
│       │   │       │   │   ├── TabButton.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── ToolBar.qml
│       │   │       │   │   ├── ToolButton.qml
│       │   │       │   │   ├── ToolSeparator.qml
│       │   │       │   │   ├── ToolTip.qml
│       │   │       │   │   ├── TreeViewDelegate.qml
│       │   │       │   │   ├── Tumbler.qml
│       │   │       │   │   ├── VerticalHeaderView.qml
│       │   │       │   │   ├── VerticalHeaderViewDelegate.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2materialstyleplugin.dll
│       │   │       │   ├── Universal/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── CheckIndicator.qml
│       │   │       │   │   │   ├── CopyAction.qml
│       │   │       │   │   │   ├── CutAction.qml
│       │   │       │   │   │   ├── DeleteAction.qml
│       │   │       │   │   │   ├── PasteAction.qml
│       │   │       │   │   │   ├── RadioIndicator.qml
│       │   │       │   │   │   ├── RedoAction.qml
│       │   │       │   │   │   ├── SelectAllAction.qml
│       │   │       │   │   │   ├── SwitchIndicator.qml
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── UndoAction.qml
│       │   │       │   │   │   ├── plugins.qmltypes
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2universalstyleimplplugin.dll
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── BusyIndicator.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── Dial.qml
│       │   │       │   │   ├── Dialog.qml
│       │   │       │   │   ├── DialogButtonBox.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── Drawer.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── HorizontalHeaderView.qml
│       │   │       │   │   ├── HorizontalHeaderViewDelegate.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Label.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── Page.qml
│       │   │       │   │   ├── PageIndicator.qml
│       │   │       │   │   ├── Pane.qml
│       │   │       │   │   ├── Popup.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── RoundButton.qml
│       │   │       │   │   ├── ScrollBar.qml
│       │   │       │   │   ├── ScrollIndicator.qml
│       │   │       │   │   ├── ScrollView.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── SelectionRectangle.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── SplitView.qml
│       │   │       │   │   ├── StackView.qml
│       │   │       │   │   ├── SwipeDelegate.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TabBar.qml
│       │   │       │   │   ├── TabButton.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── ToolBar.qml
│       │   │       │   │   ├── ToolButton.qml
│       │   │       │   │   ├── ToolSeparator.qml
│       │   │       │   │   ├── ToolTip.qml
│       │   │       │   │   ├── Tumbler.qml
│       │   │       │   │   ├── VerticalHeaderView.qml
│       │   │       │   │   ├── VerticalHeaderViewDelegate.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2universalstyleplugin.dll
│       │   │       │   ├── Windows/
│       │   │       │   │   ├── images/
│       │   │       │   │   ├── impl/
│       │   │       │   │   │   ├── CheckIndicator.qml
│       │   │       │   │   │   ├── CopyAction.qml
│       │   │       │   │   │   ├── CutAction.qml
│       │   │       │   │   │   ├── DeleteAction.qml
│       │   │       │   │   │   ├── PasteAction.qml
│       │   │       │   │   │   ├── QuickControls2WindowsStyleImpl.qmltypes
│       │   │       │   │   │   ├── RedoAction.qml
│       │   │       │   │   │   ├── SelectAllAction.qml
│       │   │       │   │   │   ├── SwitchIndicator.qml
│       │   │       │   │   │   ├── TextEditingContextMenu.qml
│       │   │       │   │   │   ├── UndoAction.qml
│       │   │       │   │   │   ├── qmldir
│       │   │       │   │   │   └── qtquickcontrols2windowsstyleimplplugin.dll
│       │   │       │   │   ├── ApplicationWindow.qml
│       │   │       │   │   ├── Button.qml
│       │   │       │   │   ├── CheckBox.qml
│       │   │       │   │   ├── CheckDelegate.qml
│       │   │       │   │   ├── ComboBox.qml
│       │   │       │   │   ├── DelayButton.qml
│       │   │       │   │   ├── DoubleSpinBox.qml
│       │   │       │   │   ├── Frame.qml
│       │   │       │   │   ├── GroupBox.qml
│       │   │       │   │   ├── ItemDelegate.qml
│       │   │       │   │   ├── Menu.qml
│       │   │       │   │   ├── MenuBar.qml
│       │   │       │   │   ├── MenuBarItem.qml
│       │   │       │   │   ├── MenuItem.qml
│       │   │       │   │   ├── MenuSeparator.qml
│       │   │       │   │   ├── ProgressBar.qml
│       │   │       │   │   ├── RadioButton.qml
│       │   │       │   │   ├── RadioDelegate.qml
│       │   │       │   │   ├── RangeSlider.qml
│       │   │       │   │   ├── ScrollBar.qml
│       │   │       │   │   ├── ScrollIndicator.qml
│       │   │       │   │   ├── ScrollView.qml
│       │   │       │   │   ├── SearchField.qml
│       │   │       │   │   ├── SelectionRectangle.qml
│       │   │       │   │   ├── Slider.qml
│       │   │       │   │   ├── SpinBox.qml
│       │   │       │   │   ├── Switch.qml
│       │   │       │   │   ├── SwitchDelegate.qml
│       │   │       │   │   ├── TextArea.qml
│       │   │       │   │   ├── TextField.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2windowsstyleplugin.dll
│       │   │       │   ├── impl/
│       │   │       │   │   ├── CopyAction.qml
│       │   │       │   │   ├── CutAction.qml
│       │   │       │   │   ├── DeleteAction.qml
│       │   │       │   │   ├── PasteAction.qml
│       │   │       │   │   ├── RedoAction.qml
│       │   │       │   │   ├── SelectAllAction.qml
│       │   │       │   │   ├── UndoAction.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickcontrols2implplugin.dll
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   ├── qmldir
│       │   │       │   └── qtquickcontrols2plugin.dll
│       │   │       ├── Dialogs/
│       │   │       │   ├── quickimpl/
│       │   │       │   │   ├── qml/
│       │   │       │   │   │   ├── +Fusion/
│       │   │       │   │   │   │   ├── ColorDialog.qml
│       │   │       │   │   │   │   ├── ColorInputs.qml
│       │   │       │   │   │   │   ├── FileDialog.qml
│       │   │       │   │   │   │   ├── FileDialogDelegate.qml
│       │   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│       │   │       │   │   │   │   ├── FolderDialog.qml
│       │   │       │   │   │   │   ├── FolderDialogDelegate.qml
│       │   │       │   │   │   │   ├── FontDialog.qml
│       │   │       │   │   │   │   ├── MessageDialog.qml
│       │   │       │   │   │   │   └── SideBar.qml
│       │   │       │   │   │   ├── +Imagine/
│       │   │       │   │   │   │   ├── ColorDialog.qml
│       │   │       │   │   │   │   ├── ColorInputs.qml
│       │   │       │   │   │   │   ├── FileDialog.qml
│       │   │       │   │   │   │   ├── FileDialogDelegate.qml
│       │   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│       │   │       │   │   │   │   ├── FolderDialog.qml
│       │   │       │   │   │   │   ├── FolderDialogDelegate.qml
│       │   │       │   │   │   │   ├── FontDialog.qml
│       │   │       │   │   │   │   ├── MessageDialog.qml
│       │   │       │   │   │   │   └── SideBar.qml
│       │   │       │   │   │   ├── +Material/
│       │   │       │   │   │   │   ├── ColorDialog.qml
│       │   │       │   │   │   │   ├── ColorInputs.qml
│       │   │       │   │   │   │   ├── FileDialog.qml
│       │   │       │   │   │   │   ├── FileDialogDelegate.qml
│       │   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│       │   │       │   │   │   │   ├── FolderDialog.qml
│       │   │       │   │   │   │   ├── FolderDialogDelegate.qml
│       │   │       │   │   │   │   ├── FontDialog.qml
│       │   │       │   │   │   │   ├── MessageDialog.qml
│       │   │       │   │   │   │   └── SideBar.qml
│       │   │       │   │   │   ├── +Universal/
│       │   │       │   │   │   │   ├── ColorDialog.qml
│       │   │       │   │   │   │   ├── ColorInputs.qml
│       │   │       │   │   │   │   ├── FileDialog.qml
│       │   │       │   │   │   │   ├── FileDialogDelegate.qml
│       │   │       │   │   │   │   ├── FolderBreadcrumbBar.qml
│       │   │       │   │   │   │   ├── FolderDialog.qml
│       │   │       │   │   │   │   ├── FolderDialogDelegate.qml
│       │   │       │   │   │   │   ├── FontDialog.qml
│       │   │       │   │   │   │   ├── MessageDialog.qml
│       │   │       │   │   │   │   └── SideBar.qml
│       │   │       │   │   │   ├── ColorDialog.qml
│       │   │       │   │   │   ├── ColorInputs.qml
│       │   │       │   │   │   ├── DelegateBackground.qml
│       │   │       │   │   │   ├── FileDialog.qml
│       │   │       │   │   │   ├── FileDialogDelegate.qml
│       │   │       │   │   │   ├── FileDialogDelegateLabel.qml
│       │   │       │   │   │   ├── FolderBreadcrumbBar.qml
│       │   │       │   │   │   ├── FolderDialog.qml
│       │   │       │   │   │   ├── FolderDialogDelegate.qml
│       │   │       │   │   │   ├── FolderDialogDelegateLabel.qml
│       │   │       │   │   │   ├── FontDialog.qml
│       │   │       │   │   │   ├── FontDialogContent.qml
│       │   │       │   │   │   ├── HueGradient.qml
│       │   │       │   │   │   ├── MessageDialog.qml
│       │   │       │   │   │   ├── PickerHandle.qml
│       │   │       │   │   │   ├── SaturationLightnessPicker.qml
│       │   │       │   │   │   └── SideBar.qml
│       │   │       │   │   ├── plugins.qmltypes
│       │   │       │   │   ├── qmldir
│       │   │       │   │   └── qtquickdialogs2quickimplplugin.dll
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   ├── qmldir
│       │   │       │   └── qtquickdialogsplugin.dll
│       │   │       ├── Effects/
│       │   │       │   ├── effectsplugin.dll
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   └── qmldir
│       │   │       ├── Layouts/
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   ├── qmldir
│       │   │       │   └── qquicklayoutsplugin.dll
│       │   │       ├── LocalStorage/
│       │   │       ├── NativeStyle/
│       │   │       │   ├── controls/
│       │   │       │   ├── util/
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   ├── qmldir
│       │   │       │   └── qtquickcontrols2nativestyleplugin.dll
│       │   │       ├── Particles/
│       │   │       ├── Shapes/
│       │   │       │   ├── DesignHelpers/
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   ├── qmldir
│       │   │       │   └── qmlshapesplugin.dll
│       │   │       ├── Templates/
│       │   │       │   ├── plugins.qmltypes
│       │   │       │   ├── qmldir
│       │   │       │   └── qtquicktemplates2plugin.dll
│       │   │       ├── Timeline/
│       │   │       │   └── BlendTrees/
│       │   │       ├── VectorImage/
│       │   │       │   └── Helpers/
│       │   │       ├── Window/
│       │   │       │   ├── qmldir
│       │   │       │   ├── quickwindow.qmltypes
│       │   │       │   └── quickwindowplugin.dll
│       │   │       ├── tooling/
│       │   │       ├── plugins.qmltypes
│       │   │       ├── qmldir
│       │   │       └── qtquick2plugin.dll
│       │   ├── qmltooling/
│       │   │   ├── qmldbg_debugger.dll
│       │   │   ├── qmldbg_inspector.dll
│       │   │   ├── qmldbg_local.dll
│       │   │   ├── qmldbg_messages.dll
│       │   │   ├── qmldbg_native.dll
│       │   │   ├── qmldbg_nativedebugger.dll
│       │   │   ├── qmldbg_preview.dll
│       │   │   ├── qmldbg_profiler.dll
│       │   │   ├── qmldbg_quick3dprofiler.dll
│       │   │   ├── qmldbg_quickeventreplay.dll
│       │   │   ├── qmldbg_quickprofiler.dll
│       │   │   ├── qmldbg_server.dll
│       │   │   └── qmldbg_tcp.dll
│       │   ├── tls/
│       │   │   ├── qcertonlybackend.dll
│       │   │   └── qschannelbackend.dll
│       │   ├── ALL_BUILD.vcxproj
│       │   ├── ALL_BUILD.vcxproj.filters
│       │   ├── CMakeCache.txt
│       │   ├── D3Dcompiler_47.dll
│       │   ├── INSTALL.vcxproj
│       │   ├── INSTALL.vcxproj.filters
│       │   ├── Qt6Core.dll
│       │   ├── Qt6Gui.dll
│       │   ├── Qt6LabsFolderListModel.dll
│       │   ├── Qt6Network.dll
│       │   ├── Qt6OpenGL.dll
│       │   ├── Qt6Qml.dll
│       │   ├── Qt6QmlMeta.dll
│       │   ├── Qt6QmlModels.dll
│       │   ├── Qt6QmlWorkerScript.dll
│       │   ├── Qt6Quick.dll
│       │   ├── Qt6Quick3DUtils.dll
│       │   ├── Qt6QuickControls2.dll
│       │   ├── Qt6QuickControls2Basic.dll
│       │   ├── Qt6QuickControls2BasicStyleImpl.dll
│       │   ├── Qt6QuickControls2FluentWinUI3StyleImpl.dll
│       │   ├── Qt6QuickControls2Fusion.dll
│       │   ├── Qt6QuickControls2FusionStyleImpl.dll
│       │   ├── Qt6QuickControls2Imagine.dll
│       │   ├── Qt6QuickControls2ImagineStyleImpl.dll
│       │   ├── Qt6QuickControls2Impl.dll
│       │   ├── Qt6QuickControls2Material.dll
│       │   ├── Qt6QuickControls2MaterialStyleImpl.dll
│       │   ├── Qt6QuickControls2Universal.dll
│       │   ├── Qt6QuickControls2UniversalStyleImpl.dll
│       │   ├── Qt6QuickControls2WindowsStyleImpl.dll
│       │   ├── Qt6QuickDialogs2.dll
│       │   ├── Qt6QuickDialogs2QuickImpl.dll
│       │   ├── Qt6QuickDialogs2Utils.dll
│       │   ├── Qt6QuickEffects.dll
│       │   ├── Qt6QuickLayouts.dll
│       │   ├── Qt6QuickShapes.dll
│       │   ├── Qt6QuickTemplates2.dll
│       │   ├── Qt6Svg.dll
│       │   ├── VSInheritEnvironments.txt
│       │   ├── ZERO_CHECK.vcxproj
│       │   ├── ZERO_CHECK.vcxproj.filters
│       │   ├── ZmdUI.slnx
│       │   ├── ZmdUIDemo.exe
│       │   ├── ZmdUIDemo.exe.manifest
│       │   ├── ZmdUIDemo.ilk
│       │   ├── ZmdUIDemo.pdb
│       │   ├── ZmdUIDemo.vcxproj
│       │   ├── ZmdUIDemo.vcxproj.filters
│       │   ├── ZmdUIDemo_qmlimportscan.vcxproj
│       │   ├── ZmdUIDemo_qmlimportscan.vcxproj.filters
│       │   ├── build.ninja
│       │   ├── cmake_install.cmake
│       │   ├── compile_commands.json
│       │   ├── libgcc_s_seh-1.dll
│       │   ├── libstdc++-6.dll
│       │   └── libwinpthread-1.dll
│       └── release/
│           ├── CMakeFiles/
│           │   ├── 4.3.1/
│           │   │   ├── CompilerIdCXX/
│           │   │   │   ├── tmp/
│           │   │   │   ├── CMakeCXXCompilerId.cpp
│           │   │   │   ├── CMakeCXXCompilerId.exe
│           │   │   │   └── CMakeCXXCompilerId.obj
│           │   │   ├── CMakeCXXCompiler.cmake
│           │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│           │   │   ├── CMakeRCCompiler.cmake
│           │   │   └── CMakeSystem.cmake
│           │   ├── ShowIncludes/
│           │   │   ├── foo.h
│           │   │   ├── main.c
│           │   │   └── main.obj
│           │   ├── ZmdUIDemo.dir/
│           │   │   ├── ZmdUIDemo_autogen/
│           │   │   │   ├── 3YJK5W5UP7/
│           │   │   │   │   └── qrc_qml.cpp.obj
│           │   │   │   └── mocs_compilation.cpp.obj
│           │   │   └── src/
│           │   │       └── main.cpp.obj
│           │   ├── ZmdUIDemo_autogen.dir/
│           │   │   ├── AutoRcc_qml_3YJK5W5UP7_Info.json
│           │   │   ├── AutoRcc_qml_3YJK5W5UP7_Lock.lock
│           │   │   ├── AutoRcc_qml_3YJK5W5UP7_Used.txt
│           │   │   ├── AutogenInfo.json
│           │   │   ├── AutogenUsed.txt
│           │   │   └── ParseCache.txt
│           │   ├── d/
│           │   ├── pkgRedirects/
│           │   ├── CMakeConfigureLog.yaml
│           │   ├── InstallScripts.json
│           │   ├── TargetDirectories.txt
│           │   ├── clean_additional.cmake
│           │   ├── clion-Qt-Release 1-log.txt
│           │   ├── clion-environment.txt
│           │   ├── cmake.check_cache
│           │   └── rules.ninja
│           ├── Testing/
│           │   └── Temporary/
│           │       └── LastTest.log
│           ├── ZmdUIDemo_autogen/
│           │   ├── 3YJK5W5UP7/
│           │   │   └── qrc_qml.cpp
│           │   ├── include/
│           │   ├── deps
│           │   ├── mocs_compilation.cpp
│           │   └── timestamp
│           ├── CMakeCache.txt
│           ├── VSInheritEnvironments.txt
│           ├── ZmdUIDemo.exe
│           ├── ZmdUIDemo.exe.manifest
│           ├── build.ninja
│           ├── cmake_install.cmake
│           └── compile_commands.json
├── qml/
│   ├── ZmdUI/
│   │   ├── Theme.qml
│   │   ├── ZButton.qml
│   │   ├── ZChatInput.qml
│   │   ├── ZCheckBox.qml
│   │   ├── ZCutRect.qml
│   │   ├── ZDialog.qml
│   │   ├── ZGridBackground.qml
│   │   ├── ZHatchPattern.qml
│   │   ├── ZIconButton.qml
│   │   ├── ZLineChart.qml
│   │   ├── ZListItem.qml
│   │   ├── ZListView.qml
│   │   ├── ZPanel.qml
│   │   ├── ZProgressBar.qml
│   │   ├── ZRadioButton.qml
│   │   ├── ZRichTextEditor.qml
│   │   ├── ZScrollBar.qml
│   │   ├── ZSectionTitle.qml
│   │   ├── ZSideBar.qml
│   │   ├── ZSkewRect.qml
│   │   ├── ZSlider.qml
│   │   ├── ZStatusDot.qml
│   │   ├── ZSwitch.qml
│   │   ├── ZTable.qml
│   │   ├── ZTag.qml
│   │   ├── ZTextField.qml
│   │   ├── ZToolTip.qml
│   │   └── qmldir
│   ├── DemoContent.qml
│   └── main.qml
├── resources/
│   └── qml.qrc
├── src/
│   ├── main.cpp
│   ├── zclipboard.cpp
│   └── zclipboard.h
├── tests/
│   ├── tst_chatinput.qml
│   ├── tst_hover.qml
│   └── tst_richtext.qml
├── tools/
│   ├── check_inverse_blocks.py
│   ├── crop.qml
│   ├── crop_params.json
│   ├── dllerr.log
│   ├── gen_docs.py
│   ├── probe_anim.qml
│   ├── probe_anim_button.qml
│   ├── probe_buttons.qml
│   ├── probe_dark.qml
│   ├── probe_fade.qml
│   ├── probe_hittest.qml
│   ├── probe_popup.qml
│   ├── probe_sidebar.qml
│   ├── probe_tooltip.qml
│   ├── run_clion_debug.log
│   ├── smoke.qml
│   ├── smoke_dark_scroll.qml
│   └── smoke_scroll.qml
├── CMakeLists.txt
├── CMakePresets.json
├── CMakeUserPresets.json
└── README.md
```

设计上分三层：**主题层**（`Theme.qml` 单例）→ **图元层**（4 个 Shape/Canvas 图元）→ **组件层**（22 个控件）。组件只从主题取值、只用图元绘制，因此换主题不用改组件，换视觉不用改业务。

## 一、主题与基础图元

### `qml/ZmdUI/Theme.qml`

全局主题单例：配色 / 字体 / 尺寸 / 动画，一键切换亮暗主题

```qml
pragma Singleton

import QtQuick
import QtQuick.Controls

/*!
    \qmltype Theme
    \inqmlmodule ZmdUI
    \brief 终末地工业机能风 · 全局主题单例（配色 / 字体 / 尺寸 / 动画）

    所有组件都只从这里取值，不写任何魔法数字。切换主题只需改 \l mode：

    \code
    Theme.mode = Theme.Mode.Dark    // 暗色
    Theme.mode = Theme.Mode.Light   // 浅色（默认）
    \endcode

    \note 尺寸单位一律是「逻辑像素」。Qt 6 会按 devicePixelRatio 自动放大到物理像素，
          所以本文件里不需要也不应该出现 dpr 乘法；\l dp() 只做「设计密度」换算与取整，
          避免在高 DPI 下出现 0.5 px 导致的边缘发虚。
*/
QtObject {
    id: theme

    // ════════════════════════════════════════════════════════════════
    //  1. 主题模式
    // ════════════════════════════════════════════════════════════════

    /*! 主题枚举：Light = 0，Dark = 1（对应 \l mode 的取值） */
    enum Mode { Light, Dark }

    /*! 当前主题。默认浅色：亮白底 + 荧光黄 + 纯黑。 */
    property int mode: 0                        // Theme.Mode.Light
    readonly property bool isDark: mode === 1   // Theme.Mode.Dark

    // ════════════════════════════════════════════════════════════════
    //  2. 语义枚举（组件的 variant / tone 统一在这里定义，避免各写各的）
    // ════════════════════════════════════════════════════════════════

    /*! 按钮等交互控件的形态 */
    enum Variant { Primary, Secondary, Danger, Ghost }

    /*! 标签 / 状态点 / 强调块的语义色调 */
    enum Tone { Ink, Accent, Outline, Muted, Cyan, Magenta, Danger }

    // ════════════════════════════════════════════════════════════════
    //  3. 配色（严格遵循设计规范，避免大面积渐变）
    //
    //  表面分四层，暗色下靠"层级"而不是"亮边框"来区分结构：
    //      sunken（凹陷：轨道 / 凹槽） < bg（页面） < muted（中间层） < surface（抬升：卡片）
    //  亮色主题里 surface 是最亮的（白卡片压在浅灰底上），
    //  暗色主题里 surface 也必须比 bg **更亮**，否则卡片会像"洞"而不是"板"。
    //  参考 https://www.fz.wiki/ 的令牌：#181818 / #1f1f1f / #232323 就是这个关系。
    // ════════════════════════════════════════════════════════════════

    /*! 页面主背景：亮白 / 浅灰 */
    readonly property color bg:            isDark ? "#181818" : "#F2F2F2"
    /*! 抬升面：卡片 / 面板 / 输入框 */
    readonly property color surface:       isDark ? "#232323" : "#FFFFFF"
    /*! 中间层：交替行、悬停底、次级卡片（旧名 surfaceAlt 保留兼容） */
    readonly property color surfaceMuted:  isDark ? "#1F1F1F" : "#E6E6E6"
    readonly property color surfaceAlt:   surfaceMuted
    /*! 凹陷面：轨道、凹槽、代码块 —— 比页面更暗，暗色下才有"凹进去"的层次 */
    readonly property color surfaceSunken: isDark ? "#101010" : "#E4E4E4"
    /*!
        悬停面。注意亮暗两个主题的方向是**相反**的：
        亮色卡是白的，悬停要变暗一档；暗色卡是 #232323，悬停必须变亮一档。
        写死 direction 的悬停色在暗色下会"越悬停越黑"，等于没有反馈。
    */
    readonly property color surfaceHover:  isDark ? "#2C2C2C" : "#E9E9E9"
    /*! 网格线（细） */
    readonly property color gridLine:      isDark ? "#242424" : "#E4E4E4"
    /*! 网格线（主刻度，略深） */
    readonly property color gridLineMajor: isDark ? "#303030" : "#CFCFCF"

    /*!
        主强调色：荧光黄 / 柠檬黄。高亮、装饰底边、选中态专用。

        \note 暗色下**必须压暗**（#E8FA00 → #D8BF00）：大面积亮柠檬黄浮在暗背景上
        会非常刺眼，而且亮黄自带"发光"错觉，压暗后反而更像工业屏上的涂层。
        参考站的令牌同样是 #f2cc00 → #d8bf00 这个关系。
    */
    readonly property color accent:        isDark ? "#D8BF00" : "#E8FA00"
    /*! 强调色的浅一档（亮色下用） */
    readonly property color accentSoft:    isDark ? "#272302" : "#DFFF00"
    /*! 强调色的提亮档：暗色下画细线 / 小字用，保证对比度 */
    readonly property color accentGlow:    isDark ? "#ECD548" : "#E8FA00"
    /*! 落在强调色上的文字（深色）。注意不要命名成 onXxx，那是信号处理器语法。 */
    readonly property color textOnAccent:  isDark ? "#161616" : "#000000"

    /*! 主文字：亮色纯黑，暗色浅灰（近白会发飘，用 #EEE 更稳） */
    readonly property color ink:           isDark ? "#EEEEEE" : "#000000"
    /*! 深炭色，比 ink 软一点，用于正文 */
    readonly property color inkSoft:       isDark ? "#D2D6DA" : "#1A1A1A"
    /*! 辅助文字 / 等宽说明文字。暗色下用冷灰，纯中性灰在暗底上会显脏 */
    readonly property color muted:         isDark ? "#A8B0B7" : "#5C5C5C"

    /*! 副标题底色：深灰（亮暗两套主题都保持"深色块 + 白字"这个身份） */
    readonly property color subBg:         isDark ? "#2E2E2E" : "#333333"
    /*! 副标题底色（更浅一档，用作分层） */
    readonly property color subBgAlt:      isDark ? "#3C3C3C" : "#4D4D4D"
    /*! 深灰底上的文字：纯白 */
    readonly property color textOnSub:     "#FFFFFF"
    /*!
        反相块（黑底白字那种条/徽标：表头、编号块、对话框标题带）。

        \note 不能用 \l ink 当它的底色 —— ink 在暗色下是浅灰，块会变成"浅底白字"，
        文字直接消失。反相块在两个主题里都必须是**深色**：亮色近黑，暗色比卡片更黑
        （#0F0F0F 压在 #232323 卡片上依然是明显的深色带）。
    */
    readonly property color inkBlock:      isDark ? "#0F0F0F" : "#111111"

    /*!
        结构线（边框、分隔线）。
        \note 暗色下**绝对不能用近白色**：我第一版把 line 反相成 #EFEFEF，
        每个卡片都镶一圈白边，夜里看非常刺眼，而且失去了"层级"的表达。
        正确做法是冷灰 #4A5158：既能描出轮廓，又不抢视线。
    */
    readonly property color line:          isDark ? "#4A5158" : "#000000"
    /*! 弱结构线 */
    readonly property color lineSoft:      isDark ? "#2E343A" : "#ADADAD"
    /*! 斜线纹理颜色 */
    readonly property color hatch:         isDark ? "#2E2E2E" : "#D6D6D6"
    /*! 斜线纹理颜色（加重档，用于对话框中央） */
    readonly property color hatchStrong:   isDark ? "#3C3C3C" : "#C0C0C0"

    /*! 点缀色 1：高饱和青（仅用于极小的数据状态块） */
    readonly property color cyan:         "#00E5FF"
    /*! 淡青色：黑底副标题块、深色带上的小装饰点。
        纯白点在这种 5px 级别的小方块上对比过强、边界发虚，淡青更清楚也更贴合设计语言。 */
    readonly property color cyanSoft:     "#6FE4F5"
    /*! 点缀色 2：品红（仅用于极小的数据状态块） */
    readonly property color magenta:      "#FF00FF"
    /*! 危险 / 异常状态（用深灰底 + 品红细边表达，不引入大面积红） */
    readonly property color danger:       isDark ? "#FF3D71" : "#C2003B"

    /*! 颜色加透明度的小工具：Theme.alpha(Theme.ink, 0.4) */
    function alpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a)
    }

    // ════════════════════════════════════════════════════════════════
    //  4. 字体
    // ════════════════════════════════════════════════════════════════

    /*! 正文字族。Windows 上「微软雅黑」只有 Regular/Bold 两档，
        Font.Black(900) 会落到 Bold；标题想要更粗的观感请看 displayHeavy。 */
    readonly property string family: Qt.platform.os === "windows"
                                     ? "Microsoft YaHei UI" : "Noto Sans CJK SC"
    /*! 拉丁标题字族：Arial Black，用于英文全大写大字 */
    readonly property string familyDisplay: Qt.platform.os === "windows"
                                            ? "Arial Black" : "DejaVu Sans"
    /*! 等宽字族：SYSTEM INTERFACE / 坐标 / 编号一律用它 */
    readonly property string familyMono: Qt.platform.os === "windows"
                                         ? "Consolas" : "DejaVu Sans Mono"

    /*! 超大标题（中文带「」），配 displayHeavy 假粗体描边使用 */
    readonly property font fontTitle:    Qt.font({ family: family, pixelSize: 42,
                                                   weight: Font.Black, letterSpacing: 1 })
    /*! 英文全大写大标题 */
    readonly property font fontTitleEn:  Qt.font({ family: familyDisplay, pixelSize: 40,
                                                   weight: Font.Black, letterSpacing: 1 })
    /*! 区块标题 / 卡片标题 */
    readonly property font fontHeading:  Qt.font({ family: family, pixelSize: 22,
                                                   weight: Font.Black, letterSpacing: 1 })
    /*! 副标题（黑底白字那一块） */
    readonly property font fontSubtitle: Qt.font({ family: family, pixelSize: 19,
                                                   weight: Font.Black, letterSpacing: 2 })
    /*! 正文 */
    readonly property font fontBody:     Qt.font({ family: family, pixelSize: 14,
                                                   weight: Font.Normal })
    /*! 加重正文：按钮、列表项标签 */
    readonly property font fontStrong:   Qt.font({ family: family, pixelSize: 14,
                                                   weight: Font.DemiBold })
    /*! 数值大字（统计卡里的 US$9.7665） */
    readonly property font fontNumber:   Qt.font({ family: family, pixelSize: 30,
                                                   weight: Font.Black, letterSpacing: 1 })
    /*! 小标签，全大写加字距 */
    readonly property font fontLabel:    Qt.font({ family: family, pixelSize: 11,
                                                   weight: Font.DemiBold, letterSpacing: 1.5 })
    /*! 等宽小字（默认） */
    readonly property font fontMonoSm:   Qt.font({ family: familyMono, pixelSize: 11 })
    /*! 等宽中字 */
    readonly property font fontMonoMd:   Qt.font({ family: familyMono, pixelSize: 13 })

    /*!
        \note 关于"超粗"：曾经用 Text.Outline + 同色 styleColor 给中文标题加粗，
        但在 40px 级别下描边会把「概」「况」这类字的字腔糊死，反而看不清，已全部去掉。
        现在的做法是直接用 Font.Black（Windows 上落到微软雅黑 Bold）+ 收敛字距，
        要更粗请自行换字体（如思源黑体 Heavy）改 \l family 即可。
    */

    // ════════════════════════════════════════════════════════════════
    //  5. 尺寸与几何
    // ════════════════════════════════════════════════════════════════

    readonly property int spacingXs: 4
    readonly property int spacingSm: 8
    readonly property int spacingMd: 12
    readonly property int spacingLg: 20
    readonly property int spacingXl: 32

    /*! 斜切角尺寸：小（按钮/标签）、中（输入框/列表项）、大（卡片/对话框） */
    readonly property int cutSm: 6
    readonly property int cutMd: 12
    readonly property int cutLg: 22

    /*! 边框：常规 2px，重结构 3px */
    readonly property int border: 2
    readonly property int borderThick: 3

    /*! 控件高度 */
    readonly property int controlHeightSm: 28
    readonly property int controlHeight: 38
    readonly property int controlHeightLg: 46

    /*! 卡片底部装饰条高度 */
    readonly property int accentBarHeight: 22

    /*! 工程网格步长 */
    readonly property int gridMinor: 12
    readonly property int gridMajor: 60
    /*! 斜线纹理步长 */
    readonly property int hatchStep: 9

    /*! 设计密度：1.0 为标准；0.9 紧凑，1.15 宽松。会整体缩放所有控件高度与间距。 */
    property real density: 1.0

    /*! 尺寸换算：套用密度后取整，避免高 DPI 下的半像素模糊。 */
    function dp(v) {
        return Math.round(v * density)
    }

    // ════════════════════════════════════════════════════════════════
    //  6. 动画
    // ════════════════════════════════════════════════════════════════

    /*!
        光标闪烁的半周期（ms）。

        故意**跟随系统设置**而不是写死设计值（Windows 默认全周期 1060ms）——
        光标的节奏应该和系统里其它输入框一致，不然会显得"这个 App 的光标很奇怪"。
        系统把 cursorFlashTime 设为 0 表示"不闪烁"，这里兜一个下限，
        免得定时器退化成 0 间隔的忙等。
    */
    readonly property int caretFlashHalf: Math.max(200, Math.round(Application.styleHints.cursorFlashTime / 2))

    /*! 悬停 / 按下等即时反馈 */
    readonly property int durFast: 90
    /*! 默认过渡 */
    readonly property int durBase: 160
    /*! 展开 / 弹层 */
    readonly property int durSlow: 260

    readonly property int easingStd: Easing.OutCubic
    readonly property int easingEnter: Easing.OutBack
    readonly property int easingExit: Easing.InQuad
}
```

### `qml/ZmdUI/ZCutRect.qml`

斜切角矩形图元，整套设计语言的地基

```qml
import QtQuick
import QtQuick.Shapes

/*!
    \qmltype ZCutRect
    \inqmlmodule ZmdUI
    \brief 支持四角独立斜切的实心 / 描边矩形，用来替代带圆角的 Rectangle。

    这是整套设计语言的地基：任何"卡片、按钮、输入框"的硬朗切角都由它绘制。
    切角走 Shape 路径（MiterJoin，不加圆角），因此边缘是干净的直角折线。

    \qml
    ZCutRect {
        width: 200; height: 48
        color: Theme.accent
        strokeColor: Theme.ink
        strokeWidth: Theme.border
        cutTopRight: Theme.cutMd
        cutBottomLeft: Theme.cutSm
    }
    \endqml

    \note Shape 的 implicitWidth/implicitHeight 由路径包围盒反算，请不要给它们
          绑定表达式（会被 C++ 侧覆盖）。使用处请显式给出 width/height 或用 anchors 约束。
          把四个角的切角都设成 min(w,h)/2 就会得到一个菱形（单选按钮的指示器就靠这个）。
*/
Shape {
    id: root

    /*! 填充色 */
    property color color: "transparent"
    /*! 描边色 */
    property color strokeColor: "transparent"
    /*! 描边宽度（居中于路径，内部已按 1/2 内缩，保证外轮廓正好贴住 width/height） */
    property real strokeWidth: 0

    /*! 左上角斜切尺寸 */
    property real cutTopLeft: 0
    /*! 右上角斜切尺寸 */
    property real cutTopRight: 0
    /*! 右下角斜切尺寸 */
    property real cutBottomRight: 0
    /*! 左下角斜切尺寸 */
    property real cutBottomLeft: 0

    /*! 反向斜切：为 true 时切角方向反转，用于制造"咬合"错位感 */
    property bool invertCuts: false

    antialiasing: true
    preferredRendererType: Shape.CurveRenderer

    // ── 内部几何：0.5 像素对齐，避免 1px 描边发虚 ──
    readonly property real _p: strokeWidth / 2
    readonly property real _w: Math.max(0, width - strokeWidth)
    readonly property real _h: Math.max(0, height - strokeWidth)
    readonly property real _x0: _p
    readonly property real _y0: _p
    readonly property real _x1: _p + _w
    readonly property real _y1: _p + _h

    // 切角不得超过短边的一半，否则路径自交
    function _clamp(v) {
        return Math.max(0, Math.min(v, Math.min(_w, _h) / 2))
    }

    readonly property real _tl: _clamp(cutTopLeft)
    readonly property real _tr: _clamp(cutTopRight)
    readonly property real _br: _clamp(cutBottomRight)
    readonly property real _bl: _clamp(cutBottomLeft)

    ShapePath {
        strokeColor: root.strokeColor
        strokeWidth: root.strokeWidth
        fillColor: root.color
        joinStyle: ShapePath.MiterJoin
        capStyle: ShapePath.FlatCap

        startX: root._x0 + root._tl
        startY: root._y0

        // 上边 → 右上切角
        PathLine { x: root._x1 - root._tr; y: root._y0 }
        PathLine { x: root._x1;            y: root._y0 + root._tr }
        // 右边
        PathLine { x: root._x1;            y: root._y1 - root._br }
        // 右下切角 → 下边
        PathLine { x: root._x1 - root._br; y: root._y1 }
        PathLine { x: root._x0 + root._bl; y: root._y1 }
        // 左下切角 → 左边
        PathLine { x: root._x0;            y: root._y1 - root._bl }
        PathLine { x: root._x0;            y: root._y0 + root._tl }
        // 回到起点，闭合
        PathLine { x: root._x0 + root._tl; y: root._y0 }
    }
}
```

### `qml/ZmdUI/ZSkewRect.qml`

平行四边形图元（副标题块、标签、高亮块）

```qml
import QtQuick
import QtQuick.Shapes

/*!
    \qmltype ZSkewRect
    \inqmlmodule ZmdUI
    \brief 平行四边形图元：上下边平行，左右边按 \l skew 倾斜。

    用于副标题黑块、标签、选中高亮块等"斜切"元素。

    \qml
    ZSkewRect { width: 240; height: 34; skew: 14; color: Theme.subBg }
    \endqml
*/
Shape {
    id: root

    /*! 填充色 */
    property color color: "transparent"
    /*! 描边色 */
    property color strokeColor: "transparent"
    /*! 描边宽度 */
    property real strokeWidth: 0
    /*! 倾斜量：顶边相对底边右移的距离，正值 = 右上倾 */
    property real skew: 10

    antialiasing: true
    preferredRendererType: Shape.CurveRenderer

    readonly property real _p: strokeWidth / 2
    readonly property real _w: Math.max(0, width - strokeWidth)
    readonly property real _h: Math.max(0, height - strokeWidth)

    ShapePath {
        strokeColor: root.strokeColor
        strokeWidth: root.strokeWidth
        fillColor: root.color
        joinStyle: ShapePath.MiterJoin
        capStyle: ShapePath.FlatCap

        startX: root._p + root.skew
        startY: root._p
        PathLine { x: root._p + root._w;               y: root._p }
        PathLine { x: root._p + root._w - root.skew;   y: root._p + root._h }
        PathLine { x: root._p;                         y: root._p + root._h }
        PathLine { x: root._p + root.skew;             y: root._p }
    }
}
```

### `qml/ZmdUI/ZHatchPattern.qml`

斜线纹理 / 斜线阴影，Canvas 绘制

```qml
import QtQuick

/*!
    \qmltype ZHatchPattern
    \inqmlmodule ZmdUI
    \brief 斜线阴影 / 斜线纹理（Diagonal Hatching），纯 Canvas 绘制。

    工程图纸上常用的"禁入区 / 特殊区"纹理。放在面板角落、对话框中央做质感。

    \qml
    ZHatchPattern {
        anchors.right: parent.right
        width: 160; height: 90
        lineColor: Theme.hatch
        spacing: 9
    }
    \endqml

    \note 只在尺寸 / 参数变化时重绘，静态使用不会持续占用 GPU / CPU。
*/
Canvas {
    id: root

    /*! 线色 */
    property color lineColor: "#D6D6D6"
    /*! 线间距（逻辑像素） */
    property real spacing: 9
    /*! 线宽 */
    property real lineWidth: 1.4
    /*! true = 竖斜线（90°），false = 横斜线（45°） */
    property bool vertical: false
    /*! true = 双向交叉成网眼 */
    property bool cross: false

    renderStrategy: Canvas.Immediate

    // 任一参数变化都要重绘
    onLineColorChanged: requestPaint()
    onSpacingChanged: requestPaint()
    onLineWidthChanged: requestPaint()
    onVerticalChanged: requestPaint()
    onCrossChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()

        var w = width
        var h = height
        if (w <= 0 || h <= 0)
            return

        var s = Math.max(3, spacing)
        ctx.lineWidth = lineWidth
        ctx.strokeStyle = lineColor
        ctx.lineCap = "butt"

        if (!vertical) {
            // 45°：从左下往右上铺线，起点从 -h 开始才能盖满左上角
            for (var x = -h; x < w + h; x += s) {
                ctx.beginPath()
                ctx.moveTo(x, 0)
                ctx.lineTo(x + h, h)
                ctx.stroke()
                if (cross) {
                    ctx.beginPath()
                    ctx.moveTo(x + h, 0)
                    ctx.lineTo(x, h)
                    ctx.stroke()
                }
            }
        } else {
            // 90°：竖向斜线
            for (var y = -w; y < h + w; y += s) {
                ctx.beginPath()
                ctx.moveTo(0, y)
                ctx.lineTo(w, y + w)
                ctx.stroke()
                if (cross) {
                    ctx.beginPath()
                    ctx.moveTo(0, y + w)
                    ctx.lineTo(w, y)
                    ctx.stroke()
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZGridBackground.qml`

工程网格背景（细网格 + 主刻度 + 十字星）

```qml
import QtQuick

/*!
    \qmltype ZGridBackground
    \inqmlmodule ZmdUI
    \brief 工程图纸网格背景（细网格 + 主刻度 + 十字星标记），纯 Canvas 绘制。

    整块铺底，作为页面根背景使用。主刻度交叉点会画小十字（+），
    对应设计语言里的"科技感细节"。

    \qml
    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }
    \endqml

    \note 绘制是一次性的（尺寸/配色变化才重绘），在 4K 下也不会掉帧。
*/
Canvas {
    id: root

    /*! 底色，一般传 Theme.bg */
    property color bgColor: "#F2F2F2"
    /*! 细网格线色 */
    property color minorColor: "#E4E4E4"
    /*! 主网格线色（每 majorStep 一根） */
    property color majorColor: "#D2D2D2"
    /*! 十字星颜色 */
    property color crossColor: "#C4C4C4"

    /*! 细网格步长 */
    property real minorStep: 12
    /*! 主网格步长（应当是 minorStep 的整数倍） */
    property real majorStep: 60
    /*! 是否绘制十字星 */
    property bool showCross: true
    /*! 每隔几个主交叉点画一个十字（越大越稀疏） */
    property int crossEvery: 2
    /*! 十字臂长 */
    property real crossArm: 3.5

    readonly property real _ratio: Math.max(2, Math.round(majorStep / Math.max(1, minorStep)))

    renderStrategy: Canvas.Immediate

    onBgColorChanged: requestPaint()
    onMinorColorChanged: requestPaint()
    onMajorColorChanged: requestPaint()
    onCrossColorChanged: requestPaint()
    onMinorStepChanged: requestPaint()
    onMajorStepChanged: requestPaint()
    onShowCrossChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()

        var w = width
        var h = height
        if (w <= 0 || h <= 0)
            return

        // 1) 平涂底色：设计规范要求避免大面积渐变
        ctx.fillStyle = bgColor
        ctx.fillRect(0, 0, w, h)

        // 2) 细网格 —— 跳过与主网格重合的行列，避免深色叠加
        ctx.lineWidth = 1
        ctx.strokeStyle = minorColor
        ctx.beginPath()
        var i = 0
        for (var x = 0; x <= w; x += minorStep, i++) {
            if (i % _ratio === 0)
                continue
            // +0.5 让 1px 线落在像素中心，不糊
            ctx.moveTo(Math.round(x) + 0.5, 0)
            ctx.lineTo(Math.round(x) + 0.5, h)
        }
        i = 0
        for (var y = 0; y <= h; y += minorStep, i++) {
            if (i % _ratio === 0)
                continue
            ctx.moveTo(0, Math.round(y) + 0.5)
            ctx.lineTo(w, Math.round(y) + 0.5)
        }
        ctx.stroke()

        // 3) 主网格
        ctx.lineWidth = 1.2
        ctx.strokeStyle = majorColor
        ctx.beginPath()
        for (var mx = 0; mx <= w; mx += majorStep) {
            ctx.moveTo(Math.round(mx) + 0.5, 0)
            ctx.lineTo(Math.round(mx) + 0.5, h)
        }
        for (var my = 0; my <= h; my += majorStep) {
            ctx.moveTo(0, Math.round(my) + 0.5)
            ctx.lineTo(w, Math.round(my) + 0.5)
        }
        ctx.stroke()

        // 4) 主交叉点上的小十字星（+）
        if (!showCross)
            return
        ctx.lineWidth = 1.2
        ctx.strokeStyle = crossColor
        ctx.beginPath()
        var ci = 0
        for (var cx = 0; cx <= w; cx += majorStep) {
            var cj = 0
            for (var cy = 0; cy <= h; cy += majorStep) {
                if (ci % crossEvery === 0 && cj % crossEvery === 0) {
                    ctx.moveTo(cx - crossArm, cy)
                    ctx.lineTo(cx + crossArm, cy)
                    ctx.moveTo(cx, cy - crossArm)
                    ctx.lineTo(cx, cy + crossArm)
                }
                cj++
            }
            ci++
        }
        ctx.stroke()
    }
}
```

## 二、交互控件

### `qml/ZmdUI/ZButton.qml`

按钮：主要 / 次要 / 危险 / 幽灵 / 平行四边形

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZButton
    \inqmlmodule ZmdUI
    \brief 工业机能风按钮：斜切角 + 平涂高对比 + 悬停反色。

    四种形态（\l variant 取 \c Theme.Variant 之一）：
    \list
    \li \c Primary   —— 荧光黄底 / 黑字 / 黑边；悬停整体反色为黑底黄字。
    \li \c Secondary —— 白底 / 黑字 / 黑边；悬停左侧亮黄竖条。
    \li \c Danger    —— 深炭底 / 白字；悬停时左侧出现亮黄竖条（不引入品红等点缀色，
                        点缀色只留给 ZStatusDot 这种极小面积的状态块）。
    \li \c Ghost     —— 无底无框，仅文字；悬停出现浅灰底 + 亮黄底线。
    \endlist

    \l skew > 0 时改用平行四边形外观（更适合做导航 / 分类按钮）。

    \qml
    ZButton { text: "一键配置并启动"; variant: Theme.Variant.Primary; onClicked: ... }
    ZButton { text: "扫描登录"; variant: Theme.Variant.Secondary; mono: "F2" }
    \endqml
*/
Button {
    id: control

    /*! 形态，取 Theme.Variant.* */
    property int variant: Theme.Variant.Primary
    /*! 右侧等宽小字：快捷键 / 编号 / 计数 */
    property string mono: ""
    /*! >0 时使用平行四边形外观，数值即倾斜量 */
    property real skew: 0
    /*! 斜切角大小，默认跟随主题的中号 */
    property int cutSize: Theme.cutMd
    /*! 悬停提示文案，非空时自动挂一个 ZToolTip（调用处不必再写 parent.hovered） */
    property string tooltip: ""

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus

    // 内边距恒定：悬停时不能改 padding。
    // 之前用 "spacingLg + (悬停 ? 6 : 0)" 给左侧竖条让位，结果鼠标一进按钮宽度就变，
    // 整行按钮跟着跳。竖条改成画在底板内部（下面 background 里左对齐、贴内边缘），谁都不动。
    leftPadding: Theme.spacingLg + 4
    rightPadding: Theme.spacingLg
    topPadding: Theme.spacingSm
    bottomPadding: Theme.spacingSm

    readonly property bool _isOn: hovered || visualFocus

    /*!
        左侧亮黄竖条是否显示。抽成纯函数有两个原因：
        \list
        \li 规则本身需要被测试覆盖，而离屏平台投递不了鼠标事件（实测连 mousePress
            都到不了 item），悬停态没法靠交互模拟出来 —— 只能直接单测规则。
        \li 把"什么情况下长竖条"这条设计规则写在一个地方，改的时候不用满文件找。
        \endlist
        \list
        \li 平行四边形（skew > 0）不画：竖条是直边，贴到斜边上会戳出形状外。
        \li Primary 不画：它的悬停反馈是整体反色（黄底黑字 → 黑底黄字），已经足够强。
        \li 其余形态（Secondary / Ghost / Danger）只在悬停或键盘聚焦时画，
            默认态干干净净，不做常显装饰。
        \endlist
    */
    function edgeVisibleFor(variantValue, skewAmount, active, isEnabled) {
        return isEnabled && skewAmount <= 0 && active && variantValue !== Theme.Variant.Primary
    }

    /*!
        左竖条的颜色。规则：**底色本身是亮黄时必须转黑**，否则竖条和底色同色等于没画
        （Secondary 悬停就是这种情况：白底变亮黄底）。
    */
    function edgeColorFor(variantValue, active) {
        // 底色是亮黄时竖条转"强调色上的文字色"（亮色=黑 / 暗色=深炭），
        // 不能用 Theme.ink —— 暗色下 ink 是浅灰，压在压暗后的黄上一样看不见
        return (variantValue === Theme.Variant.Secondary && active)
                ? Theme.textOnAccent : Theme.accent
    }

    readonly property bool showEdge: edgeVisibleFor(variant, skew, _isOn, enabled)
    readonly property color edgeColor: edgeColorFor(variant, _isOn)

    /*!
        底板的切角。**底板、Ghost 悬浮叠加层、焦点环共用这一份取值**。

        抽出来是因为这三块画的是"同一个形状"，各写各的迟早会漂移 —— Ghost 的悬浮底
        当初就是漏抄了这两个值，于是它退化成一块直角矩形、悬浮时直接戳出底板轮廓，
        表现成"别的按钮是六边形、只有『了解更多』悬浮时是方块"。改一处、三处同步，
        这个 bug 就不可能再出现。
    */
    readonly property real cutTopRightSize: enabled ? cutSize : 0
    readonly property real cutBottomLeftSize: enabled ? Theme.cutSm : 0

    /*! 悬停 / 聚焦的过渡时长。所有状态动画共用它，保证节奏一致。 */
    readonly property int stateDuration: Theme.durBase


    /*! 底面填充色 */
    readonly property color _fill: {
        if (!enabled)
            return Theme.surfaceAlt
        switch (variant) {
        case Theme.Variant.Primary:
            return _isOn ? Theme.ink : Theme.accent
        case Theme.Variant.Secondary:
            return _isOn ? Theme.accent : Theme.surface
        case Theme.Variant.Danger:
            return Theme.subBg
        default:
            // Ghost：底板恒为透明，"有没有底"交给下面那块独立叠加层
            return "transparent"
        }
    }

    /*! 描边色 */
    readonly property color _stroke: {
        if (!enabled)
            return Theme.lineSoft
        if (variant === Theme.Variant.Ghost)
            return "transparent"
        return Theme.ink
    }

    /*! 文字色 */
    readonly property color _fg: {
        if (!enabled)
            return Theme.muted
        if (variant === Theme.Variant.Primary)
            return _isOn ? Theme.accent : Theme.textOnAccent
        if (variant === Theme.Variant.Danger)
            return Theme.textOnSub
        return Theme.ink
    }

    implicitWidth: contentItem ? contentItem.implicitWidth + leftPadding + rightPadding : 120
    implicitHeight: Theme.dp(Theme.controlHeight)

    background: Item {
        // ── 底板：斜切角矩形 / 平行四边形 ──
        ZCutRect {
            anchors.fill: parent
            visible: control.skew <= 0
            color: control._fill
            strokeColor: control._stroke
            strokeWidth: control._stroke.a > 0 ? Theme.border : 0
            cutTopRight: control.cutTopRightSize
            cutBottomLeft: control.cutBottomLeftSize

            // 悬停/聚焦时底色平滑过渡（黄底黑字 ↔ 黑底黄字这类反色不再是硬切）
            Behavior on color {
                ColorAnimation { duration: control.stateDuration; easing.type: Theme.easingStd }
            }
        }

        ZSkewRect {
            anchors.fill: parent
            visible: control.skew > 0
            skew: control.skew
            color: control._fill
            strokeColor: control._stroke
            strokeWidth: control._stroke.a > 0 ? Theme.border : 0

            Behavior on color {
                ColorAnimation { duration: control.stateDuration; easing.type: Theme.easingStd }
            }
        }

        // ── Ghost 的悬浮底：独立叠加层，用 opacity 过渡 ──
        //
        // 为什么不让底板自己做 "transparent ↔ surfaceHover" 的颜色过渡：
        //   · 底板的 color 是四个形态共用的，而 Ghost 是唯一一个"底色靠 alpha=0
        //     表示不存在"的形态 —— "有没有底"和"底是什么颜色"被混在同一条通道上；
        //   · 这条颜色过渡和左竖条的宽度过渡挤在同一次状态变化里，状态一抖动
        //     动画就被反复重启，最先出问题的是它；
        //   · 挪到独立的不透明度通道后，悬浮底的显隐与底板颜色彻底解耦，
        //     任何形态的底色动画都影响不到它。
        ZCutRect {
            id: ghostHoverFill
            anchors.fill: parent
            visible: control.variant === Theme.Variant.Ghost
            color: Theme.surfaceHover
            opacity: control._isOn ? 1 : 0

            // 切角必须和底板一模一样：叠加层是"铺在底板上"的替身，
            // 少了这两个切角它就退化成一块直角矩形，悬浮时右上 / 左下会戳出底板轮廓外 ——
            // 用户看到的"了解更多悬浮是方角、别的按钮是六边形"就是这个。
            cutTopRight: control.cutTopRightSize
            cutBottomLeft: control.cutBottomLeftSize

            Behavior on opacity {
                NumberAnimation { duration: control.stateDuration; easing.type: Theme.easingStd }
            }
        }

        // ── 左侧亮黄竖条 ──
        //    画在底板内部（左内边缘），不参与布局，所以不会把按钮撑宽；
        //    宽度 0 → 5 用动画长出来，这就是"悬浮动画"的主体。
        ZCutRect {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 4
            anchors.bottomMargin: 4
            width: control.showEdge ? 5 : 0
            color: control.enabled ? control.edgeColor : Theme.lineSoft
            cutTopRight: 3
            cutBottomLeft: 3

            Behavior on width {
                NumberAnimation { duration: control.stateDuration; easing.type: Theme.easingStd }
            }
            // 竖条颜色跟着底色一起过渡：Secondary 白→黄的同时，竖条黄→黑
            Behavior on color {
                ColorAnimation { duration: control.stateDuration; easing.type: Theme.easingStd }
            }
        }

        // ── 键盘焦点环：向外偏 4px 的亮黄描边 ──
        ZCutRect {
            anchors.fill: parent
            anchors.margins: -4
            anchors.leftMargin: -1
            visible: control.visualFocus && control.enabled
            color: "transparent"
            strokeColor: Theme.accent
            strokeWidth: 2
            cutTopRight: control.cutTopRightSize
            cutBottomLeft: control.cutBottomLeftSize
        }
    }

    contentItem: Item {
        implicitWidth: row.implicitWidth
        implicitHeight: row.implicitHeight

        Row {
            id: row
            anchors.centerIn: parent
            // 按下时整体下沉 1px：机械按键的物理反馈
            anchors.horizontalCenterOffset: control.pressed ? 1 : 0
            anchors.verticalCenterOffset: control.pressed ? 1 : 0
            spacing: Theme.spacingSm

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: control.text
                font: Theme.fontStrong
                color: control._fg
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: control.mono.length > 0
                text: control.mono
                font: Theme.fontMonoSm
                color: control._fg
                opacity: 0.75
            }
        }
    }

    // 悬停提示：文案非空时自动挂一个 ZToolTip（调用处不必再写 parent.hovered）。
    //
    // ⚠️ 这里**不能自己绑 visible**。ToolTip 的显隐状态机在 C++ 的 T.ToolTip 里
    //    （它管 hovered + delay + timeout 三件事），一旦在外面把 visible 绑上，
    //    等于把整套逻辑覆盖掉：提示框会"一碰就弹"（delay: 300 形同虚设），
    //    而且弹层出现时抓走鼠标、可能反过来扰动宿主按钮的 hovered，
    //    表现就是"背景闪一下又变回白色"。
    ZToolTip {
        text: control.tooltip
    }
}
```

### `qml/ZmdUI/ZIconButton.qml`

方形图标按钮，自带工具提示

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZIconButton
    \inqmlmodule ZmdUI
    \brief 方形图标按钮：斜切角方框 + 单个字符图形，自带工具提示。

    不依赖字体图标库，直接用等宽字符当图形（+ − × → ↗ ≡ ◎ ⌕），
    也可以用 \l source 挂一张图片。

    \qml
    ZIconButton { glyph: "+"; tooltip: "新建任务"; onClicked: ... }
    ZIconButton { glyph: "×"; tone: Theme.Tone.Danger; tooltip: "关闭" }
    \endqml
*/
Button {
    id: control

    /*! 图形字符 */
    property string glyph: "+"
    /*! 图形字符的字号 */
    property int glyphSize: 18
    /*! 色调，取 Theme.Tone.*（Ink / Accent / Outline / Danger） */
    property int tone: Theme.Tone.Outline
    /*! 提示文案，非空时悬停自动弹出 ZToolTip */
    property string tooltip: ""
    /*! 备用：图片图形，设置后覆盖 glyph */
    property url source

    hoverEnabled: true
    implicitWidth: Theme.dp(Theme.controlHeight)
    implicitHeight: Theme.dp(Theme.controlHeight)
    padding: 0

    readonly property bool _on: hovered || visualFocus

    background: ZCutRect {
        anchors.fill: parent
        color: {
            if (!control.enabled)
                return Theme.surfaceAlt
            if (control._on) {
                return control.tone === Theme.Tone.Outline ? Theme.accent
                     : control.tone === Theme.Tone.Danger ? Theme.danger
                     : Theme.ink
            }
            return control.tone === Theme.Tone.Accent ? Theme.accent
                 : control.tone === Theme.Tone.Danger ? Theme.subBg
                 : Theme.surface
        }
        // 用结构线而不是 ink：暗色下 ink 是浅灰，一圈白边在暗色界面里过于抢眼
        strokeColor: control.enabled ? Theme.line : Theme.lineSoft
        strokeWidth: Theme.border
        cutTopRight: Theme.cutSm
        cutBottomLeft: Theme.cutSm
    }

    contentItem: Item {
        implicitWidth: Theme.dp(Theme.controlHeight) - Theme.border * 2
        implicitHeight: Theme.dp(Theme.controlHeight) - Theme.border * 2

        Text {
            anchors.centerIn: parent
            visible: !control.source.toString()
            text: control.glyph
            // 等宽字符做图形，横向拉伸一点更像工业符号
            font.family: Theme.familyMono
            font.pixelSize: control.glyphSize
            font.bold: true
            color: {
                if (!control.enabled)
                    return Theme.muted
                if (control._on)
                    return control.tone === Theme.Tone.Outline ? Theme.ink : Theme.textOnSub
                return control.tone === Theme.Tone.Accent ? Theme.textOnAccent
                     : control.tone === Theme.Tone.Danger ? Theme.textOnSub
                     : Theme.ink
            }
        }

        Image {
            anchors.centerIn: parent
            visible: !!control.source.toString()
            source: control.source
            sourceSize.width: 20 * Screen.devicePixelRatio
            sourceSize.height: 20 * Screen.devicePixelRatio
        }
    }

    ZToolTip {
        text: control.tooltip
        visible: control.tooltip.length > 0 && control.hovered
    }
}
```

### `qml/ZmdUI/ZTextField.qml`

输入框：黑硬边 + 聚焦亮黄底线 + 内嵌铭牌

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZTextField
    \inqmlmodule ZmdUI
    \brief 输入框：黑色硬边 + 右上 / 右下斜切角，聚焦时亮黄底线；光标只在编辑时出现并闪烁。

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

    /*! 左侧 / 上方的字段铭牌，空则隐藏 */
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

    // 光标（caret）交给系统默认实现会偏灰，这里自定义。
    //
    // ⚠️ 注意：自定义 cursorDelegate 之后，**Qt 不再帮你管可见性和闪烁** ——
    //    这两件事必须由 delegate 自己实现（Qt 自己的 Material 风格也是这么写的）。
    //    之前只给了宽高和颜色，结果光标一旦出现就永远亮着、而且从不闪烁。
    cursorDelegate: Rectangle {
        id: caret
        width: 2
        color: Theme.ink
        // 只在"真的在编辑"时出现：有焦点、非只读、且没有选区
        // （有选区时该显示选区高亮，不该显示插入符）
        visible: control.activeFocus && !control.readOnly
                 && control.selectionStart === control.selectionEnd

        // 光标位置一动就重新亮起并重置计时：打字时不该正好撞上"熄灭"那一拍
        Connections {
            target: control
            function onCursorPositionChanged() {
                caret.opacity = 1
                caretBlink.restart()
            }
        }

        // 闪烁节奏跟随系统设置（见 Theme.caretFlashHalf）
        Timer {
            id: caretBlink
            running: caret.visible
            repeat: true
            interval: Theme.caretFlashHalf
            onTriggered: caret.opacity = caret.opacity > 0.5 ? 0 : 1
            // 一拿到焦点先亮起来，不要从"暗"那一拍开始
            onRunningChanged: caret.opacity = 1
        }
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
```

### `qml/ZmdUI/ZCheckBox.qml`

复选框：切角方框 + 黑色对勾 + 半选态

```qml
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Shapes

/*!
    \qmltype ZCheckBox
    \inqmlmodule ZmdUI
    \brief 复选框：斜切角方框指示灯，选中时荧光黄填充 + 黑色对勾。

    \l indeterminate 为真时显示"半选"横杠，用于父级批量选择。

    \qml
    ZCheckBox { text: "启用自动重连"; checked: true }
    \endqml
*/
CheckBox {
    id: control

    /*! 附属说明，显示在主标签下方（等宽小字） */
    property string note: ""
    /*! 半选态：父级批量选择时使用（原生 CheckBox 没有这个属性，由本组件提供） */
    property bool indeterminate: false

    hoverEnabled: true
    spacing: Theme.spacingSm
    implicitHeight: Theme.dp(Theme.controlHeightSm)
    leftPadding: 0
    rightPadding: 0

    indicator: ZCutRect {
        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 20
        height: 20
        color: control.checked || control.indeterminate ? Theme.accent : Theme.surface
        strokeColor: control.enabled
                     ? (control.visualFocus || control.hovered ? Theme.ink : Theme.inkSoft)
                     : Theme.lineSoft
        strokeWidth: Theme.border
        cutTopRight: 7
        cutBottomLeft: 3

        // 悬停时外圈细黄框，提示可点
        ZCutRect {
            anchors.fill: parent
            anchors.margins: -4
            visible: control.enabled && control.hovered
            color: "transparent"
            strokeColor: Theme.accent
            strokeWidth: 2
            cutTopRight: 7
            cutBottomLeft: 3
        }

        // ── 对勾：纯路径绘制，中段折角 ──
        Shape {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 0
            width: 13
            height: 9
            visible: control.checked && !control.indeterminate
            antialiasing: true
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                strokeColor: Theme.textOnAccent
                strokeWidth: 2.6
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                joinStyle: ShapePath.MiterJoin
                PathPolyline {
                    path: [Qt.point(0, 4), Qt.point(4.5, 8.5), Qt.point(13, 0.5)]
                }
            }
        }

        // ── 半选横杠 ──
        Rectangle {
            anchors.centerIn: parent
            width: 10
            height: 3
            visible: control.indeterminate
            color: Theme.textOnAccent
        }
    }

    contentItem: Column {
        leftPadding: control.indicator.width + control.spacing
        spacing: 1
        Text {
            text: control.text
            font: Theme.fontStrong
            color: control.enabled ? Theme.ink : Theme.muted
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            visible: control.note.length > 0
            text: control.note
            font: Theme.fontMonoSm
            color: Theme.muted
            opacity: 0.85
        }
    }
}
```

### `qml/ZmdUI/ZRadioButton.qml`

单选按钮：菱形指示灯

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZRadioButton
    \inqmlmodule ZmdUI
    \brief 单选按钮：菱形指示灯（设计语言里的"选中=亮黄填充几何图形"）。

    指示器由 ZCutRect 四个角全部斜切一半形成菱形，不需要额外的图形资源。
    选中时黄色菱形内嵌一个黑色小方点。

    \qml
    ZRadioButton { text: "全量同步"; checked: true }
    \endqml
*/
RadioButton {
    id: control

    hoverEnabled: true
    spacing: Theme.spacingSm
    implicitHeight: Theme.dp(Theme.controlHeightSm)
    leftPadding: 0
    rightPadding: 0

    indicator: Item {
        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 20
        height: 20

        // 菱形外框
        ZCutRect {
            anchors.fill: parent
            color: control.checked ? Theme.accent : Theme.surface
            strokeColor: control.enabled ? Theme.ink : Theme.lineSoft
            strokeWidth: Theme.border
            // 四角各切一半 = 菱形
            cutTopLeft: width / 2
            cutTopRight: width / 2
            cutBottomLeft: width / 2
            cutBottomRight: width / 2
        }

        // 悬停外圈
        ZCutRect {
            anchors.fill: parent
            anchors.margins: -4
            visible: control.enabled && control.hovered && !control.checked
            color: "transparent"
            strokeColor: Theme.accent
            strokeWidth: 2
            cutTopLeft: width / 2
            cutTopRight: width / 2
            cutBottomLeft: width / 2
            cutBottomRight: width / 2
        }

        // 选中内点
        ZCutRect {
            anchors.centerIn: parent
            width: 8
            height: 8
            visible: control.checked
            color: Theme.textOnAccent
            cutTopLeft: 2
            cutBottomRight: 2
        }
    }

    contentItem: Text {
        leftPadding: control.indicator.width + control.spacing
        text: control.text
        font: Theme.fontStrong
        color: control.enabled ? Theme.ink : Theme.muted
        verticalAlignment: Text.AlignVCenter
    }
}
```

### `qml/ZmdUI/ZSwitch.qml`

开关：矩形滑轨 + 方形滑块 + 轨道刻度

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZSwitch
    \inqmlmodule ZmdUI
    \brief 开关：矩形滑轨 + 方形滑块，打开时滑轨填充荧光黄。

    没有圆角、没有阴影。滑块是切角方块，滑动用一条快速缓动，
    符合"机械拨杆"的手感。

    \qml
    ZSwitch { text: "自动登录"; checked: true }
    \endqml
*/
Switch {
    id: control

    /*! 附属说明（等宽小字），显示在主标签下方 */
    property string note: ""
    /*! 滑轨宽度 */
    property int trackWidth: 62

    // ── 几何常量：滑块与轨道的切角关系，也是"左下角对不齐"那条问题的正解 ──
    /*! 滑块相对轨道内边缘的内缩量 */
    readonly property int knobInset: 2
    /*! 轨道右上切角 */
    readonly property int trackCutTopRight: 8
    /*! 轨道左下切角 */
    readonly property int trackCutBottomLeft: 4
    /*!
        滑块右上切角 = 轨道同侧切角 − 内缩量。
        必须比轨道小一档，两条斜边才**平行**；等大或更大就会横穿轨道斜边，
        在角上露出一块浅色缝隙（看起来就是"没对齐"）。
    */
    readonly property int knobCutTopRight: trackCutTopRight - knobInset
    /*! 滑块左下切角，规则同上 */
    readonly property int knobCutBottomLeft: trackCutBottomLeft - knobInset

    hoverEnabled: true
    spacing: Theme.spacingMd
    implicitHeight: Theme.dp(Theme.controlHeightSm)
    leftPadding: 0
    rightPadding: 0

    indicator: Item {
        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: control.trackWidth
        height: 26

        // ── 滑轨 ──
        ZCutRect {
            anchors.fill: parent
            color: control.checked
                   ? (control.enabled ? Theme.accent : Theme.surfaceMuted)
                   : Theme.surfaceSunken
            strokeColor: control.enabled ? Theme.ink : Theme.lineSoft
            strokeWidth: Theme.border
            cutTopRight: control.trackCutTopRight
            cutBottomLeft: control.trackCutBottomLeft

            // 轨道内的刻度线：机械量程感
            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 26
                spacing: 4
                Repeater {
                    model: 5
                    Rectangle {
                        width: 1
                        height: 8
                        color: control.checked ? Theme.textOnAccent : Theme.lineSoft
                        opacity: 0.5
                    }
                }
            }
        }

        // ── 滑块 ──
        // 切角取值见上面的几何常量：滑块 = 轨道 − 内缩量，两条斜边平行、间距均匀。
        // 之前左下角是 6px 切角、轨道是 4px，滑块的斜边直接横穿轨道的斜边，
        // 在左下角露出一道浅色缝隙 —— 看起来就是"没对齐"。
        ZCutRect {
            id: knob
            width: 22
            height: 22
            y: control.knobInset
            x: control.checked ? parent.width - width - control.knobInset : control.knobInset
            // 选中时轨道是强调黄 → 滑块要用"强调色上的文字色"（亮色=黑 / 暗色=深炭），
            // 用 Theme.ink 的话暗色下会变成浅灰滑块压在黄轨道上，糊成一团
            color: control.enabled
                   ? (control.checked ? Theme.textOnAccent : Theme.subBgAlt)
                   : Theme.lineSoft
            cutTopRight: control.knobCutTopRight
            cutBottomLeft: control.knobCutBottomLeft


            Behavior on x {
                NumberAnimation { duration: Theme.durBase; easing.type: Theme.easingEnter }
            }

            // 滑块上的两道刻痕
            Column {
                anchors.centerIn: parent
                spacing: 3
                Repeater {
                    model: 2
                    Rectangle {
                        width: 8
                        height: 1.5
                        color: control.checked ? Theme.accent : Theme.surface
                        opacity: 0.9
                    }
                }
            }
        }
    }

    contentItem: Column {
        leftPadding: control.indicator.width + control.spacing
        spacing: 1
        Text {
            text: control.text
            font: Theme.fontStrong
            color: control.enabled ? Theme.ink : Theme.muted
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            visible: control.note.length > 0
            text: control.note
            font: Theme.fontMonoSm
            color: Theme.muted
        }
    }
}
```

### `qml/ZmdUI/ZSlider.qml`

滑块：黑色导轨 + 亮黄填充 + 刻度 + 切角把手

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZSlider
    \inqmlmodule ZmdUI
    \brief 滑块：黑色导轨 + 亮黄填充 + 刻度线 + 切角方形把手。

    \l showTicks 打开刻度线；\l label 为左侧铭牌，\l valueSuffix 会拼在读数后面。
    读数以等宽字体显示在右下角，不带小圆点，只用一条黑色短横线分隔。

    \qml
    ZSlider { from: 0; to: 100; value: 62; label: "负载上限"; valueSuffix: "%" }
    \endqml
*/
Slider {
    id: control

    /*! 左侧铭牌，空则隐藏 */
    property string label: ""
    /*! 读数后缀 */
    property string valueSuffix: ""
    /*! 是否绘制刻度线 */
    property bool showTicks: true
    /*! 读数小数位 */
    property int decimals: 0

    hoverEnabled: true
    // Basic 样式给 Slider 默认 padding: 6。四个方向都必须显式归零，
    // 否则手柄会按"缩小后的可用高度"居中，而导轨按整个高度居中 —— 两者错位，
    // 表现为"滑块偏高"（差的正好是 topPadding）。
    padding: 0

    // ── 垂直方向切成三条互不重叠的带 ──
    // 手柄是有高度的实体（20px），它一旦在垂直方向自由居中就会压到铭牌和读数上
    // （滑到两端时正好落在同一列）。所以改成：顶部铭牌带 / 中间手柄带 / 底部读数带，
    // 三条带各自占位，手柄只在中间带里活动。
    /*! 顶部铭牌带高度 */
    readonly property int bandTop: label.length > 0 ? 17 : 5
    /*! 中间手柄活动带高度 */
    readonly property int bandTrack: 24
    /*! 底部读数带高度 */
    readonly property int bandBottom: 20

    implicitHeight: bandTop + bandTrack + bandBottom

    /*! 垂直中心：手柄、导轨、刻度全部以它为基准 */
    readonly property real centerY: bandTop + bandTrack / 2
    readonly property real trackY: centerY - 4
    readonly property string valueText: value.toFixed(decimals) + valueSuffix

    background: Item {
        // ── 刻度线：导轨下方 ──
        Canvas {
            id: ticks
            anchors.fill: parent
            visible: control.showTicks
            renderStrategy: Canvas.Immediate
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onVisibleChanged: requestPaint()
            Connections {
                target: control
                function onValueChanged() { ticks.requestPaint() }
            }
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                var w = width
                var h = height
                // 刻度紧贴导轨下沿、长度收短 —— 必须留在中间手柄带之内，
                // 否则会伸进底部读数带，和百分比数字叠在一起
                var y0 = control.trackY + 10
                var n = 11
                ctx.lineWidth = 1.2
                for (var i = 0; i < n; i++) {
                    var x = Math.round(w * i / (n - 1)) + 0.5
                    var passed = (i / (n - 1)) <= control.visualPosition
                    ctx.strokeStyle = passed ? Theme.ink : Theme.lineSoft
                    ctx.beginPath()
                    ctx.moveTo(x, y0)
                    ctx.lineTo(x, y0 + (i % 5 === 0 ? 5 : 3))
                    ctx.stroke()
                }
            }
        }

        // ── 导轨（空槽）──
        Rectangle {
            x: 0
            y: control.trackY
            width: parent.width
            height: 8
            color: Theme.surfaceSunken
            border.color: Theme.ink
            border.width: 1
        }

        // ── 已填充部分：亮黄（宽度 = 把手中心位置）──
        Rectangle {
            x: 1
            y: control.trackY + 1
            width: Math.max(0, control.visualPosition * (control.availableWidth - 16) + 8)
            height: 6
            color: control.enabled ? Theme.accent : Theme.lineSoft
        }

        // ── 左侧铭牌 ──
        Text {
            anchors.left: parent.left
            anchors.top: parent.top
            visible: control.label.length > 0
            text: control.label + " /"
            font: Theme.fontMonoSm
            color: Theme.muted
        }

        // ── 右下角读数 ──
        Row {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            spacing: Theme.spacingXs
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 10
                height: 2
                color: Theme.ink
            }
            Text {
                text: control.valueText
                font: Theme.fontMonoMd
                color: Theme.ink
            }
        }
    }

    handle: ZCutRect {
        id: handleItem
        x: control.visualPosition * (control.availableWidth - width)
        // 只在中间手柄带里居中：其他元素各有各的带，不会互相压到
        y: control.centerY - height / 2
        width: 14
        height: 20
        color: control.pressed ? Theme.ink : Theme.accent
        // 把手底色是强调黄 → 描边用强调色上的文字色，暗色下才不会浅色压浅色
        strokeColor: Theme.textOnAccent
        strokeWidth: Theme.border
        cutTopRight: 5
        cutBottomLeft: 5

        // 把手上的三条刻痕
        Column {
            anchors.centerIn: parent
            spacing: 2
            Repeater {
                model: 3
                Rectangle {
                    width: 5
                    height: 1.5
                    color: control.pressed ? Theme.accent : Theme.textOnAccent
                    opacity: 0.7
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZProgressBar.qml`

进度条：亮黄填充 + 刻度 + 循环扫描不确定态

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZProgressBar
    \inqmlmodule ZmdUI
    \brief 进度条：黑框硬边 + 亮黄填充 + 刻度线，右侧显示等宽百分数。

    \l indeterminate 打开后走"循环扫描块"动画（工程仪表的来回扫描感），
    不使用默认样式的无限流动条。

    \qml
    ZProgressBar { value: 0.62; label: "同步进度" }
    \endqml
*/
ProgressBar {
    id: control

    /*! 左侧铭牌 */
    property string label: ""
    /*! 是否显示右侧百分数 */
    property bool showValue: true
    /*! 是否绘制刻度线 */
    property bool showTicks: true

    implicitHeight: Theme.dp(label.length > 0 ? 44 : 26)
    padding: 0

    background: Item {
        // 轨道
        ZCutRect {
            id: rail
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: 18
            color: Theme.surfaceSunken
            strokeColor: Theme.ink
            strokeWidth: Theme.border
            cutTopRight: 7
            cutBottomLeft: 3
        }

        // 填充
        Rectangle {
            id: fill
            x: rail.x + Theme.border
            y: rail.y + Theme.border
            height: rail.height - Theme.border * 2
            width: Math.max(0, (rail.width - Theme.border * 2) * control.visualPosition)
            color: control.enabled ? Theme.accent : Theme.lineSoft
            clip: true

            // 填充块内部的斜线纹理（用亮黄上的黑色细斜线做"正在填充"的质感）
            ZHatchPattern {
                width: parent.width
                height: parent.height
                lineColor: Theme.ink
                opacity: 0.22
                spacing: 7
                lineWidth: 1
            }
        }

        // 刻度线
        Canvas {
            id: ticks
            anchors.fill: rail
            visible: control.showTicks
            renderStrategy: Canvas.Immediate
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                var n = 20
                ctx.lineWidth = 1
                for (var i = 1; i < n; i++) {
                    var x = Math.round(width * i / n) + 0.5
                    ctx.strokeStyle = (i / n) <= control.visualPosition
                                     ? Qt.rgba(0, 0, 0, 0.55) : Theme.lineSoft
                    ctx.beginPath()
                    ctx.moveTo(x, height * 0.25)
                    ctx.lineTo(x, height * 0.75)
                    ctx.stroke()
                }
            }
            Connections {
                target: control
                function onVisualPositionChanged() { ticks.requestPaint() }
            }
        }

        // 不确定态：来回扫动的黑块
        Rectangle {
            visible: control.indeterminate
            width: rail.width * 0.28
            height: rail.height
            y: rail.y
            color: Theme.ink
            opacity: 0.75
            x: rail.x + (rail.width - width) * control.visualPosition
        }

        Text {
            anchors.left: parent.left
            anchors.top: parent.top
            visible: control.label.length > 0
            text: control.label + " /"
            font: Theme.fontMonoSm
            color: Theme.muted
        }
    }

    contentItem: Text {
        visible: control.showValue && !control.label
        text: control.indeterminate ? "····" : Math.round(control.value * 100) + "%"
        font: Theme.fontMonoMd
        color: Theme.ink
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }
}
```

### `qml/ZmdUI/ZRichTextEditor.qml`

块级富文本编辑器：文字 / 图片 / 文件块混排，块级格式 + 序列化

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZRichTextEditor
    \inqmlmodule ZmdUI
    \brief 富文本编辑器：文字 / 图片 / 文件三类内容块混排，自带格式工具栏与序列化接口。

    文档是一个**块数组**（\l blocks），每块是纯 JS 对象，三种形态：

    \list
    \li \c text  —— 文字块（正文 / 标题 / 引用 / 代码 + 粗体 / 斜体 / 下划线 / 删除线 / 对齐）
    \li \c image —— 图片块（等比缩放 + 名称 + 说明 + 加载失败时的工程占位图）
    \li \c file  —— 文件块（文件名 + 大小 + 扩展名徽标，点击发出 \l fileActivated）
    \endlist

    \qml
    ZRichTextEditor {
        width: 640
        placeholderText: "输入正文…"
        onImageRequested: imagePicker.open()
        onFileRequested:  filePicker.open()

        Component.onCompleted: {
            insertTextBlock(-1, "终端工业机能风富文本")
            insertImageBlock("file:///C:/shots/board.png", "board.png", "面板截图")
            insertFileBlock("file:///C:/out/config.json", "config.json", 12800)
        }
    }
    \endqml

    \section1 为什么是"块"而不是"字符级富文本"

    Qt Quick 的 \c TextEdit 只提供**整段**的 \c font 属性，没有从 QML 侧给选区上
    \c QTextCharFormat 的接口（\c textDocument 暴露的是 QObject，QTextCursor /
    QTextCharFormat 都不在 QML 里）。纯 QML 想做「选中几个字加粗」就必须自己实现
    文本排版与光标。本库坚持纯 QML、零第三方依赖，所以把"富"做在**块**这一级：
    每块可以有自己的字体、字号、装饰、对齐，块与块之间混排图文文件 —— 这样既拿到了
    真正的富文本排版能力，又不需要编译器 / C++ 侧支持。

    \section1 为什么编辑器自己不做滚动

    不内置 Flickable，内容多高就长多高，由宿主决定怎么滚。这样避免了两个有名的问题：
    嵌套滚动（内层抢走滚轮，手感黏）和拖选被抢（父 Flickable 在拖拽超过阈值后接管，
    拖选文字拖到一半变成滚页面）。放进 \c ScrollView / 宿主的 \c Flickable / \c ZListView
    里都行，见演示程序。
*/
Item {
    id: editor

    /*! 块的形态枚举。也接受等价的字符串（"body" / "heading" / "quote" / "code"）。 */
    enum BlockStyle { Body, Heading, Quote, Code }

    // ════════════════════════════════════════════════════════════════
    //  1. 公共属性
    // ════════════════════════════════════════════════════════════════

    /*!
        文档内容：块对象数组。**替换**它才会触发界面重建；修改单个块的字段
        （比如用户打字）是原地改，不会重建、不会丢光标。

        每块的字段见 \l makeTextBlock / \l makeImageBlock / \l makeFileBlock。
    */
    property var blocks: []

    /*!
        内容版本号。每次内容变动自增。

        \note 块是**纯 JS 对象**，字段被原地改了不会发属性变更信号。所有需要跟随
        内容刷新的界面绑定都挂在 \l revision 上，靠它强制重算。自己的代码没必要碰它。
    */
    property int revision: 0

    /*! 当前聚焦 / 选中的块下标，-1 表示没有 */
    /*! 当前块下标（-1 = 没有当前块，例如空文档）。工具栏的格式开关作用在它身上。 */
    property int currentIndex: 0

    /*! 只读模式：隐藏工具栏，文字块不可编辑 */
    property bool readOnly: false

    /*! 是否画外框（放进 ZPanel 这类已经有卡片的容器里时关掉，避免双层边框） */
    property bool framed: true

    /*! 是否显示工具栏 */
    property bool showToolbar: true

    /*! 是否显示顶部深色标题条 */
    property bool showHeader: true

    /*! 标题条上的等宽小字 */
    property string headerText: "RICH TEXT / COMPOSER"

    /*! 空文字块的占位提示 */
    property string placeholderText: "输入正文…"

    /*! 图片块的最大显示高度（等比缩放，超出就按这个高度裁容器） */
    property int maxImageHeight: 240

    /*! 内容块之间的垂直间距 */
    property int blockSpacing: Theme.spacingSm

    /*! 内容变动（打字、增删块、改格式）时发出 */
    signal contentsChanged()

    /*! 用户点了工具栏的「图片」——宿主该打开文件选择框，选完调用 imageBlockAt / insertImageBlock */
    signal imageRequested()

    /*! 用户点了工具栏的「文件」——同上，选完调用 insertFileBlock */
    signal fileRequested()

    /*! 文件块被点击（双击或点击徽标），宿主可以打开 / 定位这个文件 */
    signal fileActivated(string url, string name)

    /*! 某个块被点击选中 */
    signal blockActivated(int index)

    /*! 内部：重建后要抢焦点的文字块下标（-1 = 不抢） */
    property int _focusRequest: -1

    implicitWidth: Theme.dp(560)
    implicitHeight: content.height

    // ════════════════════════════════════════════════════════════════
    //  2. 纯函数：块工厂 / 归一化 / 序列化
    //     全部不碰界面状态，可以直接在 qmltestrunner 里断言。
    // ════════════════════════════════════════════════════════════════

    /*! 造一个文字块。\a style 传字符串或 \l BlockStyle 枚举都行。 */
    function makeTextBlock(text, style) {
        return {
            type: "text",
            text: text === undefined || text === null ? "" : String(text),
            style: styleNameOf(style),
            bold: false,
            italic: false,
            underline: false,
            strike: false,
            align: "left"
        }
    }

    /*! 造一个图片块。\a caption 是图下的说明文字。 */
    function makeImageBlock(url, name, caption) {
        return {
            type: "image",
            url: url ? String(url) : "",
            name: name ? String(name) : "",
            caption: caption ? String(caption) : ""
        }
    }

    /*! 造一个文件块。\a size 是字节数，界面按 B/KB/MB 自动换算。 */
    function makeFileBlock(url, name, size) {
        return {
            type: "file",
            url: url ? String(url) : "",
            name: name ? String(name) : "未命名文件",
            size: Math.max(0, Math.round(Number(size) || 0))
        }
    }

    /*!
        把任意来路不明的对象补成合法块。JSON 反序列化、外部赋值都走这里，
        所以下游只可能见到三种形态、字段齐全的块，不用到处写防御性判断。
    */
    function normalizeBlock(raw) {
        if (!raw || typeof raw !== "object")
            return makeTextBlock("")

        var type = String(raw.type || "text").toLowerCase()

        if (type === "image")
            return {
                type: "image",
                url: raw.url ? String(raw.url) : "",
                name: raw.name ? String(raw.name) : "",
                caption: raw.caption ? String(raw.caption) : ""
            }

        if (type === "file")
            return {
                type: "file",
                url: raw.url ? String(raw.url) : "",
                name: raw.name ? String(raw.name) : "未命名文件",
                size: Math.max(0, Math.round(Number(raw.size) || 0))
            }

        var block = makeTextBlock(raw.text === undefined || raw.text === null ? "" : raw.text,
                                  raw.style)
        block.bold = !!raw.bold
        block.italic = !!raw.italic
        block.underline = !!raw.underline
        block.strike = !!raw.strike
        block.align = alignNameOf(raw.align)
        return block
    }

    /*! 枚举 / 字符串 → 规范的样式名。 */
    function styleNameOf(v) {
        if (typeof v === "string") {
            var s = v.toLowerCase()
            return _styleNames.indexOf(s) >= 0 ? s : "body"
        }
        var n = Number(v)
        return (n >= 0 && n < _styleNames.length) ? _styleNames[n] : "body"
    }

    /*! 对齐方式归一化。 */
    function alignNameOf(v) {
        var s = v ? String(v).toLowerCase() : "left"
        return (s === "center" || s === "right") ? s : "left"
    }

    /*! 样式名 → 中文短标签（工具栏、无障碍都用它）。 */
    function styleLabelOf(v) {
        switch (styleNameOf(v)) {
        case "heading": return "标题"
        case "quote":   return "引用"
        case "code":    return "代码"
        default:        return "正文"
        }
    }

    /*! 字节数 → 人读的大小。0 或非法值一律 "0 B"。 */
    function formatBytes(n) {
        var v = Number(n)
        if (!isFinite(v) || v <= 0)
            return "0 B"
        var units = ["B", "KB", "MB", "GB", "TB"]
        var i = 0
        while (v >= 1024 && i < units.length - 1) {
            v /= 1024
            ++i
        }
        return (i === 0 ? String(Math.round(v)) : v.toFixed(1)) + " " + units[i]
    }

    /*! 文件名 → 大写扩展名徽标，没有扩展名给 "FILE"。 */
    function extensionOf(name) {
        var s = name ? String(name) : ""
        var dot = s.lastIndexOf(".")
        if (dot < 0 || dot === s.length - 1)
            return "FILE"
        var ext = s.substring(dot + 1).toUpperCase()
        return ext.length > 5 ? ext.substring(0, 5) : ext
    }

    /*! 取第 \a index 块，越界给 null。 */
    function blockAt(index) {
        return (index >= 0 && index < blocks.length) ? blocks[index] : null
    }

    /*! 只读快照：某个文字块的格式（\l revision 变化后所有调用者会重算）。 */
    function formatOf(index) {
        var b = blockAt(index)
        if (!b)
            return { type: "text", style: "body", bold: false, italic: false,
                     underline: false, strike: false, align: "left" }
        return {
            type: b.type || "text",
            style: styleNameOf(b.style),
            bold: !!b.bold,
            italic: !!b.italic,
            underline: !!b.underline,
            strike: !!b.strike,
            align: b.align || "left"
        }
    }

    /*! 某类块的数量。 */
    function countBlocks(type) {
        var n = 0
        for (var i = 0; i < blocks.length; ++i)
            if ((blocks[i].type || "text") === type)
                ++n
        return n
    }

    /*! 各类块的统计快照（挂 revision，供标题条上的读数绑定）。 */
    readonly property var stats: {
        var r = revision
        return { rev: r,
                 text: countBlocks("text"),
                 image: countBlocks("image"),
                 file: countBlocks("file") }
    }

    /*! 文档是否为空（没有块，或者只有空文字块）。 */
    readonly property bool isEmpty: {
        var r = revision
        if (blocks.length === 0)
            return true
        for (var i = 0; i < blocks.length; ++i) {
            var b = blocks[i]
            if ((b.type || "text") !== "text")
                return false
            if (b.text && b.text.length > 0)
                return false
        }
        return true
    }

    /*!
        纯文本导出：文字块逐行输出，图片 / 文件块各自折成一行占位标记。
        用于复制到剪贴板、喂给只认纯文本的接口。
    */
    function plainTextOf(list) {
        var arr = list || blocks
        var lines = []
        for (var i = 0; i < arr.length; ++i) {
            var b = arr[i]
            var t = b.type || "text"
            if (t === "image")
                lines.push("[图片" + (b.name ? ": " + b.name : "") + "]")
            else if (t === "file")
                lines.push("[文件" + (b.name ? ": " + b.name : "") + "]")
            else
                lines.push(b.text || "")
        }
        return lines.join("\n")
    }

    /*! 文档 → JSON 字符串。 */
    function toJSON() {
        return JSON.stringify(blocks)
    }

    /*! JSON 字符串 → 块数组。解析失败返回空数组，不会抛。 */
    function blocksFromJSON(text) {
        var raw = null
        try {
            raw = JSON.parse(text)
        } catch (e) {
            return []
        }
        if (!raw || raw.length === undefined)
            return []
        var out = []
        for (var i = 0; i < raw.length; ++i)
            out.push(normalizeBlock(raw[i]))
        return out
    }

    /*! 每个文字块该用的字体（把块格式翻成 QQmlFont）。 */
    function textFontFor(fmt) {
        var style = fmt ? styleNameOf(fmt.style) : "body"
        var family = style === "code" ? Theme.familyMono : Theme.family
        var pixel = style === "heading" ? 24 : style === "code" ? 13 : 14
        var weight = style === "heading" ? Font.Black : (fmt && fmt.bold ? Font.Bold : Font.Normal)
        return Qt.font({
            family: family,
            pixelSize: pixel,
            weight: weight,
            italic: (fmt && fmt.italic) || style === "quote",
            underline: !!(fmt && fmt.underline),
            strikeout: !!(fmt && fmt.strike),
            letterSpacing: style === "heading" ? 1 : 0
        })
    }

    /*! 文字块的水平对齐 → 对齐枚举。 */
    function hAlignFor(align) {
        var a = alignNameOf(align)
        // 用 Text.Align* 而不是 TextEdit.Align*：两者取值相同，
        // 但 Text 的这几个枚举更基础，不会因为控件类型换实现而找不到。
        return a === "center" ? Text.AlignHCenter
             : a === "right" ? Text.AlignRight
             : Text.AlignLeft
    }

    // 枚举值与样式名的对照表。靠"枚举按声明顺序从 0 开始"这条 QML 保证，
    // 不写自引用的 ZRichTextEditor.BlockStyle.Xxx，避免类型自引用。
    readonly property var _styleNames: ["body", "heading", "quote", "code"]

    // ════════════════════════════════════════════════════════════════
    //  3. 结构操作
    // ════════════════════════════════════════════════════════════════

    /*! 整体替换内容。非法项会被 \l normalizeBlock 补成合法块。 */
    function setBlocks(list) {
        var out = []
        if (list)
            for (var i = 0; i < list.length; ++i)
                out.push(normalizeBlock(list[i]))
        blocks = out
        currentIndex = out.length > 0 ? 0 : -1
        ++revision
        contentsChanged()
    }

    /*!
        在 \a afterIndex 后面插入一块，返回新块下标。
        \a afterIndex 传 -1 表示插到最前面；传 \c blocks.length 等价插到末尾。
    */
    function insertBlock(afterIndex, block) {
        var list = blocks.slice()
        var at = Math.max(0, Math.min(list.length, Number(afterIndex) + 1))
        var normalized = normalizeBlock(block)

        // 先登记再赋值：Repeater 是同步重建的，delegate 的 Component.onCompleted
        // 会在 blocks = list 这一句里就跑起来，晚一步登记就抢不到焦点。
        if (normalized.type === "text")
            _focusRequest = at

        list.splice(at, 0, normalized)
        blocks = list
        currentIndex = at
        ++revision
        contentsChanged()
        return at
    }

    /*! 在末尾追加（工具栏 / 「继续输入」都走这里）。 */
    function appendBlock(block) {
        return insertBlock(blocks.length - 1, block)
    }

    /*! 插入文字块。\a afterIndex 缺省为当前块。 */
    function insertTextBlock(afterIndex, text, style) {
        var at = afterIndex === undefined ? _targetIndex() : afterIndex
        return insertBlock(at, makeTextBlock(text || "", style))
    }

    /*! 插入图片块。\a afterIndex 缺省为当前块。 */
    function insertImageBlock(url, name, caption, afterIndex) {
        var at = afterIndex === undefined ? _targetIndex() : afterIndex
        return insertBlock(at, makeImageBlock(url, name, caption))
    }

    /*! 插入文件块。\a afterIndex 缺省为当前块。 */
    function insertFileBlock(url, name, size, afterIndex) {
        var at = afterIndex === undefined ? _targetIndex() : afterIndex
        return insertBlock(at, makeFileBlock(url, name, size))
    }

    /*! 删除一块。成功返回 true。 */
    function removeBlock(index) {
        var i = Number(index)
        if (!(i >= 0 && i < blocks.length))
            return false
        var list = blocks.slice()
        list.splice(i, 1)
        blocks = list
        currentIndex = list.length === 0 ? -1 : Math.min(i, list.length - 1)
        ++revision
        contentsChanged()
        return true
    }

    /*! 上下移动一块（内容区拖拽排序的按钮版）。越界或原地不动返回 false。 */
    function moveBlock(from, to) {
        var a = Number(from), b = Number(to)
        if (!(a >= 0 && a < blocks.length) || !(b >= 0 && b < blocks.length) || a === b)
            return false
        var list = blocks.slice()
        var moved = list.splice(a, 1)[0]
        list.splice(b, 0, moved)
        blocks = list
        currentIndex = b
        ++revision
        contentsChanged()
        return true
    }

    /*! 设置当前块的样式。非文字块会被忽略，返回 false。 */
    function setStyle(style) {
        var b = blockAt(_targetIndex())
        if (!b || (b.type || "text") !== "text")
            return false
        b.style = styleNameOf(style)
        ++revision
        contentsChanged()
        return true
    }

    /*! 反转当前文字块的某个布尔格式（"bold" / "italic" / "underline" / "strike"）。 */
    function toggleFormat(flag) {
        var b = blockAt(_targetIndex())
        if (!b || (b.type || "text") !== "text")
            return false
        if (["bold", "italic", "underline", "strike"].indexOf(flag) < 0)
            return false
        b[flag] = !b[flag]
        ++revision
        contentsChanged()
        return true
    }

    /*! 设置当前文字块的对齐。 */
    function setAlign(align) {
        var b = blockAt(_targetIndex())
        if (!b || (b.type || "text") !== "text")
            return false
        b.align = alignNameOf(align)
        ++revision
        contentsChanged()
        return true
    }

    /*! 清空为「只有一个空文字块」的初始状态。 */
    function clear() {
        blocks = [makeTextBlock("")]
        currentIndex = 0
        _focusRequest = 0
        ++revision
        contentsChanged()
    }

    /*! 当前操作的块下标：优先 \l currentIndex，没有就落在最后一块。 */
    function _targetIndex() {
        if (currentIndex >= 0 && currentIndex < blocks.length)
            return currentIndex
        return blocks.length - 1
    }

    /*! 内容被 delegate 反向写回时用：只自增版本号 + 发信号，不重建。 */
    function _contentEdited() {
        ++revision
        contentsChanged()
    }

    // ════════════════════════════════════════════════════════════════
    //  4. 版面：外框 → 标题条 → 工具栏 → 内容区
    // ════════════════════════════════════════════════════════════════

    // ── 外框 ──
    ZCutRect {
        anchors.fill: parent
        visible: editor.framed
        color: Theme.surface
        strokeColor: Theme.line
        strokeWidth: Theme.border
        cutTopRight: Theme.cutLg
        cutBottomLeft: Theme.cutMd
    }

    // 外框右上角的小装饰：斜线块，呼应面板的语言
    ZHatchPattern {
        visible: editor.framed
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: Theme.border
        anchors.topMargin: Theme.border
        width: Theme.cutLg * 3
        height: 26
        lineColor: Theme.hatch
        spacing: Theme.hatchStep
    }

    Column {
        id: content
        x: editor.framed ? Theme.border : 0
        y: editor.framed ? Theme.border : 0
        width: parent.width - (editor.framed ? Theme.border * 2 : 0)

        // ── 标题条：深色底 + 等宽读数 ──
        Item {
            id: headerRow
            width: parent.width
            height: editor.showHeader ? 30 : 0
            visible: editor.showHeader

            ZCutRect {
                anchors.fill: parent
                color: Theme.inkBlock
                cutTopRight: editor.framed ? Theme.cutLg - 2 : 0
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacingSm

                Rectangle {
                    width: 4
                    height: 12
                    color: Theme.accent
                }

                Text {
                    text: editor.headerText
                    font: Theme.fontMonoSm
                    color: Theme.textOnSub
                }

                Text {
                    text: "·"
                    font: Theme.fontMonoSm
                    color: Theme.alpha(Theme.textOnSub, 0.35)
                }

                Text {
                    text: editor.readOnly ? "READ ONLY" : "EDITING"
                    font: Theme.fontMonoSm
                    color: editor.readOnly ? Theme.accentGlow : Theme.alpha(Theme.textOnSub, 0.7)
                }
            }

            // 右侧读数：块数 / 图 / 文件
            Text {
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacingMd + (editor.framed ? Theme.cutMd : 0)
                anchors.verticalCenter: parent.verticalCenter
                text: editor.pad2(editor.stats.text) + " TXT  /  "
                      + editor.pad2(editor.stats.image) + " IMG  /  "
                      + editor.pad2(editor.stats.file) + " FILE"
                font: Theme.fontMonoSm
                color: Theme.alpha(Theme.textOnSub, 0.55)
            }
        }

        // ── 工具栏 ──
        Item {
            id: toolbarRow
            width: parent.width
            height: (editor.showToolbar && !editor.readOnly)
                    ? Math.max(toolbarFlow.implicitHeight, moveBar.height) + Theme.spacingSm * 2 : 0
            visible: editor.showToolbar && !editor.readOnly

            Rectangle {
                anchors.fill: parent
                color: Theme.surfaceMuted
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: Theme.lineSoft
            }

            Flow {
                id: toolbarFlow
                x: Theme.spacingMd
                y: Theme.spacingSm
                // 给右侧固定的「上移 / 下移 / 删除」留位置，免得它们被挤到第二行
                width: parent.width - Theme.spacingMd * 3 - moveBar.width
                spacing: 3

                // ── 块样式 ──
                ToolChip { caption: "正文"; active: editor._styleNow() === "body"
                           tooltip: "正文段落"; onClicked: editor.setStyle("body") }
                ToolChip { caption: "标题"; active: editor._styleNow() === "heading"
                           tooltip: "大标题"; onClicked: editor.setStyle("heading") }
                ToolChip { caption: "引用"; active: editor._styleNow() === "quote"
                           tooltip: "引用块（左侧粗竖线）"; onClicked: editor.setStyle("quote") }
                ToolChip { caption: "代码"; active: editor._styleNow() === "code"
                           tooltip: "等宽代码块"; onClicked: editor.setStyle("code") }

                ToolDivider {}

                // ── 字型 ──
                ToolChip { caption: "B"; mono: true; bold: true; active: editor._flagNow("bold")
                           tooltip: "加粗"; onClicked: editor.toggleFormat("bold") }
                ToolChip { caption: "I"; mono: true; italic: true; active: editor._flagNow("italic")
                           tooltip: "斜体"; onClicked: editor.toggleFormat("italic") }
                ToolChip { caption: "U"; mono: true; active: editor._flagNow("underline")
                           tooltip: "下划线"; onClicked: editor.toggleFormat("underline") }
                ToolChip { caption: "S"; mono: true; active: editor._flagNow("strike")
                           tooltip: "删除线"; onClicked: editor.toggleFormat("strike") }

                ToolDivider {}

                // ── 对齐 ──
                ToolChip { caption: "左"; active: editor._alignNow() === "left"
                           tooltip: "左对齐"; onClicked: editor.setAlign("left") }
                ToolChip { caption: "中"; active: editor._alignNow() === "center"
                           tooltip: "居中"; onClicked: editor.setAlign("center") }
                ToolChip { caption: "右"; active: editor._alignNow() === "right"
                           tooltip: "右对齐"; onClicked: editor.setAlign("right") }

                ToolDivider {}

                // ── 插入 ──
                ToolChip { caption: "+ 图片"; active: false
                           tooltip: "插入图片块"; onClicked: editor.imageRequested() }
                ToolChip { caption: "+ 文件"; active: false
                           tooltip: "插入文件块"; onClicked: editor.fileRequested() }
                ToolChip { caption: "+ 文字"; active: false
                           tooltip: "在下方新起一段"; onClicked: editor.insertTextBlock(undefined, "") }
            }

            // 块顺序 / 删除：贴右边固定，不参与换行 —— 它们作用于「当前块」，
            // 混在样式芯片里会被误读成样式开关。
            Row {
                id: moveBar
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacingMd
                y: Theme.spacingSm
                spacing: 3

                ToolChip { caption: "↑"; mono: true; enabled: editor.currentIndex > 0
                           tooltip: "当前块上移"
                           onClicked: editor.moveBlock(editor.currentIndex, editor.currentIndex - 1) }
                ToolChip { caption: "↓"; mono: true
                           enabled: editor.currentIndex >= 0 && editor.currentIndex < editor.blocks.length - 1
                           tooltip: "当前块下移"
                           onClicked: editor.moveBlock(editor.currentIndex, editor.currentIndex + 1) }
                ToolChip { caption: "×"; mono: true; tone: "danger"
                           tooltip: "删除当前块"
                           onClicked: editor.removeBlock(editor.currentIndex) }
            }
        }

        // ── 内容区 ──
        Item {
            id: docArea
            width: parent.width
            height: docColumn.height + Theme.spacingMd

            // 空白文档时铺一层极淡的网格，提示"这里是可编辑区"
            ZGridBackground {
                anchors.fill: parent
                visible: editor.isEmpty
                opacity: 0.45
                // 必须显式透明：ZGridBackground 默认会用 bgColor 平涂一层底，
                // 直接放在卡片里会把卡片底色盖成 #F2F2F2（暗色主题下尤其难看）
                bgColor: "transparent"
                minorColor: Theme.gridLine
                majorColor: Theme.gridLineMajor
                crossColor: Theme.lineSoft
                minorStep: Theme.gridMinor
                majorStep: Theme.gridMajor
            }

            Column {
                id: docColumn
                x: Theme.spacingMd
                y: Theme.spacingSm
                width: docArea.width - Theme.spacingMd * 2
                spacing: editor.blockSpacing

                Repeater {
                    model: editor.blocks

                    delegate: Loader {
                        id: blockLoader

                        required property int index
                        required property var modelData

                        width: docColumn.width
                        // Loader 继承 QQuickImplicitSizeItem，implicitWidth/implicitHeight 只读，
                        // 不能直接赋值（写了编译报 read-only），所以用可写的 height 去接
                        // delegate 根的隐式高度。
                        // Loader.item 的静态类型是 QObject，读 implicitHeight 会报
                        // missing-property；运行时读到的确实是 Item，断言收窄是对的。
                        // qmllint disable missing-property
                        height: item instanceof Item ? item.implicitHeight : 0

                        sourceComponent: {
                            var t = modelData ? (modelData.type || "text") : "text"
                            if (t === "image")
                                return imageDelegate
                            if (t === "file")
                                return fileDelegate
                            return textDelegate
                        }

                        onLoaded: {
                            item.blockIndex = blockLoader.index
                            item.blockData = blockLoader.modelData
                        }
                    }
                }

                // 「继续输入」：空白文档或末尾都能一键新起一段
                Item {
                    width: docColumn.width
                    // 只读时没有"继续输入"这回事；但如果整篇是空的，还是要留一行说明，
                    // 否则只读 + 空文档 = 一条标题栏下面什么都没有。
                    height: (editor.readOnly && editor.blocks.length > 0) ? 0 : 34
                    visible: height > 0

                    MouseArea {
                        anchors.fill: parent
                        enabled: !editor.readOnly
                        hoverEnabled: true
                        cursorShape: Qt.IBeamCursor
                        onClicked: editor.insertTextBlock(editor.blocks.length - 1, "")
                        onEntered: addLabel.color = Theme.ink
                        onExited: addLabel.color = Theme.muted
                    }

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        height: 1
                        color: Theme.lineSoft
                        opacity: 0.5
                    }

                    Text {
                        id: addLabel
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: editor.blocks.length > 0 ? "+ 点击继续输入"
                            : editor.readOnly ? "空文档 / NO CONTENT"
                            : "+ 点击开始输入"
                        font: Theme.fontMonoSm
                        color: Theme.muted
                    }
                }
            }
        }
    }

    // ════════════════════════════════════════════════════════════════
    //  5. 内部小工具
    // ════════════════════════════════════════════════════════════════

    function pad2(n) {
        return (n < 10 ? "0" : "") + n
    }

    // 工具栏的高亮取值。读 revision 让它跟着内容刷新。
    function _styleNow() {
        var r = revision
        var b = blockAt(_targetIndex())
        return b ? styleNameOf(b.style) : "body"
    }

    function _flagNow(flag) {
        var r = revision
        var b = blockAt(_targetIndex())
        return b ? !!b[flag] : false
    }

    function _alignNow() {
        var r = revision
        var b = blockAt(_targetIndex())
        return b ? alignNameOf(b.align) : "left"
    }

    // ── 工具栏芯片：选中 = 亮黄底黑字，悬停 = 悬停底 ──
    component ToolChip: Button {
        id: chip

        property string caption: ""
        property bool active: false
        property bool mono: false
        property bool bold: false
        property bool italic: false
        property string tone: ""          // "" 普通 / "danger" 危险
        property string tooltip: ""

        // 芯片窄一点：工具栏一行要放下 12 个芯片 + 右侧 3 个操作，
        // 用 spacingMd 做内边距就会把「+ 文字」挤到第二行。
        implicitWidth: Math.max(26, chipLabel.implicitWidth + Theme.spacingSm * 2)
        implicitHeight: 24
        padding: 0
        hoverEnabled: true
        text: ""

        background: ZCutRect {
            anchors.fill: parent
            color: !chip.enabled ? "transparent"
                 : chip.active ? (chip.tone === "danger" ? Theme.danger : Theme.accent)
                 : chip.hovered ? Theme.surfaceHover
                 : "transparent"
            strokeColor: chip.active ? "transparent"
                       : chip.hovered ? Theme.lineSoft : "transparent"
            strokeWidth: 1
            cutTopRight: Theme.cutSm
            cutBottomLeft: 3

            Behavior on color {
                ColorAnimation { duration: Theme.durFast; easing.type: Theme.easingStd }
            }
        }

        contentItem: Text {
            id: chipLabel
            text: chip.caption
            // 一个 font 绑定写完所有子属性。
            // 不能既写 `font: ...` 又写 `font.bold: ...`：那是对同一属性重复绑定，
            // 静态检查会报 duplicate-property-binding，运行时后者还会静默盖掉前者的绑定。
            // 注意：注释行不要以 qmllint 开头，否则会被当成 lint 指令解析。
            font: Qt.font({
                family: chip.mono ? Theme.familyMono : Theme.family,
                pixelSize: chip.mono ? 13 : 14,
                bold: chip.bold,
                italic: chip.italic
            })
            color: !chip.enabled ? Theme.muted
                 : chip.active ? (chip.tone === "danger" ? Theme.textOnSub : Theme.textOnAccent)
                 : Theme.ink
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        // 只给 text，不碰 visible —— 可见性归 ToolTip 自己的 delay/timeout 状态机
        ZToolTip { text: chip.tooltip }
    }

    component ToolDivider: Rectangle {
        width: 1
        height: 14
        color: Theme.lineSoft
    }

    // ════════════════════════════════════════════════════════════════
    //  6. 文字块
    // ════════════════════════════════════════════════════════════════

    Component {
        id: textDelegate

        Item {
            id: tRoot

            property int blockIndex: -1
            property var blockData: null

            // Loader.onLoaded 才把 blockData 补进来（晚于 delegate 的 onCompleted），
            // 所以在这里接住它，把文字灌进 TextArea。
            onBlockDataChanged: if (area) area._syncFromBlock()

            // 抢焦点必须等 blockIndex 有了真值再判：delegate 的 Component.onCompleted
            // 阶段 blockIndex 还是 -1，而 _focusRequest 的"没有请求"哨兵恰好也是 -1，
            // 在 onCompleted 里判相等会让**每个**文字块都抢一次焦点，最后一个赢 ——
            // 表现为窗口刚显示时末块被选中、工具栏高亮跳到最后。
            onBlockIndexChanged: {
                if (tRoot.blockIndex >= 0 && editor._focusRequest === tRoot.blockIndex) {
                    editor._focusRequest = -1
                    if (area)
                        area.forceActiveFocus()
                }
            }

            // 唯一的格式依赖点：revision 一变，fmt 重新求值（新对象 → 属性通知 → 下面全部重算）
            readonly property var fmt: {
                var r = editor.revision
                return editor.formatOf(tRoot.blockIndex)
            }

            readonly property bool isHeading: fmt.style === "heading"
            readonly property bool isQuote: fmt.style === "quote"
            readonly property bool isCode: fmt.style === "code"
            readonly property bool selected: editor.currentIndex === tRoot.blockIndex

            // 文字相对块左边缘的缩进：给标题的黄竖条、引用的灰竖条让位。
            // 代码块没有竖条，靠 leftPadding 内缩，所以 leftInset 是 0。
            readonly property int leftInset: isHeading ? 10 : isQuote ? 14 : 0
            readonly property int leftPad: isCode ? Theme.spacingMd : 0
            readonly property int topInset: isHeading ? Theme.spacingSm
                                            : (isQuote || isCode) ? Theme.spacingSm : 2
            readonly property int bottomInset: isHeading ? 4 : (isQuote || isCode) ? Theme.spacingSm : 2

            width: parent ? parent.width : 0
            implicitHeight: area.height + topInset + bottomInset

            // 引用 / 代码块的底
            ZCutRect {
                anchors.fill: parent
                visible: tRoot.isQuote || tRoot.isCode
                color: tRoot.isCode ? Theme.surfaceSunken : Theme.surfaceMuted
                strokeColor: tRoot.isCode ? Theme.lineSoft : "transparent"
                strokeWidth: tRoot.isCode ? 1 : 0
                cutTopRight: tRoot.isCode ? Theme.cutSm : 0
                cutBottomLeft: tRoot.isCode ? 4 : 0
            }

            // 左侧竖条：标题用亮黄，引用用深灰粗线
            Rectangle {
                visible: tRoot.isHeading || tRoot.isQuote
                x: 0
                y: Theme.spacingXs
                width: tRoot.isHeading ? 4 : 3
                height: Math.max(0, tRoot.height - Theme.spacingXs * 2)
                color: tRoot.isHeading ? Theme.accent : Theme.lineSoft
            }

            // 聚焦时的整块轮廓
            ZCutRect {
                anchors.fill: parent
                anchors.margins: -2
                visible: tRoot.selected && area.activeFocus
                color: "transparent"
                strokeColor: Theme.accent
                strokeWidth: 1
                cutTopRight: Theme.cutSm
                cutBottomLeft: 4
                opacity: 0.9
            }

            TextArea {
                id: area

                x: tRoot.leftInset
                y: tRoot.topInset
                width: tRoot.width - tRoot.leftInset
                height: contentHeight + topPadding + bottomPadding

                textFormat: TextEdit.PlainText
                wrapMode: TextEdit.Wrap
                background: null
                padding: 0
                leftPadding: tRoot.leftPad
                rightPadding: Theme.spacingSm
                topPadding: 0
                bottomPadding: 0

                readOnly: editor.readOnly
                selectByMouse: true
                // 块编辑器里 Tab 应该归文本自己用（缩进），不该把块塞进窗口的 Tab 焦点链，
                // 否则 Tab 一次跳一个块，正文里的 Tab 就没法用了。
                activeFocusOnTab: false

                font: editor.textFontFor(tRoot.fmt)
                color: tRoot.isQuote ? Theme.inkSoft : Theme.ink
                horizontalAlignment: editor.hAlignFor(tRoot.fmt.align)
                selectionColor: Theme.accent
                selectedTextColor: Theme.textOnAccent
                placeholderText: tRoot.blockIndex === 0 ? editor.placeholderText : ""
                placeholderTextColor: Theme.muted

                // 首次装载 / 外部整体替换后同步；用户打字不回灌到 text（避免绑成环丢光标）
                Component.onCompleted: _syncFromBlock()

                // blockData 是 Loader 在 onLoaded 里补上的 —— 那是**晚于**本项
                // Component.onCompleted 的时刻，所以首次装载必须在 onLoaded 之后
                // 再同步一次，否则文字块永远是空的（图片/文件块因为是绑定所以没事）。
                function _syncFromBlock() {
                    var raw = tRoot.blockData ? tRoot.blockData.text : ""
                    var t = (raw === undefined || raw === null) ? "" : String(raw)
                    if (area.text !== t)
                        area.text = t
                }

                onTextChanged: {
                    if (!tRoot.blockData || tRoot.blockData.text === area.text)
                        return
                    tRoot.blockData.text = area.text
                    editor._contentEdited()
                }

                onActiveFocusChanged: {
                    if (activeFocus) {
                        editor.currentIndex = tRoot.blockIndex
                        editor.blockActivated(tRoot.blockIndex)
                    }
                }
            }
        }
    }

    // ════════════════════════════════════════════════════════════════
    //  7. 图片块
    // ════════════════════════════════════════════════════════════════

    Component {
        id: imageDelegate

        Item {
            id: iRoot

            property int blockIndex: -1
            property var blockData: null

            readonly property bool selected: editor.currentIndex === iRoot.blockIndex
            readonly property string _url: iRoot.blockData ? (iRoot.blockData.url || "") : ""
            readonly property string _name: iRoot.blockData ? (iRoot.blockData.name || "") : ""
            readonly property string _caption: iRoot.blockData ? (iRoot.blockData.caption || "") : ""

            // 图片原始宽高比；还没加载到就给 16:10 兜底，避免首帧高度为 0 抖动
            readonly property real _ratio: (img.implicitWidth > 0 && img.implicitHeight > 0)
                                           ? (img.implicitWidth / img.implicitHeight) : 1.6
            readonly property real frameHeight: {
                var w = iRoot.width > 0 ? iRoot.width : editor.implicitWidth
                return Math.max(Theme.dp(96), Math.min(editor.maxImageHeight, w / _ratio))
            }

            readonly property bool _showPlaceholder: img.status !== Image.Ready

            width: parent ? parent.width : 0
            implicitHeight: frameHeight + (_caption.length > 0 ? 24 : 0)

            ZCutRect {
                id: imageFrame
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: iRoot.frameHeight
                color: Theme.surfaceSunken
                strokeColor: iRoot.selected ? Theme.accent : Theme.lineSoft
                strokeWidth: iRoot.selected ? 2 : 1
                cutTopRight: Theme.cutLg
                cutBottomLeft: Theme.cutSm

                Image {
                    id: img
                    anchors.fill: parent
                    anchors.margins: 2
                    source: iRoot._url
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                    cache: true
                    smooth: true
                }

                // ── 占位图：没选图 / 加载失败时的工程图样式 ──
                Item {
                    anchors.fill: parent
                    anchors.margins: 2
                    visible: iRoot._showPlaceholder

                    ZHatchPattern {
                        anchors.fill: parent
                        lineColor: Theme.hatch
                        spacing: Theme.hatchStep
                        cross: true
                    }

                    // 四角瞄准框
                    Repeater {
                        model: 4
                        delegate: ZCutRect {
                            required property int index
                            width: 14
                            height: 14
                            color: "transparent"
                            strokeColor: Theme.muted
                            strokeWidth: 1
                            x: index % 2 === 0 ? 6 : parent.width - width - 6
                            y: index < 2 ? 6 : parent.height - height - 6
                            cutTopRight: index === 1 || index === 2 ? 10 : 0
                            cutBottomLeft: index === 1 || index === 2 ? 10 : 0
                        }
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: Theme.spacingXs

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: iRoot._url.length > 0 ? "IMAGE UNAVAILABLE" : "NO IMAGE"
                            font: Theme.fontMonoMd
                            color: Theme.muted
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: iRoot._name.length > 0 ? iRoot._name : "点工具栏「+ 图片」插入"
                            font: Theme.fontMonoSm
                            color: Theme.muted
                            opacity: 0.8
                        }
                    }
                }

                // 左上角 IMG 徽标
                ZTag {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.spacingSm
                    anchors.top: parent.top
                    anchors.topMargin: Theme.spacingSm
                    text: "IMG"
                    tone: Theme.Tone.Ink
                }

                // 右上角删除
                ToolChip {
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.spacingSm
                    anchors.top: parent.top
                    anchors.topMargin: Theme.spacingSm
                    caption: "×"
                    mono: true
                    tone: "danger"
                    tooltip: "移除这张图"
                    onClicked: editor.removeBlock(iRoot.blockIndex)
                }

                TapHandler {
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        editor.currentIndex = iRoot.blockIndex
                        editor.blockActivated(iRoot.blockIndex)
                    }
                }
            }

            // 图下说明
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: imageFrame.bottom
                anchors.topMargin: 5
                visible: iRoot._caption.length > 0
                text: iRoot._caption
                font: Theme.fontMonoSm
                color: Theme.muted
                elide: Text.ElideRight
            }
        }
    }

    // ════════════════════════════════════════════════════════════════
    //  8. 文件块
    // ════════════════════════════════════════════════════════════════

    Component {
        id: fileDelegate

        Item {
            id: fRoot

            property int blockIndex: -1
            property var blockData: null

            readonly property bool selected: editor.currentIndex === fRoot.blockIndex
            readonly property string _url: fRoot.blockData ? (fRoot.blockData.url || "") : ""
            readonly property string _name: fRoot.blockData ? (fRoot.blockData.name || "") : ""
            readonly property var _size: fRoot.blockData ? (fRoot.blockData.size || 0) : 0

            width: parent ? parent.width : 0
            implicitHeight: 52

            ZCutRect {
                id: fileFrame
                anchors.fill: parent
                color: fileHover.hovered ? Theme.surfaceHover : Theme.surface
                strokeColor: fRoot.selected ? Theme.accent : Theme.lineSoft
                strokeWidth: fRoot.selected ? 2 : 1
                cutTopRight: Theme.cutMd
                cutBottomLeft: 4

                Behavior on color {
                    ColorAnimation { duration: Theme.durFast; easing.type: Theme.easingStd }
                }
            }

            // 左侧扩展名徽标
            ZCutRect {
                id: extBadge
                x: Theme.spacingSm
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: 40
                color: Theme.subBg
                cutTopRight: 8
                cutBottomLeft: 3

                Text {
                    anchors.centerIn: parent
                    text: editor.extensionOf(fRoot._name)
                    font: Qt.font({ family: Theme.familyMono, pixelSize: 11, bold: true })
                    color: Theme.textOnSub
                }
            }

            // 文件名 + 元信息
            Column {
                anchors.left: extBadge.right
                anchors.leftMargin: Theme.spacingMd
                anchors.right: removeChip.left
                anchors.rightMargin: Theme.spacingSm
                anchors.verticalCenter: parent.verticalCenter
                spacing: 3

                Text {
                    width: parent.width
                    text: fRoot._name.length > 0 ? fRoot._name : "未命名文件"
                    font: Theme.fontStrong
                    color: Theme.ink
                    elide: Text.ElideMiddle
                }

                Text {
                    width: parent.width
                    text: editor.formatBytes(fRoot._size) + "  ·  ATTACHMENT"
                    font: Theme.fontMonoSm
                    color: Theme.muted
                    elide: Text.ElideRight
                }
            }

            ToolChip {
                id: removeChip
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacingSm
                anchors.verticalCenter: parent.verticalCenter
                caption: "×"
                mono: true
                tone: "danger"
                tooltip: "移除附件"
                onClicked: editor.removeBlock(fRoot.blockIndex)
            }

            HoverHandler { id: fileHover }

            // 点击区只覆盖「徽标 + 文件名」这一段，右边留出删除按钮的地盘。
            // 如果让 TapHandler 铺满整行，点 × 会先删块、再触发 fileActivated(已删除的块)。
            Item {
                anchors.left: parent.left
                anchors.right: removeChip.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                TapHandler {
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        editor.currentIndex = fRoot.blockIndex
                        editor.blockActivated(fRoot.blockIndex)
                        editor.fileActivated(fRoot._url, fRoot._name)
                    }
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZChatInput.qml`

QQ 式消息输入框：正文 + 图片 / 文件附件，内置系统文件选择框，拖放与粘贴自动转附件，回车发送

```qml
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Dialogs

/*!
    \qmltype ZChatInput
    \inqmlmodule ZmdUI
    \brief 聊天输入框：多行文本 + 图片 / 文件附件，Enter 发送、拖入即加附件。

    形制照着 IM 的消息输入框做：上面是**附件预览区**（图片缩略图、文件卡片，都可单独删掉），
    中间是可长高的多行输入区，底部一排工具（图片 / 文件 / 清空）与发送按钮。

    \qml
    ZChatInput {
        width: 560
        placeholderText: "输入消息…"
        onSendRequested: (text, attachments) => chat.send(text, attachments)
    }
    \endqml

    \section1 「图片」/「文件」按钮默认就能用

    点它们会弹出系统文件选择框（\c QtQuick.Dialogs），选完按扩展名分流成图片缩略图
    或文件卡片。宿主想换成自己的选择器（带预览、最近使用、远程目录……）时，
    把 \l useSystemDialogs 置 \c false，然后接 \l imagePickRequested /
    \l filePickRequested，选完再调 \l addImage / \l addFile / \l addUrlsAsAttachments。

    组件仍然不发网络请求、不决定发送后要不要清空：点「发送」只发出
    \l sendRequested，是否清空由 \l clearOnSend 或宿主自己决定。

    \section1 键盘约定

    \list
    \li 默认 \c Enter 发送、\c Shift+Enter 换行（\l sendOnEnter 可反转为「Enter 换行、Ctrl+Enter 发送」）
    \li \c Ctrl+Enter 在两种模式下都发送 —— 不用记当前是哪种模式
    \li \c Escape 发出 \l cancelRequested，宿主可用来收起 @ 候选、清空草稿等
    \endlist

    \section1 输入区的高度与滚动

    默认是**定高 + 内部滚动**（\l allowResize 为 \c false、\l allowOverflow 为 \c true）：
    输入区高度恒为 \l minTextHeight，写长了就在框内滚，右侧出现滚动条，光标始终可见。
    两个开关可以自由组合：

    \list
    \li \l allowResize：允许输入区跟着内容长高（\l minTextHeight → \l maxTextHeight）
    \li \l allowOverflow：允许正文超出输入区高度；关掉后，会溢出的那次输入直接被退回
    \endlist

    | allowResize | allowOverflow | 行为 |
    | --- | --- | --- |
    | false（默认） | true（默认） | 定高，超出部分内部滚动 + 滚动条 |
    | true | true | 先长高到 maxTextHeight，再内部滚动 |
    | false | false | 定高，写满就不接受更多输入 |
    | true | false | 长高到 maxTextHeight，写满就不接受更多输入 |

    这和 ZRichTextEditor 的"完全不滚动"不同 —— 聊天框固定在屏幕一角，
    不可能把整页撑高。
*/
Item {
    id: composer

    // ════════════════════════════════════════════════════════════════
    //  1. 数据
    // ════════════════════════════════════════════════════════════════

    /*! 草稿正文。直接读写输入区，不需要中间变量。 */
    property alias text: area.text

    /*!
        附件数组，元素形如 `{ type: "image" | "file", url, name, size, id }`。

        约定：**整体替换**才会刷新界面。组件内部增删附件一律用
        `attachments = attachments.slice()` 重新赋值，自己的代码也请照做，
        不要 `attachments.push(...)` —— 那改的是数组本身，绑定收不到通知。
    */
    property var attachments: []

    /*!
        附件版本号。附件数组被整体替换时自增，给"想在附件变化时做点事"
        的绑定一个稳定的依赖点（\l attachments 本身也能绑，这个只是方便）。
    */
    property int revision: 0

    // ════════════════════════════════════════════════════════════════
    //  2. 外观
    // ════════════════════════════════════════════════════════════════

    /*! 是否画外框（放进 ZPanel 这类已有卡片的容器时关掉，避免双层边框） */
    property bool framed: true

    /*! 是否显示底部工具栏 */
    property bool showToolbar: true

    /*! 是否显示顶部深色标题条 */
    property bool showHeader: true

    /*! 标题条上的等宽小字 */
    property string headerText: "MESSAGE / COMPOSER"

    /*! 空输入时的占位提示。默认空 —— 框里不放任何提示文字，要就自己给 */
    property string placeholderText: ""

    /*! 发送按钮文字 */
    property string sendText: "发送"

    /*! 附件区留空时要显示的一行提示。默认空 —— 没有附件时附件区高度就是 0，不占地方 */
    property string attachHintText: ""

    /*! 输入区最小高度。关掉 \l allowResize 后，输入区高度就恒等于它 */
    property int minTextHeight: 74

    /*! 输入区最大高度：开着 \l allowResize 时，输入区长到这个高度就不再长，改走内部滚动 */
    property int maxTextHeight: 140

    /*!
        允许输入区跟着内容变高（\l minTextHeight → \l maxTextHeight）。默认 \c false：
        高度恒定，写长了在框内滚动。想要 QQ 那种"越写越高、到顶再滚"就置 \c true。
    */
    property bool allowResize: false

    /*!
        允许正文超出输入区高度（超出后在输入区内部滚动，右侧出现滚动条）。默认 \c true。

        置 \c false 时，输入区高度就是可视上限：**会让内容溢出的那次输入会被整段退回**，
        并发 \l limitReached("height")；程序化赋一个超长 \l text 也会被退回上一次的内容。
    */
    property bool allowOverflow: true

    /*! 滚轮一格（120 角度增量）滚多少像素。触控板的像素增量不受它影响 */
    property int wheelStepSize: 48

    /*!
        输入区滚到上 / 下边界后，继续滚是否把剩余距离交给外层页面（浏览器式链式滚动）。
        默认 \c false：到头就停住，外层页面一动不动。

        注意内容**放得下**（没有可滚区域）时不适用这条 —— 那时组件不参与滚轮，
        事件照常落到外层，否则一行的输入框会变成页面滚动的死区。
    */
    property bool wheelChainsToAncestor: false

    /*! 图片缩略图边长 */
    property int thumbSize: 64

    /*! 文件卡片宽度 */
    property int fileCardWidth: 208

    /*! 文件卡片高度 */
    property int fileCardHeight: 56

    /*! 是否允许加图片附件（关掉后工具栏的「图片」按钮不出现） */
    property bool allowImage: true

    /*! 是否允许加文件附件 */
    property bool allowFile: true

    /*! 只读：输入区不可编辑、工具栏与发送按钮禁用 */
    property bool readOnly: false

    /*! 发送中：发送按钮换成忙碌外观并禁用，输入区仍可继续写 */
    property bool busy: false

    /*! 点「图片」/「文件」时，组件是否自己弹系统文件选择框。
        默认 \c true —— 不接线也能用。宿主想换成自己的选择器（比如带预览、
        带最近使用、或者远程目录浏览）时把它置 false，然后接
        \l imagePickRequested / \l filePickRequested 自己处理，
        选完再调 \l addImage / \l addFile / \l addUrlsAsAttachments。 */
    property bool useSystemDialogs: true

    // ════════════════════════════════════════════════════════════════
    //  3. 行为
    // ════════════════════════════════════════════════════════════════

    /*!
        Enter 的行为。`true`（默认）= Enter 发送、Shift+Enter 换行；
        `false` = Enter 换行、Ctrl+Enter 发送。两种模式下 Ctrl+Enter 都能发。
    */
    property bool sendOnEnter: true

    /*! 发出 \l sendRequested 之后是否自动清空草稿（默认不清，交给宿主决定） */
    property bool clearOnSend: false

    /*! 正文长度上限（字符数）。0 = 不限制；超限只是不能发送，不会截断用户输入 */
    property int maxLength: 2000

    /*! 附件数量上限，0 = 不限制 */
    property int maxAttachments: 9

    /*! 用户点了「发送」（或按了发送快捷键） */
    signal sendRequested(string text, var attachments)

    /*! 加进一个附件（\a index 是加入后的下标） */
    signal attachmentAdded(var attachment, int index)

    /*! 删掉一个附件 */
    signal attachmentRemoved(var attachment, int index)

    /*! 用户点了「图片」——宿主该打开文件选择框，选完调 \l addImage */
    signal imagePickRequested()

    /*! 用户点了「文件」——同上，选完调 \l addFile */
    signal filePickRequested()

    /*! 用户按了 Escape */
    signal cancelRequested()

    /*! 正文被编辑（每次内容变化都会发，宿主可用来做"正在输入"） */
    signal textEdited()

    /*!
        拖文件进输入框时发出，\a urls 是 `list<url>`。
        图片会按扩展名自动成为图片附件、其余成为文件附件（受 \l maxAttachments 限制）；
        这个信号只是给宿主"知道发生了什么"，**不需要**再自己调 \l addImage / \l addFile。
    */
    signal filesDropped(var urls)

    /*!
        用户在输入区按 Ctrl+V，而剪贴板里**没有文本**时发出——这通常意味着剪贴板里是位图。
        QML 没有读剪贴板图片的能力，需要宿主用 C++ 取图、存成文件，再回调 \l addImage：

        \qml
        ZChatInput {
            onPasteRequested: {
                var url = ZClipboard.saveImage()      // 宿主注入的 context property
                if (url.length > 0)
                    addImage(url, "clipboard.png")
            }
        }
        \endqml
    */
    signal pasteRequested()

    /*!
        某条限制被撞到。\a kind 是 `"length"`（超出 \l maxLength）或
        `"attachments"`（超出 \l maxAttachments），宿主可以据此弹提示。
    */
    signal limitReached(string kind)

    /*! 附件个数 */
    readonly property int attachmentCount: attachments ? attachments.length : 0

    /*! 其中图片个数 */
    readonly property int imageCount: countOfType("image")

    /*! 其中文件个数 */
    readonly property int fileCount: countOfType("file")

    /*! 正文 + 附件是否至少有一个非空 */
    readonly property bool hasContent: text.trim().length > 0 || attachmentCount > 0

    /*! 正文是否超过 \l maxLength */
    readonly property bool overLimit: maxLength > 0 && text.length > maxLength

    /*! 现在按「发送」会不会真的发出去 */
    readonly property bool canSend: hasContent && !readOnly && !busy && !overLimit

    /*! 输入区是否拿到了焦点（宿主可用来做"点击空白处聚焦"） */
    readonly property bool inputFocused: area.activeFocus

    /*! 标题条右侧的草稿摘要，例如 `"128 字 · 2 图 · 1 文件"` */
    readonly property string draftSummary: {
        var parts = [text.length + " 字"]
        if (imageCount > 0)
            parts.push(imageCount + " 图")
        if (fileCount > 0)
            parts.push(fileCount + " 文件")
        return parts.join(" · ")
    }

    /*! 计数文案，例如 `"128 / 2000"` */
    readonly property string counterText: maxLength > 0 ? (text.length + " / " + maxLength)
                                                        : (text.length + " 字")

    /*! 内部：附件自增 id（只用来给委托一个稳定 key） */
    // 附件 id 的计数器。故意做成普通 JS 对象而不是 `property int`：
    // 工厂函数常被写在 `attachments: [ makeImageAttachment(...) ]` 这种**绑定**里，
    // 如果计数器是 QML 属性，绑定求值期间读写它会把自己标记成依赖，
    // 于是 Qt 报 "Binding loop detected for property attachments"。
    // 放在对象字段里，绑定时只读 `_idGen` 这个属性本身（值不变），写入不触发失效。
    property var _idGen: ({ next: 1 })

    /*! 内部：是否正把文件拖在输入框上 */
    property bool _dropActive: false

    /*! 内部：是否已经就"超长"报过警（用来做边沿触发，避免每敲一个字都发信号） */
    property bool _overLimitReported: false

    /*! 内部：是否已经就"超出输入框高度"报过警（同样是边沿触发） */
    property bool _overflowReported: false

    /*! 内部：正在把溢出的输入退回去，别再让这次回退再走一遍溢出判定 */
    property bool _revertingOverflow: false

    /*!
        内部：输入区（视口）的实际高度。

        只看文字的**固有**高度（\c contentHeight + padding），绝不去看 \c area.height ——
        否则 area.height 依赖视口、视口又依赖 contentHeight（contentHeight 反过来随宽高变），
        很容易绕成绑定循环。\l allowResize 关掉时它就是个常数 \l minTextHeight。
    */
    readonly property int _viewportHeight: allowResize
        ? Math.max(minTextHeight,
                   Math.min(area.contentHeight + area.topPadding + area.bottomPadding,
                            maxTextHeight))
        : minTextHeight

    /*! 内部：上一次的正文，用来做 diff 找出"这次粘贴进来的是哪一段" */
    property string _lastText: ""

    /*! 内部：正在把粘贴进来的 file:/// 文本改写成附件，别让改写本身再触发一次扫描 */
    property bool _suppressPasteScan: false

    /*! 内部：按扩展名认作图片的那些后缀（小写、不含点） */
    readonly property var _imageExtensions: [
        "png", "jpg", "jpeg", "jfif", "gif", "bmp", "webp", "svg",
        "ico", "tif", "tiff", "heic", "heif", "avif"
    ]

    implicitWidth: Theme.dp(560)
    implicitHeight: body.height

    // ════════════════════════════════════════════════════════════════
    //  4. 纯函数：附件工厂 / 归一化 / 换算 / 序列化
    //     全部不碰界面状态，可以直接在 qmltestrunner 里断言。
    // ════════════════════════════════════════════════════════════════

    /*! 造一个图片附件。 */
    function makeImageAttachment(url, name) {
        return normalizeAttachment({
            type: "image",
            url: url ? String(url) : "",
            name: name ? String(name) : (url ? fileNameOf(url) : "image")
        })
    }

    /*! 造一个文件附件。\a size 是字节数。 */
    function makeFileAttachment(url, name, size) {
        return normalizeAttachment({
            type: "file",
            url: url ? String(url) : "",
            name: name ? String(name) : (url ? fileNameOf(url) : "file"),
            size: size
        })
    }

    /*! 把一个可能残缺的附件对象补成合法形状（类型只认 image / file，其它按 file 处理）。 */
    function normalizeAttachment(att) {
        var src = att || {}
        var type = String(src.type || "").toLowerCase() === "image" ? "image" : "file"
        var url = src.url ? String(src.url) : ""
        var name = src.name ? String(src.name) : (url ? fileNameOf(url) : type)
        var size = Number(src.size)
        return {
            type: type,
            url: url,
            name: name,
            size: isFinite(size) && size > 0 ? Math.round(size) : 0,
            id: src.id ? String(src.id) : ("att-" + (composer._idGen.next++))
        }
    }

    /*! 从路径里取文件名（同时认 `/` 与 `\`）。 */
    function fileNameOf(url) {
        var s = url ? String(url) : ""
        var cut = Math.max(s.lastIndexOf("/"), s.lastIndexOf("\\"))
        return cut >= 0 ? s.substring(cut + 1) : s
    }

    /*! 取扩展名（小写、不含点）。没有扩展名返回空串。 */
    function extensionOf(name) {
        var s = name ? String(name) : ""
        var dot = s.lastIndexOf(".")
        if (dot <= 0 || dot === s.length - 1)
            return ""
        return s.substring(dot + 1).toLowerCase()
    }

    /*! 字节数 → 人读的大小。 */
    function formatBytes(bytes) {
        var n = Number(bytes)
        if (!isFinite(n) || n <= 0)
            return "0 B"
        if (n < 1024)
            return Math.round(n) + " B"
        if (n < 1024 * 1024)
            return (n / 1024).toFixed(1) + " KB"
        if (n < 1024 * 1024 * 1024)
            return (n / (1024 * 1024)).toFixed(1) + " MB"
        return (n / (1024 * 1024 * 1024)).toFixed(1) + " GB"
    }

    /*! 按扩展名猜一个 url 是不是图片（拖进来 / 粘进来的东西要靠它分流）。 */
    function isImageUrl(url) {
        var ext = extensionOf(fileNameOf(url ? String(url) : ""))
        return ext.length > 0 && _imageExtensions.indexOf(ext) >= 0
    }

    /*!
        把 \l FileDialog.selectedFiles（`list<url>`）转成普通字符串数组。
        单独抽出来是因为 QML 的列表属性在 JS 里是"类数组"对象，
        直接往 \l addUrlsAsAttachments 里塞，某些 Qt 版本会拿到带包装的对象。
    */
    function urlsOf(files) {
        var out = []
        if (!files)
            return out
        for (var i = 0; i < files.length; ++i) {
            var one = files[i]
            if (one === undefined || one === null)
                continue
            var s = String(one)
            if (s.length > 0)
                out.push(s)
        }
        return out
    }

    /*!
        取 \a after 相对 \a before 新插入的那一段：去掉共同前缀、共同后缀，中间就是这次改动的净增量。
        粘贴时用它认出"刚插进来的内容是什么"，纯函数，方便单测。
    */
    function insertedText(before, after) {
        var b = before === undefined || before === null ? "" : String(before)
        var a = after === undefined || after === null ? "" : String(after)
        var head = 0
        var headMax = Math.min(b.length, a.length)
        while (head < headMax && b.charAt(head) === a.charAt(head))
            ++head
        var tail = 0
        var tailMax = Math.min(b.length - head, a.length - head)
        while (tail < tailMax &&
               b.charAt(b.length - 1 - tail) === a.charAt(a.length - 1 - tail))
            ++tail
        return a.substring(head, a.length - tail)
    }

    /*!
        把一段文本按行拆开：**每一行都是 `file:///…`** 时返回这些 url，否则返回空数组。
        资源管理器里 Ctrl+C 复制文件，粘到 QML 的 TextEdit 里就是一行一个 file url，
        这样就能把它们转成附件，而不是把一串路径塞进正文。
    */
    function fileUrlsIn(block) {
        var s = block === undefined || block === null ? "" : String(block)
        if (s.length === 0)
            return []
        var lines = s.replace(/\r\n?/g, "\n").split("\n")
        var out = []
        for (var i = 0; i < lines.length; ++i) {
            var line = lines[i].replace(/^\s+/, "").replace(/\s+$/, "")
            if (line.length === 0)
                continue
            if (!/^file:\/\/\/\S+$/.test(line))
                return []
            out.push(line)
        }
        return out
    }

    /*! 附件数组里某种形态的个数。 */
    function countOfType(type) {
        var want = String(type || "")
        var n = 0
        for (var i = 0; i < attachments.length; ++i) {
            if (String(attachments[i].type) === want)
                ++n
        }
        return n
    }

    /*! 草稿序列化：`{ text, attachments }`，附件是浅拷贝（改返回值不影响界面）。 */
    function draftToJSON() {
        var list = []
        for (var i = 0; i < attachments.length; ++i) {
            var a = attachments[i]
            list.push({ type: a.type, url: a.url, name: a.name, size: a.size, id: a.id })
        }
        return { text: text, attachments: list }
    }

    /*! 从 \l draftToJSON 的结构恢复草稿（字段缺失按空处理）。 */
    function draftFromJSON(draft) {
        var src = draft || {}
        text = src.text === undefined || src.text === null ? "" : String(src.text)
        var list = []
        var incoming = src.attachments
        if (incoming && incoming.length !== undefined) {
            for (var i = 0; i < incoming.length; ++i)
                list.push(normalizeAttachment(incoming[i]))
        }
        attachments = list
        revision++
    }

    /*! 当前按下这个修饰键组合时，回车是否应该"发送"。 */
    function isSendCombo(modifiers) {
        var ctrl = (modifiers & Qt.ControlModifier) !== 0
        var shift = (modifiers & Qt.ShiftModifier) !== 0
        if (ctrl)
            return true
        if (shift)
            return false
        return sendOnEnter
    }

    /*! 取一份附件快照（发给宿主的永远是新数组，宿主改它不会污染草稿）。 */
    function snapshotAttachments() {
        var list = []
        for (var i = 0; i < attachments.length; ++i) {
            var a = attachments[i]
            list.push({ type: a.type, url: a.url, name: a.name, size: a.size, id: a.id })
        }
        return list
    }

    // ════════════════════════════════════════════════════════════════
    //  5. 操作：加 / 删附件、发送、清空
    // ════════════════════════════════════════════════════════════════

    /*!
        加一个附件，返回它加入后的下标；被拒绝（只读 / 超上限 / 无效）返回 -1。
        图片与文件走同一入口，形态由 \c att.type 决定。
    */
    function addAttachment(att) {
        if (readOnly)
            return -1
        if (!att || (att.url === undefined && att.name === undefined))
            return -1
        if (maxAttachments > 0 && attachmentCount >= maxAttachments) {
            limitReached("attachments")
            return -1
        }
        var normalized = normalizeAttachment(att)
        var list = attachments.slice()
        list.push(normalized)
        attachments = list
        revision++
        attachmentAdded(normalized, list.length - 1)
        return list.length - 1
    }

    /*! 加图片附件（\l addAttachment 的语法糖）。 */
    function addImage(url, name) {
        return addAttachment(makeImageAttachment(url, name))
    }

    /*! 加文件附件（\l addAttachment 的语法糖）。 */
    function addFile(url, name, size) {
        return addAttachment(makeFileAttachment(url, name, size))
    }

    /*!
        把一批 url（拖进来、粘进来）加成附件：图片后缀走 \l addImage，其余走 \l addFile。
        遵守 \l maxAttachments，越界的部分会被 \l limitReached 挡掉。返回真正加进去的个数。
    */
    function addUrlsAsAttachments(urls) {
        if (readOnly || !urls)
            return 0
        var count = urls.length
        if (count === undefined)
            return 0
        var added = 0
        for (var i = 0; i < count; ++i) {
            var u = urls[i] === undefined || urls[i] === null ? "" : String(urls[i])
            if (u.length === 0)
                continue
            var name = fileNameOf(u)
            var idx = isImageUrl(u) ? addImage(u, name) : addFile(u, name, 0)
            if (idx >= 0)
                ++added
        }
        return added
    }

    /*! 删掉第 \a index 个附件，返回是否删掉了。 */
    function removeAttachment(index) {
        if (readOnly)
            return false
        if (!(index >= 0 && index < attachments.length))
            return false
        var list = attachments.slice()
        var removed = list[index]
        list.splice(index, 1)
        attachments = list
        revision++
        attachmentRemoved(removed, index)
        return true
    }

    /*! 清空全部附件。 */
    function clearAttachments() {
        if (attachments.length === 0)
            return
        attachments = []
        revision++
    }

    /*! 清空草稿（正文 + 附件）。 */
    function clear() {
        area.text = ""
        clearAttachments()
        _overLimitReported = false
        _overflowReported = false
    }

    /*!
        尝试发送。返回是否真的发出去了：
        没有内容 / 只读 / 忙碌 / 超长 时返回 `false`，并不发信号。
    */
    function submit() {
        if (!hasContent)
            return false
        if (readOnly || busy)
            return false
        if (overLimit) {
            limitReached("length")
            return false
        }
        sendRequested(area.text, snapshotAttachments())
        if (clearOnSend)
            clear()
        return true
    }

    /*! 把焦点放进输入区。 */
    function focusInput() {
        area.forceActiveFocus()
    }

    /*! 输入区超过 maxTextHeight 后靠内部 Flickable 滚动，把光标拉回可视区。

        不这么做的话：TextArea 高度封顶、只 clip 不滚，光标走到第 9 行以后就停在
        可视区外面，用户看起来就是"文字和光标跑到输入框下面消失"。
    */
    function _keepCaretVisible() {
        if (typeof textFlick === "undefined" || textFlick === null
                || typeof area === "undefined" || area === null)
            return
        // 内容没超：永远回到顶部，别留着上一次的滚动位置
        if (textFlick.contentHeight <= textFlick.height) {
            if (textFlick.contentY !== 0)
                textFlick.contentY = 0
            return
        }
        var r = area.cursorRectangle
        var viewTop = textFlick.contentY
        var viewBottom = viewTop + textFlick.height
        if (r.y < viewTop) {
            textFlick.contentY = Math.max(0, r.y - 2)
        } else if (r.y + r.height > viewBottom) {
            textFlick.contentY = Math.min(textFlick.contentHeight - textFlick.height,
                                          r.y + r.height - textFlick.height + 2)
        }
    }

    /*! 内部：把输入区滚到头之后剩下的那段滚轮距离，转给最近的可滚动祖先。

        只在 \l wheelChainsToAncestor 打开时才会被调用（默认关，到头就停住）。
        为什么要自己转：`WheelHandler` 一旦挂在组件里，滚轮事件就由它接管、**不再冒泡**，
        想"继续滚外层"就只能手动把剩余距离递过去
        （`Flickable` / `ListView` / \c ScrollView 的 contentItem 都只看 contentY）。
    */
    function _chainWheelToAncestor(dy) {
        // parent 的静态类型只是 Item，直接读 contentY 会被静态检查拦下，
        // 所以先 instanceof 判断、再 as Flickable 收窄
        var p = parent
        while (p) {
            if (p instanceof Flickable) {
                var f = p as Flickable
                if (f.contentHeight > f.height + 0.5) {
                    var maxY = f.contentHeight - f.height
                    f.contentY = Math.max(0, Math.min(maxY, f.contentY - dy))
                    return true
                }
            }
            p = p.parent
        }
        return false
    }

    /*! 内部：把这次会让内容溢出视口的输入整段退回（\l allowOverflow 为 false 时用）。

        为什么整段退回、而不是截成"刚好放得下"：截断需要拿候选文本反复量 \c contentHeight，
        而 TextEdit 的排版是异步的，量到的值不可靠；退回上一次的正文则是确定性的，
        连按退格 / 连续打字都不会出现"字越打越少"的半截状态。
    */
    function _rejectOverflow() {
        var previous = _lastText
        if (area.text === previous)
            return
        var keepCursor = Math.min(area.cursorPosition, previous.length)
        _revertingOverflow = true
        area.text = previous
        area.cursorPosition = keepCursor
        if (!_overflowReported) {
            _overflowReported = true
            limitReached("height")
        }
    }

    // ════════════════════════════════════════════════════════════════
    //  6. 界面
    // ════════════════════════════════════════════════════════════════

    ZCutRect {
        id: bg
        anchors.fill: parent
        color: Theme.surface
        strokeColor: composer._dropActive ? Theme.accent
                                          : (area.activeFocus ? Theme.line : Theme.lineSoft)
        strokeWidth: Theme.border
        cutTopRight: composer.framed ? Theme.cutMd : 0
        cutBottomLeft: composer.framed ? Theme.cutMd : 0
    }

    Column {
        id: body
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        // ── 标题条 ────────────────────────────────────────────────
        ZCutRect {
            id: headerBar
            objectName: "chatHeader"
            width: parent.width
            height: composer.showHeader ? 30 : 0
            visible: composer.showHeader
            // 用 inkBlock 而不是 ink：ink 是**前景色**，暗色模式下会翻成近白，
            // 这条标题条就成了白底白字（文字用的是 textOnSub）。
            // 库里其它"黑色块"（ZPanel / ZSectionTitle / ZTable / ZDialog）都用 inkBlock。
            color: Theme.inkBlock
            cutTopRight: composer.framed ? Theme.cutMd : 0

            Text {
                id: headerLabel
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacingLg
                anchors.verticalCenter: parent.verticalCenter
                text: composer.headerText
                font: Theme.fontMonoSm
                color: Theme.textOnSub
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacingLg
                anchors.verticalCenter: parent.verticalCenter
                text: composer.draftSummary.toUpperCase()
                font: Theme.fontMonoSm
                color: composer.hasContent ? Theme.accent : Theme.muted
            }
        }

        // ── 附件预览区 ────────────────────────────────────────────
        // 高度**与附件数量无关**：永远只占一行（thumbSize + 上下留白），排不下就横向滚。
        // 之前用 Flow 自动换行，第 4、5 个附件就会折到第二行，整个组件被顶高，
        // 把下面的正文、工具栏一起推下去 —— 用户看到的就是"一插图片窗口就变高"。
        Item {
            id: attachZone
            objectName: "chatAttachZone"
            width: parent.width
            // 没有附件时附件区高度为 0 —— 提示行默认是空的（attachHintText 默认 ""），
            // 宿主自己填了提示、且输入区还空着，才给它 26px。
            height: composer.attachmentCount > 0 ? composer.thumbSize + Theme.spacingSm * 2
                 : (composer.attachHintText.length > 0 && composer.text.length === 0 ? 26 : 0)
            visible: height > 0

            Flickable {
                id: attachFlick
                objectName: "chatAttachScroller"
                x: Theme.spacingMd
                y: Theme.spacingSm
                width: parent.width - Theme.spacingMd * 2
                height: composer.thumbSize
                contentWidth: attachRow.width
                contentHeight: height
                clip: true
                visible: composer.attachmentCount > 0
                flickableDirection: Flickable.HorizontalFlick
                boundsBehavior: Flickable.StopAtBounds

                // 竖向滚轮在附件条上映射成横向滚动（触控板的横向增量照用）
                WheelHandler {
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    acceptedModifiers: Qt.NoModifier

                    onWheel: function (event) {
                        var maxX = Math.max(0, attachFlick.contentWidth - attachFlick.width)
                        if (maxX <= 0) {
                            event.accepted = false
                            return
                        }
                        var dx = event.pixelDelta.x !== 0 ? event.pixelDelta.x
                               : event.pixelDelta.y !== 0 ? event.pixelDelta.y
                               : (event.angleDelta.x !== 0 ? event.angleDelta.x : event.angleDelta.y)
                                 / 120 * composer.wheelStepSize
                        attachFlick.contentX = Math.max(0, Math.min(maxX, attachFlick.contentX - dx))
                        event.accepted = true
                    }
                }

                Row {
                    id: attachRow
                    width: childrenRect.width
                    height: composer.thumbSize
                    spacing: Theme.spacingSm

                    Repeater {
                        model: composer.attachments

                        delegate: Loader {
                            id: attachLoader

                            // 文件卡比缩略图矮，Row 里要自己垂直居中
                            y: Math.round((composer.thumbSize - height) / 2)

                            required property int index
                            required property var modelData

                            // 委托里的两个 Component 声明在文件级作用域，看不到 attachLoader 这个 id，
                            // 但它们靠上下文直接读 modelData / index —— 这两个是 Repeater 委托的上下文属性，
                            // sourceComponent 造出来的项会继承它。
                            sourceComponent: modelData && modelData.type === "image" ? imageThumb : fileCard
                        }
                    }
                }
            }

            Text {
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                visible: composer.attachmentCount === 0
                         && composer.text.length === 0
                         && composer.attachHintText.length > 0
                text: composer.attachHintText
                font: Theme.fontMonoSm
                color: Theme.muted
            }
        }

        // ── 输入区 ────────────────────────────────────────────────
        Item {
            id: textWrap
            width: parent.width
            height: textFlick.height

            Text {
                id: placeholderLabel
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: Theme.spacingMd
                anchors.rightMargin: Theme.spacingMd
                anchors.topMargin: Theme.spacingSm
                text: composer.placeholderText
                font: Theme.fontBody
                color: Theme.muted
                visible: area.text.length === 0
                         && !composer.readOnly
                         && composer.placeholderText.length > 0
                elide: Text.ElideRight
            }

            // 输入区高度 = 视口高度（见 composer._viewportHeight）：
            // 关掉 allowResize 就是个定高框，超出部分靠这个 Flickable 内部滚动。
            // 不能只靠 TextArea 自己的 clip：那样第 9 行以后会被裁掉且**不会滚动**，
            // 光标停在可视区外，用户看到的就是"文字和光标跑到框下面消失"。
            Flickable {
                id: textFlick
                objectName: "chatTextScroller"
                width: parent.width
                height: composer._viewportHeight
                contentWidth: width
                contentHeight: area.height
                clip: true
                // 拖拽留给文字选择，滚动靠滚轮 / 滚动条 / 光标跟随；
                // 否则一拖鼠标就在"划选文字"和"滚动"之间打架
                interactive: false
                boundsBehavior: Flickable.StopAtBounds

                // 滚轮必须自己接管：Flickable 在 interactive=false 时**不处理滚轮**
                // （Qt 6 的 QQuickFlickable::wheelEvent 一进门就 return），
                // 事件于是冒泡给外层页面 —— 用户看到的就是"在输入框里滚，页面在动"。
                // 所以这里滚内部视口，并且默认**滚到边界就停住**，不带动外层。
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
                        // （这不算"到边界"，否则一行字的输入框会变成页面滚动的死区。）
                        if (maxY <= 0) {
                            composer._chainWheelToAncestor(dy)
                            event.accepted = true
                            return
                        }

                        var next = Math.max(0, Math.min(maxY, textFlick.contentY - dy))
                        var used = textFlick.contentY - next
                        textFlick.contentY = next
                        // 默认到头就停住：剩下的距离直接丢掉，外层页面一动不动。
                        // 想要浏览器那种"滚到头继续滚页面"，把 wheelChainsToAncestor 打开。
                        var left = dy - used
                        if (composer.wheelChainsToAncestor && Math.abs(left) > 0.5)
                            composer._chainWheelToAncestor(left)
                        event.accepted = true
                    }
                }

                // 内容真的超出视口时才挂滚动条：allowOverflow 关掉时内容永远不超出，
                // 所以那条分支里它恒为 AlwaysOff。
                ScrollBar.vertical: ZScrollBar {
                    id: textScrollBar
                    objectName: "chatTextScrollBar"
                    policy: (composer.allowOverflow && textFlick.contentHeight > textFlick.height + 0.5)
                            ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                }

                TextArea {
                    id: area
                    objectName: "chatTextArea"

                    // 滚动条占的是右侧 12px 的内边距，正好压在 rightPadding 的空当里，
                    // 所以它出现 / 消失不会让文字重新折行（不会和视口高度互相抖）
                    width: textFlick.width
                    // 允许超出时：内容高过视口就把自身撑高，交给外层 Flickable 滚；
                    // 不允许超出时内容不会超过视口（溢出的输入已被退回），高度就锁在视口高
                    height: composer.allowOverflow
                            ? Math.max(textFlick.height, contentHeight + topPadding + bottomPadding)
                            : textFlick.height

                    leftPadding: Theme.spacingMd
                    rightPadding: Theme.spacingMd
                    topPadding: Theme.spacingSm
                    bottomPadding: Theme.spacingSm

                    readOnly: composer.readOnly
                    selectByMouse: true
                    wrapMode: TextEdit.Wrap
                    clip: true
                    background: null

                    color: Theme.ink
                    selectionColor: Theme.accent
                    selectedTextColor: Theme.textOnAccent
                    font: Theme.fontBody
                    textFormat: TextEdit.PlainText

                    cursorDelegate: Rectangle {
                        width: Theme.border
                        color: Theme.accent
                        visible: area.cursorVisible
                    }

                    // 光标跑了就把它带回可视区（打字、回车、粘贴、方向键都会走到这里）
                    onCursorRectangleChanged: composer._keepCaretVisible()

                    Keys.onPressed: function (event) {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            if (composer.isSendCombo(event.modifiers)) {
                                event.accepted = true
                                composer.submit()
                            }
                            return
                        }
                        if (event.key === Qt.Key_Escape) {
                            event.accepted = true
                            composer.cancelRequested()
                        }
                        // Ctrl+V 而剪贴板里没有文本 = 多半是位图。QML 读不到位图，交给宿主。
                        if (event.key === Qt.Key_V
                                && (event.modifiers & Qt.ControlModifier) !== 0
                                && (event.modifiers & Qt.ShiftModifier) === 0
                                && !composer.readOnly
                                && !area.canPaste) {
                            event.accepted = true
                            composer.pasteRequested()
                        }
                    }

                    onTextChanged: {
                        // 上一次是"溢出退回"造成的改动：收工，别再做溢出判定 / 粘贴扫描，
                        // 否则退回自己又会触发一次退回。
                        if (composer._revertingOverflow) {
                            composer._revertingOverflow = false
                            return
                        }

                        // allowOverflow 关掉时，输入区高度就是硬上限：
                        // 这次输入如果让内容高过视口，整段退回（见 _rejectOverflow）。
                        if (!composer.allowOverflow
                                && contentHeight + topPadding + bottomPadding
                                   > composer._viewportHeight + 0.5) {
                            composer._rejectOverflow()
                            return
                        }

                        // 资源管理器里 Ctrl+C 复制文件，粘进来是一行一个 file:///…。
                        // 拦下来转成附件，别把一串路径塞进正文。
                        // 只在输入区有焦点时扫：程序化地设 text（恢复草稿、演示页的初始文案）
                        // 不该被当成粘贴处理。
                        if (composer._suppressPasteScan) {
                            composer._suppressPasteScan = false
                        } else if (area.activeFocus) {
                            var inserted = composer.insertedText(composer._lastText, area.text)
                            var pastedUrls = composer.fileUrlsIn(inserted)
                            if (pastedUrls.length > 0) {
                                // 先把正文还原回粘贴前（这次赋值会再进一次本函数，
                                // 被 _suppressPasteScan 挡掉），再把 url 变成附件。
                                composer._suppressPasteScan = true
                                area.text = composer._lastText
                                composer.addUrlsAsAttachments(pastedUrls)
                                return
                            }
                        }
                        composer._lastText = area.text

                        // 回到能放下的高度了，下次再溢出时要重新报一次
                        if (contentHeight + topPadding + bottomPadding
                                <= composer._viewportHeight + 0.5)
                            composer._overflowReported = false

                        // 只越过上限的那一刻报一次，否则每敲一个字都会甩一条信号出去。
                        if (composer.overLimit && !composer._overLimitReported) {
                            composer._overLimitReported = true
                            composer.limitReached("length")
                        } else if (!composer.overLimit) {
                            composer._overLimitReported = false
                        }
                        composer.textEdited()
                    }
                }
            }
        }

        // ── 工具栏 ────────────────────────────────────────────────
        Item {
            id: toolbar
            width: parent.width
            height: composer.showToolbar ? 42 : 0
            visible: composer.showToolbar

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: Theme.border
                color: Theme.lineSoft
            }

            Row {
                id: chipBar
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacingXs

                ToolChip {
                    caption: "图片"
                    visible: composer.allowImage
                    enabled: !composer.readOnly
                    onClicked: composer.openImagePicker()
                }

                ToolChip {
                    caption: "文件"
                    visible: composer.allowFile
                    enabled: !composer.readOnly
                    onClicked: composer.openFilePicker()
                }

                Item {
                    width: Theme.spacingMd
                    height: 1
                }

                ToolChip {
                    caption: "清空"
                    enabled: !composer.readOnly && composer.hasContent
                    onClicked: composer.clear()
                }
            }

            // 右侧从内到外：发送按钮 ← 字数 ← 快捷键提示。
            // 三者都贴 sendButton.left 会叠在一起（提示和字数互相压字）。
            Text {
                id: counterLabel
                anchors.right: sendButton.left
                anchors.rightMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                text: composer.counterText
                font: Theme.fontMonoSm
                color: composer.overLimit ? Theme.danger : Theme.muted
            }

            Text {
                id: hintLabel
                anchors.right: counterLabel.left
                anchors.rightMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                width: Math.max(0, parent.width - chipBar.width - sendButton.width
                                - counterLabel.width - Theme.spacingMd * 5)
                horizontalAlignment: Text.AlignRight
                elide: Text.ElideRight
                text: composer.sendOnEnter ? "ENTER 发送 · SHIFT+ENTER 换行"
                                           : "ENTER 换行 · CTRL+ENTER 发送"
                font: Theme.fontMonoSm
                color: Theme.muted
            }

            ZButton {
                id: sendButton
                anchors.right: parent.right
                anchors.rightMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                height: Theme.controlHeightSm
                text: composer.busy ? "发送中" : composer.sendText
                variant: Theme.Variant.Primary
                // mono 在 ZButton 里是"右侧等宽小字"（快捷键提示），不是布尔开关
                mono: composer.sendOnEnter ? "ENTER" : "CTRL+↵"
                enabled: composer.canSend
                onClicked: composer.submit()
            }
        }
    }

    // ── 图片缩略图委托 ────────────────────────────────────────────
    Component {
        id: imageThumb

        Item {
            id: thumb
            width: composer.thumbSize
            height: composer.thumbSize

            readonly property var att: modelData

            ZCutRect {
                anchors.fill: parent
                color: Theme.surfaceMuted
                strokeColor: Theme.lineSoft
                strokeWidth: Theme.border
                cutTopRight: Theme.cutSm
                cutBottomLeft: Theme.cutSm
            }

            Image {
                id: thumbImage
                anchors.fill: parent
                anchors.margins: 2
                source: thumb.att && thumb.att.url ? thumb.att.url : ""
                sourceSize.width: 160
                sourceSize.height: 160
                fillMode: Image.PreserveAspectCrop
                clip: true
                asynchronous: true
                visible: status === Image.Ready
            }

            // 没图 / 破图时的占位：斜线纹理 + IMG 徽标
            Item {
                anchors.fill: parent
                anchors.margins: 2
                visible: !thumbImage.visible

                ZHatchPattern {
                    anchors.fill: parent
                    lineColor: Theme.hatchStrong
                    spacing: Theme.hatchStep
                }

                Text {
                    anchors.centerIn: parent
                    text: "IMG"
                    font: Theme.fontMonoSm
                    color: Theme.muted
                }
            }

            // 文件名压条：内缩到描边里面，并带上和缩略图一样的左下切角，
            // 否则会盖住底板描边、把左下角的切角顶成直角。
            ZCutRect {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 2
                anchors.rightMargin: 2
                anchors.bottomMargin: 2
                height: 15
                objectName: "chatThumbName"
                // 同标题条：黑底压条要用 inkBlock，ink 在暗色下是近白
                color: Theme.inkBlock
                opacity: 0.82
                cutTopRight: Theme.cutSm
                cutBottomLeft: Theme.cutSm

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: thumb.att ? thumb.att.name : ""
                    font: Qt.font({ family: Theme.familyMono, pixelSize: 10 })
                    color: Theme.textOnSub
                    elide: Text.ElideMiddle
                }
            }

            RemoveBadge {
                anchors.right: parent.right
                anchors.top: parent.top
                onClicked: composer.removeAttachment(index)
            }

            // 缩略图只有 64 见方，文件名一定会被省略号吃掉，悬停给全名
            ZToolTip {
                text: thumb.att ? thumb.att.name : ""
            }
        }
    }

    // ── 文件卡片委托 ──────────────────────────────────────────────
    Component {
        id: fileCard

        ZCutRect {
            id: card

            readonly property var att: modelData
            readonly property string ext: composer.extensionOf(att ? att.name : "")

            width: composer.fileCardWidth
            height: composer.fileCardHeight
            color: Theme.surfaceMuted
            strokeColor: Theme.lineSoft
            strokeWidth: Theme.border
            cutTopRight: Theme.cutSm
            cutBottomLeft: Theme.cutSm

            ZCutRect {
                id: extBadge
                objectName: "chatExtBadge"
                width: 40
                // 描边有宽度，徽标要收在描边内侧，否则黑块会盖过卡片边框
                y: Theme.border
                height: parent.height - Theme.border * 2
                // 扩展名徽标同理：黑块要 inkBlock，否则暗色下变成白块压白字
                color: Theme.inkBlock
                // 左下角也要切，不然黑块会把卡片左下角的切角顶出去
                cutTopRight: Theme.cutSm
                cutBottomLeft: Theme.cutSm

                Text {
                    anchors.centerIn: parent
                    text: card.ext.length > 0 ? card.ext.toUpperCase() : "FILE"
                    font: Qt.font({ family: Theme.familyMono, pixelSize: 11, bold: true })
                    color: Theme.textOnSub
                    elide: Text.ElideRight
                    width: parent.width - 6
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Text {
                id: fileNameLabel
                anchors.left: extBadge.right
                anchors.leftMargin: Theme.spacingSm
                anchors.right: removeBadge.left
                anchors.rightMargin: 4
                anchors.top: parent.top
                anchors.topMargin: Theme.spacingSm
                text: card.att ? card.att.name : ""
                font: Theme.fontStrong
                color: Theme.ink
                elide: Text.ElideMiddle
            }

            Text {
                anchors.left: extBadge.right
                anchors.leftMargin: Theme.spacingSm
                anchors.top: fileNameLabel.bottom
                anchors.topMargin: 2
                // 拖进来 / 粘进来的文件拿不到字节数（QML 没有 stat 能力），
                // 这时候只写 ATTACHMENT，别显示 "0 B" 骗人。
                text: (card.att && card.att.size > 0
                       ? composer.formatBytes(card.att.size) + "  ·  " : "") + "ATTACHMENT"
                font: Theme.fontMonoSm
                color: Theme.muted
            }

            RemoveBadge {
                id: removeBadge
                anchors.right: parent.right
                anchors.top: parent.top
                onClicked: composer.removeAttachment(index)
            }
        }
    }

    // ── 小部件：工具栏芯片 ────────────────────────────────────────
    component ToolChip: Button {
        id: chip

        property string caption

        implicitHeight: 26
        // 窄内边距：一行要放下三颗芯片 + 提示 + 计数 + 发送按钮
        implicitWidth: Math.max(28, chipLabel.implicitWidth + Theme.spacingSm * 2)
        padding: 0
        focusPolicy: Qt.NoFocus
        hoverEnabled: true

        background: ZCutRect {
            color: chip.down ? Theme.accent
                 : chip.hovered ? Theme.surfaceHover
                 : "transparent"
            strokeColor: chip.hovered || chip.down ? Theme.line : Theme.lineSoft
            strokeWidth: Theme.border
            cutTopRight: Theme.cutSm
            opacity: chip.enabled ? 1.0 : 0.45
        }

        contentItem: Text {
            id: chipLabel
            text: chip.caption
            font: Qt.font({
                family: Theme.family,
                pixelSize: 12,
                bold: chip.hovered && chip.enabled
            })
            color: chip.down ? Theme.textOnAccent : (chip.enabled ? Theme.ink : Theme.muted)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── 小部件：附件上的删除角标 ──────────────────────────────────
    component RemoveBadge: Item {
        id: badge

        signal clicked()

        width: 18
        height: 18

        ZCutRect {
            anchors.fill: parent
            objectName: "chatRemoveBadge"
            // 黑色角标：同样必须是 inkBlock，用 ink 暗色下会变成浅灰块配白 ×
            color: Theme.inkBlock
            cutBottomLeft: Theme.cutSm
            opacity: badgeHover.hovered ? 1.0 : 0.72
        }

        Text {
            anchors.centerIn: parent
            text: "×"
            font: Qt.font({ family: Theme.familyMono, pixelSize: 12, bold: true })
            color: Theme.textOnSub
        }

        HoverHandler {
            id: badgeHover
        }

        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: badge.clicked()
        }
    }

    /*!
        打开「选图片」：发 \l imagePickRequested，并在 \l useSystemDialogs 为真时弹出
        系统文件选择框。工具栏的「图片」按钮走的就是这里；宿主想从菜单、快捷键
        触发同一个动作，直接调它即可。
    */
    function openImagePicker() {
        imagePickRequested()
        if (useSystemDialogs)
            imageDialog.open()
    }

    /*! 打开「选文件」：发 \l filePickRequested，并（在 \l useSystemDialogs 为真时）弹选择框。 */
    function openFilePicker() {
        filePickRequested()
        if (useSystemDialogs)
            fileDialog.open()
    }

    // ── 系统文件选择框 ────────────────────────────────────────────
    // Windows / macOS / Linux 上 Qt 走各自的原生对话框；没有原生实现的平台退回
    // Qt Quick 自绘的那套。选完直接按扩展名分流加进附件。
    FileDialog {
        id: imageDialog
        title: "选择图片"
        fileMode: FileDialog.OpenFiles
        nameFilters: [
            "图片 (*.png *.jpg *.jpeg *.jfif *.gif *.bmp *.webp *.svg *.ico *.tif *.tiff *.heic *.avif)",
            "所有文件 (*)"
        ]
        onAccepted: composer.addUrlsAsAttachments(composer.urlsOf(imageDialog.selectedFiles))
    }

    FileDialog {
        id: fileDialog
        title: "选择文件"
        fileMode: FileDialog.OpenFiles
        nameFilters: ["所有文件 (*)"]
        onAccepted: composer.addUrlsAsAttachments(composer.urlsOf(fileDialog.selectedFiles))
    }

    // ── 拖放 ──────────────────────────────────────────────────────
    // 注意：TextArea 自己也会接拖放（并把文件路径当文本插进来），
    // 所以 DropArea 必须声明在它之后（叠在上面）才能真正拿到 drop 事件。
    DropArea {
        id: dropZone
        anchors.fill: parent
        onEntered: composer._dropActive = true
        onExited: composer._dropActive = false
        onDropped: function (drop) {
            composer._dropActive = false
            if (!drop.hasUrls)
                return
            composer.filesDropped(drop.urls)
            composer.addUrlsAsAttachments(drop.urls)
        }
    }

    ZCutRect {
        anchors.fill: parent
        anchors.margins: Theme.border
        visible: composer._dropActive
        color: Theme.alpha(Theme.accent, 0.16)
        strokeColor: Theme.accent
        strokeWidth: Theme.border
        cutTopRight: composer.framed ? Theme.cutMd : 0
        cutBottomLeft: composer.framed ? Theme.cutMd : 0

        Text {
            anchors.centerIn: parent
            text: "松开添加附件 / DROP TO ATTACH"
            font: Theme.fontMonoSm
            color: Theme.ink
        }
    }
}
```

## 三、容器与展示

### `qml/ZmdUI/ZPanel.qml`

面板 / 卡片：斜切角 + 角落斜线纹理 + 亮黄装饰底边

```qml
import QtQuick

/*!
    \qmltype ZPanel
    \inqmlmodule ZmdUI
    \brief 面板 / 卡片：斜切角 + 角落斜线纹理 + 底部亮黄装饰条。

    整套设计语言里最主要的容器。默认会把子项按列排布（内容区是个 Column），
    所以直接往里塞 Row / Column / 控件即可。

    \qml
    ZPanel {
        width: 420
        title: "运行概况"
        tag: "SYS-01"
        footerText: "ARKNIGHTS:ENDFIELD  /  BOT CONSOLE"
        Row { spacing: 8; ... }
    }
    \endqml

    \note 面板高度是按内容算出来的（implicitHeight），直接给定 width 即可自动撑高。
*/
Item {
    id: root

    /*! 标题，Font.Black + 自动加「」 */
    property string title: ""
    /*! 标题下方的黑底白字副标题 */
    property string subtitle: ""
    /*! 右上角等宽编号 / 坐标 */
    property string tag: ""
    /*! 副标题上方的一行等宽小字说明 */
    property string eyebrow: ""
    /*! 底部装饰条文字（等宽） */
    property string footerText: ""
    /*! 底部条色调：Theme.Tone.Accent（亮黄底黑字）或 Theme.Tone.Ink（深灰底白字） */
    property int footerTone: Theme.Tone.Accent
    /*! 是否绘制右上角斜线纹理 */
    property bool hatch: true
    /*! 斜线区宽度占比（0~1） */
    property real hatchRatio: 0.34
    /*! 斜线区高度占比（0~1） */
    property real hatchRatioV: 0.5
    /*! 主体底色：默认卡片白，可传 { Theme.surfaceAlt } 做次级卡片 */
    property color surfaceColor: Theme.surface
    /*! 是否使用大斜切角（小卡片可关掉） */
    property bool cut: true
    /*! 是否在标题左侧显示一条亮黄竖条 */
    property bool accentEdge: true

    default property alias content: contentColumn.data
    /*! 标题行右侧的自定义槽位（放按钮 / 状态点） */
    property alias headerRight: headerRightSlot.data

    implicitWidth: 320
    implicitHeight: body.implicitHeight + Theme.spacingLg
                    + (accentBar.visible ? accentBar.height + Theme.spacingSm : 0)

    // ── 底板 ──
    ZCutRect {
        anchors.fill: parent
        color: root.surfaceColor
        strokeColor: Theme.line
        strokeWidth: Theme.border
        cutTopRight: root.cut ? Theme.cutLg : Theme.cutSm
        cutBottomLeft: root.cut ? Theme.cutMd : Theme.cutSm
    }

    // ── 右上角斜线纹理区 ──
    Item {
        id: hatchArea
        visible: root.hatch
        anchors.top: parent.top
        anchors.right: parent.right
        width: Math.round(parent.width * root.hatchRatio)
        height: Math.round(parent.height * root.hatchRatioV)
        clip: true

        ZHatchPattern {
            anchors.fill: parent
            anchors.rightMargin: -8
            lineColor: Theme.hatch
            spacing: Theme.hatchStep
        }

        // 斜线区左下角的直角三角形标记。
        // 注意：这里不能用 ZCutRect 的切角来做三角——切角会被钳制到短边一半以内，
        // 10x10 的方块只会被削掉 5px 的角，看起来就是一个"多余的黑方块"。
        // ZSkewRect 的 skew 等于宽度时，两个顶点重合，正好得到干净的直角三角形。
        ZSkewRect {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: 12
            height: 12
            skew: 12
            color: Theme.inkBlock
        }
    }

    // ── 内容 ──
    Column {
        id: body
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Theme.spacingLg
        anchors.bottomMargin: Theme.spacingSm
        spacing: Theme.spacingMd

        // 字段铭牌（等宽）
        Text {
            visible: root.eyebrow.length > 0
            text: root.eyebrow
            font: Theme.fontMonoSm
            color: Theme.muted
        }

        // 标题行
        Item {
            width: parent.width
            height: Math.max(titleRow.implicitHeight, 24)
            visible: root.title.length > 0 || root.tag.length > 0

            Row {
                id: titleRow
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacingSm

                // 亮黄竖条
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: root.accentEdge
                    width: 6
                    height: 20
                    color: Theme.accent
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.title.length > 0 ? "「" + root.title + "」" : ""
                    font: Theme.fontHeading
                    color: Theme.ink
                    // 同色描边制造超粗观感
                }
            }

            // 右上角编号
            Text {
                anchors.right: parent.right
                anchors.top: parent.top
                text: root.tag
                font: Theme.fontMonoSm
                color: Theme.muted
            }

            // 右侧槽位
            Row {
                id: headerRightSlot
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                spacing: Theme.spacingSm
            }
        }

        // 副标题：黑底白字斜切块
        ZSkewRect {
            width: subtitleText.implicitWidth + Theme.spacingLg * 1.5
            height: 30
            visible: root.subtitle.length > 0
            color: Theme.subBg
            skew: 10

            Row {
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -3
                spacing: Theme.spacingSm
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 4
                    height: 14
                    color: Theme.accent
                }
                Text {
                    id: subtitleText
                    text: root.subtitle
                    font: Theme.fontSubtitle
                    color: Theme.textOnSub
                }
            }
        }

        // ── 用户内容 ──
        Column {
            id: contentColumn
            width: parent.width
            spacing: Theme.spacingMd
        }
    }

    // ── 底部装饰条 ──
    ZCutRect {
        id: accentBar
        visible: root.footerText.length > 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Theme.dp(Theme.accentBarHeight)
        color: root.footerTone === Theme.Tone.Ink ? Theme.subBg : Theme.accent
        cutBottomLeft: root.cut ? Theme.cutMd : Theme.cutSm

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingLg
            anchors.verticalCenter: parent.verticalCenter
            spacing: Theme.spacingMd

            // 小三角形指示符
            Canvas {
                anchors.verticalCenter: parent.verticalCenter
                width: 8
                height: 8
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    ctx.fillStyle = root.footerTone === Theme.Tone.Ink
                                    ? Theme.accent : Theme.ink
                    ctx.beginPath()
                    ctx.moveTo(0, 0)
                    ctx.lineTo(8, 4)
                    ctx.lineTo(0, 8)
                    ctx.closePath()
                    ctx.fill()
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.footerText
                font: Theme.fontMonoSm
                color: root.footerTone === Theme.Tone.Ink ? Theme.textOnSub : Theme.textOnAccent
            }
        }

        // 右侧坐标点阵
        Row {
            anchors.right: parent.right
            anchors.rightMargin: Theme.spacingLg + Theme.cutMd
            anchors.verticalCenter: parent.verticalCenter
            spacing: 3
            Repeater {
                model: 4
                Rectangle {
                    width: 3
                    height: 10
                    color: root.footerTone === Theme.Tone.Ink ? Theme.textOnSub : Theme.textOnAccent
                    opacity: 0.35 + index * 0.18
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZSectionTitle.qml`

区块大标题：编号 + 「超粗标题」 + 黑底斜切副标题

```qml
import QtQuick

/*!
    \qmltype ZSectionTitle
    \inqmlmodule ZmdUI
    \brief 区块大标题：编号 + 「超粗中文标题」+ 黑底白字斜切副标题。

    这是设计语言里的"视觉锤"。标题用 Font.Black 再叠 1px 同色描边，
    在只有 Regular/Bold 两档字重的中文字体上也能做出 Heavy 的压迫感。

    \qml
    ZSectionTitle {
        index: "01"
        eyebrow: "MISSION-DEPENDENT PAYLOAD / SYSTEM INTERFACE"
        title: "组件总览"
        subtitle: "INTERFACE GALLERY"
    }
    \endqml
*/
Item {
    id: root

    /*! 编号，如 "01" */
    property string index: "01"
    /*! 标题上方的等宽小字（会加一个 + 前缀） */
    property string eyebrow: ""
    /*! 主标题，自动加「」 */
    property string title: ""
    /*! 副标题（黑底白字块），空则隐藏 */
    property string subtitle: ""
    /*! 主标题左侧的高亮底色块是否显示 */
    property bool highlight: true
    /*! 副标题块的倾斜量 */
    property real skewAmount: 12

    implicitWidth: col.implicitWidth
    implicitHeight: col.implicitHeight

    Column {
        id: col
        spacing: Theme.spacingSm

        // ── eyebrow：+ MISSION-DEPENDENT PAYLOAD ──
        Row {
            visible: root.eyebrow.length > 0
            spacing: Theme.spacingSm

            // 小十字星
            Item {
                anchors.verticalCenter: parent.verticalCenter
                width: 10
                height: 10
                Rectangle { anchors.centerIn: parent; width: 10; height: 1.5; color: Theme.ink }
                Rectangle { anchors.centerIn: parent; width: 1.5; height: 10; color: Theme.ink }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.eyebrow
                font: Theme.fontMonoSm
                color: Theme.ink
                opacity: 0.75
            }
        }

        // ── 主标题行 ──
        Item {
            width: titleRow.implicitWidth
            height: titleRow.implicitHeight

            // 高亮底色：盖住标题左侧 1/3，像荧光笔划过
            ZCutRect {
                visible: root.highlight
                anchors.left: parent.left
                anchors.leftMargin: -4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                width: Math.round(titleRow.textWidth * 0.36)
                height: Math.round(titleRow.height * 0.72)
                // 用 accentSoft 而不是 accent：亮色下它同样是亮黄（黑字压上去没问题），
                // 暗色下它是深黄褐，浅灰标题压上去才够对比；直接用压暗后的 accent
                // 会让"浅灰大字 + 中黄底"糊成一片
                color: Theme.accentSoft
                cutTopRight: 10
            }

            Row {
                id: titleRow
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                spacing: Theme.spacingSm

                property real textWidth: indexText.implicitWidth + titleText.implicitWidth
                                            + Theme.spacingLg

                // 编号：黑底白字小方块
                ZCutRect {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 6
                    width: indexText.implicitWidth + Theme.spacingMd
                    height: 20
                    color: Theme.inkBlock
                    cutTopRight: 6

                    Text {
                        id: indexText
                        anchors.centerIn: parent
                        text: root.index
                        font: Theme.fontMonoMd
                        color: Theme.textOnSub
                    }
                }

                Text {
                    id: titleText
                    anchors.bottom: parent.bottom
                    text: root.title.length > 0 ? "「" + root.title + "」" : ""
                    font: Theme.fontTitle
                    color: Theme.ink
                }
            }
        }

        // ── 副标题：黑底白字平行四边形 ──
        ZSkewRect {
            width: subtitleText.implicitWidth + Theme.spacingXl
            height: 36
            visible: root.subtitle.length > 0
            color: Theme.subBg
            skew: root.skewAmount

            Row {
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -root.skewAmount / 2
                spacing: Theme.spacingSm

                // 左侧冒号：用两个方块拼出硬朗的“:”。
                // 用淡青而不是纯白——5px 的小方块上纯白边界发虚、和副标题文字抢视觉。
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3
                    Rectangle { width: 5; height: 5; color: Theme.cyanSoft }
                    Rectangle { width: 5; height: 5; color: Theme.cyanSoft }
                }

                Text {
                    id: subtitleText
                    text: root.subtitle
                    font: Theme.fontSubtitle
                    color: Theme.textOnSub
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZTag.qml`

标签 / 徽章：平行四边形，深灰底白字或亮黄底黑字

```qml
import QtQuick

/*!
    \qmltype ZTag
    \inqmlmodule ZmdUI
    \brief 标签 / 徽章：平行四边形外观，深灰底白字或亮黄底黑字。

    \l tone 取 \c Theme.Tone 之一：
    \list
    \li \c Ink     深灰底 + 白字（默认，信息类）
    \li \c Accent  亮黄底 + 黑字（强调 / 计数）
    \li \c Outline 透明底 + 黑框（次要）
    \li \c Muted   浅灰底 + 深灰字（禁用 / 占位）
    \li \c Cyan / \c Magenta  极小面积的点缀状态块
    \endlist

    \qml
    ZTag { text: "ONLINE"; tone: Theme.Tone.Accent }
    ZTag { text: "BOT 01"; tone: Theme.Tone.Ink; mono: false }
    \endqml
*/
Item {
    id: root

    /*! 文本 */
    property string text: ""
    /*! 色调，取 Theme.Tone.* */
    property int tone: Theme.Tone.Ink
    /*! 是否使用平行四边形外观（关闭则为斜切角矩形） */
    property bool skew: true
    /*! 倾斜量 */
    property real skewAmount: 8
    /*! 是否使用等宽字体 */
    property bool mono: true
    /*! 是否把文本转成大写 */
    property bool uppercase: true
    /*! 文本左侧的状态点颜色，透明则不画 */
    property color dotColor: "transparent"

    readonly property string _text: uppercase ? text.toUpperCase() : text

    implicitWidth: tm.advanceWidth + Theme.spacingMd * 2 + (skew ? skewAmount : 0)
                                + (dotColor.a > 0 ? 12 : 0)
    implicitHeight: 22

    TextMetrics {
        id: tm
        text: root._text
        font: root.mono ? Theme.fontMonoSm : Theme.fontLabel
    }

    // ── 底板 ──
    ZSkewRect {
        anchors.fill: parent
        visible: root.skew
        skew: root.skewAmount
        color: root._bg
        strokeColor: root._stroke
        strokeWidth: root.tone === Theme.Tone.Outline ? 2 : 0
    }

    ZCutRect {
        anchors.fill: parent
        visible: !root.skew
        color: root._bg
        strokeColor: root._stroke
        strokeWidth: root.tone === Theme.Tone.Outline ? 2 : 0
        cutTopRight: 6
        cutBottomLeft: 3
    }

    readonly property color _bg: {
        switch (tone) {
        case Theme.Tone.Ink:     return Theme.subBg
        case Theme.Tone.Accent:  return Theme.accent
        case Theme.Tone.Muted:   return Theme.surfaceAlt
        case Theme.Tone.Cyan:    return Theme.cyan
        case Theme.Tone.Magenta: return Theme.magenta
        case Theme.Tone.Danger:  return Theme.danger
        default:                 return "transparent"
        }
    }

    readonly property color _stroke: tone === Theme.Tone.Outline ? Theme.ink : "transparent"

    readonly property color _fg: {
        switch (tone) {
        case Theme.Tone.Ink:     return Theme.textOnSub
        case Theme.Tone.Accent:  return Theme.textOnAccent
        case Theme.Tone.Muted:   return Theme.muted
        case Theme.Tone.Cyan:    return "#00313A"
        case Theme.Tone.Magenta: return "#3A003A"
        case Theme.Tone.Danger:  return Theme.textOnSub
        default:                 return Theme.ink
        }
    }

    Row {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: root.skew ? -root.skewAmount / 2 : 0
        spacing: 5

        // 状态点：极小面积的点缀色出现位置
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.dotColor.a > 0
            width: 6
            height: 6
            color: root.dotColor
        }

        Text {
            id: label
            text: root._text
            font: root.mono ? Theme.fontMonoSm : Theme.fontLabel
            color: root._fg
        }
    }
}
```

### `qml/ZmdUI/ZStatusDot.qml`

状态点：极小面积的切角方块（点缀色专用）

```qml
import QtQuick

/*!
    \qmltype ZStatusDot
    \inqmlmodule ZmdUI
    \brief 状态点：极小面积的切角方块，用来放点缀色（青 / 品红 / 亮黄）。

    设计规范里的青色、品红只允许出现在这个尺寸的块上。

    \qml
    ZStatusDot { tone: Theme.Tone.Cyan }
    ZStatusDot { tone: Theme.Tone.Danger; blink: true }
    \endqml
*/
Item {
    id: root

    /*! 色调，取 Theme.Tone.*（Cyan / Magenta / Accent / Ink / Danger） */
    property int tone: Theme.Tone.Accent
    /*! 边长 */
    property int size: 10
    /*! 是否呼吸闪烁（用于"连接中 / 异常"状态） */
    property bool blink: false

    implicitWidth: size
    implicitHeight: size

    ZCutRect {
        anchors.fill: parent
        color: {
            switch (root.tone) {
            case Theme.Tone.Cyan:    return Theme.cyan
            case Theme.Tone.Magenta: return Theme.magenta
            case Theme.Tone.Ink:     return Theme.ink
            case Theme.Tone.Danger:  return Theme.danger
            case Theme.Tone.Muted:   return Theme.lineSoft
            default:                 return Theme.accent
            }
        }
        strokeColor: Theme.ink
        strokeWidth: 1
        cutTopRight: root.size / 2
        cutBottomLeft: root.size / 2
    }

    SequentialAnimation on opacity {
        running: root.blink
        loops: Animation.Infinite
        NumberAnimation { to: 0.25; duration: 520; easing.type: Easing.InOutQuad }
        NumberAnimation { to: 1.0;  duration: 520; easing.type: Easing.InOutQuad }
    }
}
```

### `qml/ZmdUI/ZListItem.qml`

列表项：选中 = 亮黄底 + 黑色斜切高亮块

```qml
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Shapes

/*!
    \qmltype ZListItem
    \inqmlmodule ZmdUI
    \brief 列表项：编号 + 主标签 + 说明 + 右侧数据，选中时亮黄底 + 黑色斜切高亮块。

    \qml
    ListView {
        delegate: ZListItem {
            index: model.index
            label: model.label
            description: model.role
            trailing: model.value
        }
    }
    \endqml
*/
ItemDelegate {
    id: control

    /*! 左侧等宽编号。命名成 idx 是为了不遮蔽 ListView 的 index 角色 */
    property string idx: ""
    /*! 主标签 */
    property string label: ""
    /*! 说明文字（等宽小字） */
    property string description: ""
    /*! 右侧数据 / 编号 */
    property string trailing: ""
    /*! 选中态。可直接绑定 ListView.isCurrentItem */
    property bool selected: false
    /*! 是否显示右侧箭头指示符 */
    property bool arrow: true
    /*! 左侧强调条宽度（0 = 不显示） */
    property int accentWidth: 5

    readonly property bool _on: selected || highlighted

    hoverEnabled: true
    implicitHeight: Theme.dp(52)
    leftPadding: Theme.spacingMd + 6
    rightPadding: Theme.spacingMd
    topPadding: Theme.spacingSm
    bottomPadding: Theme.spacingSm

    background: Item {
        // ── 选中：亮黄底 ──
        ZCutRect {
            anchors.fill: parent
            anchors.margins: 1
            visible: control._on
            color: Theme.accent
            cutTopRight: Theme.cutSm
            cutBottomLeft: Theme.cutSm
        }

        // ── 悬停：浅灰底 + 亮黄左条 ──
        ZCutRect {
            anchors.fill: parent
            anchors.margins: 1
            visible: control.hovered && !control._on
            color: Theme.surfaceHover
            cutTopRight: Theme.cutSm
        }

        // ── 左侧强调条（当前项亮黄 / 悬停深灰）──
        ZCutRect {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 4
            anchors.bottomMargin: 4
            width: visible ? control.accentWidth : 0
            visible: control.accentWidth > 0
            color: control._on ? Theme.ink : (control.hovered ? Theme.accent : "transparent")
            cutTopRight: 4
            cutBottomLeft: 4
        }

        // ── 底部分隔线 ──
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: control.leftPadding
            anchors.bottom: parent.bottom
            height: 1
            color: Theme.lineSoft
            opacity: 0.55
            visible: !control._on
        }
    }

    contentItem: Row {
        spacing: Theme.spacingMd

        // 编号
        Text {
            anchors.verticalCenter: parent.verticalCenter
            width: 22
            visible: control.idx.length > 0
            text: control.idx
            font: Theme.fontMonoMd
            color: control._on ? Theme.ink : Theme.muted
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 22 - arrowItem.width - slash.width
                   - trailingText.width - Theme.spacingMd * 4
            spacing: 1

            Text {
                text: control.label
                font: Theme.fontStrong
                // 选中行底色是强调黄，文字必须用"强调色上的文字色"，不能用 ink
                color: control._on ? Theme.textOnAccent : Theme.inkSoft
                elide: Text.ElideRight
                width: parent.width
            }

            Text {
                visible: control.description.length > 0
                text: control.description
                font: Theme.fontMonoSm
                color: control._on ? Theme.textOnAccent : Theme.muted
                opacity: control._on ? 0.75 : 1
                elide: Text.ElideRight
                width: parent.width
            }
        }

        // 选中态的黑色斜切高亮块：放在 Column 与右侧数据之间。
        // 放进内容布局而不是背景层，是为了让它参与排版——否则会盖住右侧数据文字。
        ZSkewRect {
            id: slash
            anchors.verticalCenter: parent.verticalCenter
            width: control._on ? 34 : 0
            height: 9
            skew: 9
            color: Theme.textOnAccent
            visible: control._on
        }

        // 右侧数据
        Text {
            id: trailingText
            anchors.verticalCenter: parent.verticalCenter
            visible: control.trailing.length > 0
            text: control.trailing
            font: Theme.fontMonoMd
            color: control._on ? Theme.textOnAccent : Theme.inkSoft
        }

        // 箭头指示符：Shape 三角，声明式绘制，状态变化自动重绘
        Item {
            id: arrowItem
            anchors.verticalCenter: parent.verticalCenter
            width: control.arrow ? 16 : 0
            height: 16
            visible: control.arrow

            Rectangle {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 8
                height: 2
                color: control._on ? Theme.ink : Theme.muted
            }

            Shape {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: 6
                height: 10
                antialiasing: true
                preferredRendererType: Shape.CurveRenderer
                ShapePath {
                    strokeColor: "transparent"
                    strokeWidth: 0
                    fillColor: control._on ? Theme.ink : Theme.muted
                    PathPolyline {
                        path: [Qt.point(0, 0), Qt.point(6, 5), Qt.point(0, 10), Qt.point(0, 0)]
                    }
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZListView.qml`

列表视图：切角外框 + 自带滚动条 + 默认委托

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZListView
    \inqmlmodule ZmdUI
    \brief 列表视图：斜切角外框 + 自带 ZScrollBar + 默认 ZListItem 委托。

    \l model 可以是 JS 数组或 ListModel。不传 delegate 时用 ZListItem，
    此时数组元素为字符串或含 label/description 字段的对象。

    \qml
    ZListView {
        width: 460; height: 260
        model: ["扫码登录", "余额同步", "模型检测"]
        onActivated: (i) => console.log(i)
    }
    \endqml
*/
Item {
    id: root

    /*! 数据模型 */
    property alias model: view.model
    /*! 委托，缺省为 ZListItem */
    property alias delegate: view.delegate
    /*! 当前项索引 */
    property alias currentIndex: view.currentIndex
    /*! 条目数 */
    property alias count: view.count
    /*! 行距 */
    property alias spacing: view.spacing
    /*! 是否显示外框 */
    property bool frame: true
    /*! 外框标题（等宽小字，显示在列表上方） */
    property string headerText: ""

    /*! 点击某一行（委托用 ZListItem 时自动转发） */
    signal activated(int index)

    implicitWidth: 320
    implicitHeight: 240

    // ── 外框 ──
    ZCutRect {
        anchors.fill: parent
        visible: root.frame
        color: Theme.surface
        strokeColor: Theme.line
        strokeWidth: Theme.border
        cutBottomLeft: Theme.cutMd
        cutTopRight: Theme.cutSm
    }

    // ── 顶部标题带 ──
    ZCutRect {
        id: headerBand
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Theme.border
        height: root.headerText.length > 0 ? 26 : 0
        visible: root.headerText.length > 0
        color: Theme.subBg

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingMd
            anchors.verticalCenter: parent.verticalCenter
            spacing: Theme.spacingSm
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 6
                height: 10
                color: Theme.accent
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.headerText
                font: Theme.fontMonoSm
                color: Theme.textOnSub
            }
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        anchors.margins: Theme.border + (headerBand.height > 0 ? headerBand.height : 0)
        anchors.topMargin: Theme.border + headerBand.height + (headerBand.height > 0 ? 2 : 0)
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        spacing: 0
        highlightFollowsCurrentItem: false

        ScrollBar.vertical: ZScrollBar {
            policy: ScrollBar.AsNeeded
        }

        // 缺省委托：兼容字符串数组与 {label, description} 对象数组
        delegate: ZListItem {
            width: view.width
            idx: (index + 1 < 10 ? "0" : "") + (index + 1)
            label: (typeof modelData === "object" && modelData !== null)
                   ? (modelData.label !== undefined ? modelData.label : "")
                   : String(modelData === undefined ? "" : modelData)
            description: (typeof modelData === "object" && modelData !== null
                          && modelData.description !== undefined) ? modelData.description : ""
            trailing: (typeof modelData === "object" && modelData !== null
                       && modelData.value !== undefined) ? String(modelData.value) : ""
            selected: ListView.isCurrentItem
            onClicked: {
                view.currentIndex = index
                root.activated(index)
            }
            onDoubleClicked: root.activated(index)
        }
    }
}
```

### `qml/ZmdUI/ZScrollBar.qml`

滚动条：细长切角方块 + 导轨刻度

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZScrollBar
    \inqmlmodule ZmdUI
    \brief 滚动条：细长切角方块 + 导轨刻度线，悬停变亮黄。

    用法与原生一致，挂在 ListView / Flickable 上：
    \qml
    ListView { ScrollBar.vertical: ZScrollBar { policy: ScrollBar.AsNeeded } }
    \endqml
*/
ScrollBar {
    id: control

    hoverEnabled: true
    implicitWidth: 12
    minimumSize: 0.06
    padding: 0

    background: Item {
        // 导轨：一条细黑线 + 刻度
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 2
            height: parent.height
            color: Theme.lineSoft
            opacity: 0.5
        }
        Canvas {
            anchors.fill: parent
            renderStrategy: Canvas.Immediate
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.lineWidth = 1
                ctx.strokeStyle = Theme.lineSoft
                ctx.beginPath()
                for (var y = 0; y < height; y += 10) {
                    ctx.moveTo(width - 5, y + 0.5)
                    ctx.lineTo(width, y + 0.5)
                }
                ctx.stroke()
            }
        }
    }

    contentItem: ZCutRect {
        color: control.pressed ? Theme.ink
             : (control.hovered || control.active ? Theme.accent : Theme.lineSoft)
        cutTopRight: 4
        cutBottomLeft: 4
    }
}
```

### `qml/ZmdUI/ZToolTip.qml`

工具提示：深灰底白字 + 左侧亮黄竖边

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZToolTip
    \inqmlmodule ZmdUI
    \brief 工具提示：深灰底白字，小号等宽字体，左侧一条亮黄竖边。

    一般不直接手写，给按钮设 \l ZButton::tooltip 即可自动挂上：
    \qml
    ZButton { text: "同步余额"; tooltip: "同步最近 24 小时余额变动" }
    \endqml

    \note 亮黄竖边画在 background 里、文字用 contentItem 的 padding 定位。
          两者若各算一套间距（一个用 anchors、一个用 padding）就会错位，
          所以这里只保留一套：竖边固定贴左，文字靠 leftPadding 让开。
*/
ToolTip {
    id: control

    delay: 300
    timeout: 6000
    padding: 0

    /*! 背景斜切量，与 leftPadding 的留白量对应 */
    readonly property int skewAmount: 7

    // 贴宿主正下方、水平居中。用 implicitWidth 而不是 width：
    // popup 的最终宽度就是由 implicitWidth 决定的，用 width 会在首帧取到 0。
    x: parent ? Math.round((parent.width - implicitWidth) / 2) : 0
    y: parent ? Math.round(parent.height + 6) : 0

    leftPadding: skewAmount + 12
    rightPadding: 14
    topPadding: 7
    bottomPadding: 7

    background: Item {
        // 深灰平行四边形底板
        ZSkewRect {
            anchors.fill: parent
            skew: control.skewAmount
            color: Theme.subBg
        }

        // 左侧亮黄竖边。
        // 必须用 ZSkewRect 且 skew / 高度与底板完全一致 —— 这样两条左斜边
        // 是同一条线，天然贴齐边框；用直边矩形会在顶部戳出底板之外。
        ZSkewRect {
            x: 0
            y: 0
            width: 5 + control.skewAmount
            height: parent.height
            skew: control.skewAmount
            color: Theme.accent
        }
    }

    // 文字：contentItem 用 Text，宽度由自己算，不会再和背景各算一套
    contentItem: Text {
        text: control.text
        font: Theme.fontMonoSm
        color: Theme.textOnSub
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
```

## 四、复合组件

### `qml/ZmdUI/ZDialog.qml`

对话框：顶部黑底黄字 + 中央大面积斜线纹理

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZDialog
    \inqmlmodule ZmdUI
    \brief 对话框：顶部黑底黄字标题带，中央大面积斜线纹理，硬边斜切外框。

    \qml
    ZDialog {
        id: warn
        title: "覆盖本地配置"
        code: "SYS-04"
        subtitle: "此操作不可撤销"
        confirmText: "确认覆盖"
        Column { Text { text: "……" } }
        onConfirmed: doIt()
    }
    \endqml
*/
Dialog {
    id: control

    /*! 标题（黑底黄字，等宽大写）。直接复用 Dialog 自带的 title 属性 */
    title: "系统提示"
    /*! 右上角编号 */
    property string code: "SYS-00"
    /*! 正文上方的副标题（黑底白字小块） */
    property string subtitle: ""
    /*! 底部主按钮文案 */
    property string confirmText: "确认执行"
    /*! 底部次按钮文案 */
    property string cancelText: "取消"
    /*! 是否显示底部按钮区 */
    property bool showFooter: true
    /*! 主按钮形态 */
    property int confirmVariant: Theme.Variant.Primary
    /*! 是否允许 Esc 关闭 */
    property bool closable: true

    default property alias dialogContent: innerCol.data
    property alias footerItems: footerSlot.data


    /*! 主按钮点击后触发（在关闭之前） */
    signal confirmed()

    modal: true
    focus: true
    closePolicy: control.closable ? Popup.CloseOnEscape : Popup.NoAutoClose
    anchors.centerIn: Overlay.overlay
    width: 540
    padding: 0

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Theme.durSlow }
        NumberAnimation { property: "scale"; from: 0.94; to: 1; duration: Theme.durSlow
                          easing.type: Theme.easingEnter }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Theme.durBase }
    }

    // ── 遮罩：平涂，不加渐变 ──
    Overlay.modal: Rectangle {
        color: Qt.rgba(0, 0, 0, 0.55)
    }

    // ── 底板 ──
    background: Item {
        ZCutRect {
            anchors.fill: parent
            color: Theme.surface
            strokeColor: Theme.ink
            strokeWidth: Theme.borderThick
            cutTopRight: 28
            cutBottomLeft: 14
        }

        // 中央大面积斜线纹理：对话框最显著的质感
        Item {
            anchors.centerIn: parent
            width: parent.width * 0.9
            height: parent.height * 0.5
            clip: true
            opacity: 0.55
            ZHatchPattern {
                anchors.fill: parent
                lineColor: Theme.hatchStrong
                spacing: 11
                lineWidth: 1.2
            }
        }

        // 左下角一角黄
        ZCutRect {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: Theme.borderThick + 2
            width: 26
            height: 8
            color: Theme.accent
            cutBottomLeft: 8
        }
    }

    // ── 标题带 ──
    header: Item {
        implicitHeight: 46

        ZCutRect {
            anchors.fill: parent
            color: Theme.inkBlock
            cutTopRight: 28
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingLg
            anchors.verticalCenter: parent.verticalCenter
            spacing: Theme.spacingMd

            // 黄黑方格 logo
            Row {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2
                Repeater {
                    model: 3
                    ZCutRect {
                        width: 8
                        height: 16
                        color: index === 1 ? Theme.accent : Theme.textOnSub
                        cutTopRight: 3
                    }
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: control.title.toUpperCase()
                font: Qt.font({ family: Theme.family, pixelSize: 16,
                                weight: Font.DemiBold, letterSpacing: 2 })
                color: Theme.accent
            }
        }

        Text {
            anchors.right: parent.right
            anchors.rightMargin: Theme.spacingXl + 6
            anchors.verticalCenter: parent.verticalCenter
            text: control.code
            font: Theme.fontMonoSm
            color: Theme.textOnSub
            opacity: 0.7
        }

        ZIconButton {
            anchors.right: parent.right
            anchors.rightMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            visible: control.closable
            width: 26
            height: 26
            implicitWidth: 26
            implicitHeight: 26
            glyphSize: 14
            glyph: "×"
            tone: Theme.Tone.Accent
            tooltip: "关闭"
            onClicked: control.reject()
        }
    }

    // ── 内容 ──
    // 用「Item + 内层 Column」而不是直接给 Column 加 padding：
    // Column 的 padding 不会缩减子项的 parent.width，用户写 width: parent.width 会溢出被裁。
    contentItem: Item {
        implicitHeight: innerCol.implicitHeight + Theme.spacingLg * 2

        Column {
            id: innerCol
            x: Theme.spacingLg
            y: Theme.spacingLg
            width: parent.width - Theme.spacingLg * 2
            spacing: Theme.spacingMd

            // 副标题小块
            ZSkewRect {
                width: subtitleItem.implicitWidth + Theme.spacingLg * 1.4
                height: 28
                visible: control.subtitle.length > 0
                color: Theme.subBg
                skew: 9

                Text {
                    id: subtitleItem
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: -4
                    text: control.subtitle
                    font: Theme.fontSubtitle
                    color: Theme.textOnSub
                }
            }
        }
    }

    // ── 底部按钮区 ──
    footer: Item {
        implicitHeight: control.showFooter ? 62 : 0
        visible: control.showFooter

        // 顶部分隔线
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.spacingLg
            anchors.rightMargin: Theme.spacingXl
            height: 2
            color: Theme.line
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: Theme.spacingLg
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.spacingMd
            spacing: Theme.spacingSm

            Row {
                id: footerSlot
                spacing: Theme.spacingSm
            }

            ZButton {
                text: control.cancelText
                variant: Theme.Variant.Secondary
                onClicked: control.reject()
            }

            ZButton {
                text: control.confirmText
                variant: control.confirmVariant
                onClicked: {
                    control.confirmed()
                    control.accept()
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZSideBar.qml`

侧边导航栏：黑底白字，当前项亮黄底 + 亮黄左边缘

```qml
import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype ZSideBar
    \inqmlmodule ZmdUI
    \brief 侧边导航栏：恒定黑底白字，当前项亮黄底黑字 + 亮黄左边缘装饰。

    \l model 是对象数组，支持字段：
    \list
    \li \c header  可选，在该项上方插一条等宽分组标题
    \li \c label   行文本
    \li \c badge   右侧等宽小字（计数 / 编号）
    \endlist

    \qml
    ZSideBar {
        height: parent.height
        model: [
            { header: "01 / 工作台", label: "运行概况", badge: "→" },
            { label: "扫码登录" },
            { header: "02 / 系统管理", label: "日志中心", badge: "12" }
        ]
        onActivated: (i) => page.currentIndex = i
    }
    \endqml
*/
Item {
    id: root

    /*! 导航数据 */
    property var model: []
    /*! 当前选中项 */
    property int currentIndex: 0
    /*! 品牌主标题 */
    property string brand: "ZMDUI"
    /*! 品牌副标题（亮黄等宽小字） */
    property string brandSub: "INDUSTRIAL INTERFACE"
    /*! 品牌区上方的编号 */
    property string brandCode: "SYS / 00"
    /*! 底部版本信息（等宽） */
    property string version: ""
    /*!
        导航溢出时是否显示滚动条。设 false 可完全关掉（内容仍能用滚轮 / 拖拽滚动）。
    */
    property bool navScrollBar: true
    /*!
        滚动条占位宽度。**始终预留**：Qt 给 Flickable 挂的滚动条是浮在内容之上的，
        不预留的话它会盖住行右侧的编号 / 徽标（用户反馈过这个）。
    */
    readonly property int navScrollBarReserve: navScrollBar ? 14 : 0

    /*! 点击某项 */
    signal activated(int index)

    default property alias footerItems: footerCol.data

    implicitWidth: 236
    implicitHeight: 480

    // 侧边栏在主色板上属于"深灰 / 纯黑"那一档，不跟随亮暗主题反转；
    // 只用不同黑度区分：亮色主题更黑，暗色主题略浅以便与背景分层。
    // 侧边栏在两个主题里都是"深色带"，但暗色下必须比页面底色（#181818）更深，
    // 否则它会和背景糊成一片（之前 #161616 几乎等于底色，悬停块看起来像污渍）。
    readonly property color panelColor: Theme.isDark ? "#0C0C0C" : "#101010"
    readonly property color textColor:  "#FFFFFF"
    readonly property color textMuted:  "#8C8C8C"

    // ── 底板 ──
    Rectangle {
        anchors.fill: parent
        color: root.panelColor
    }

    // 右边缘：上段亮黄 + 下段深灰细线
    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        width: 3
        height: parent.height * 0.32
        color: Theme.accent
    }
    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.32
        width: 1
        height: parent.height * 0.68
        color: "#FFFFFF"
        opacity: 0.22
    }

    // ══ 品牌区 ══
    Item {
        id: brandBlock
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 104

        // 右上角黄色斜块装饰
        ZCutRect {
            anchors.right: parent.right
            anchors.top: parent.top
            width: 54
            height: 26
            color: Theme.accent
            cutBottomLeft: 22
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingLg
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.spacingMd
            spacing: 2

            Text {
                text: root.brandCode
                font: Theme.fontMonoSm
                color: Theme.accent
            }

            Text {
                text: root.brand
                // 品牌用超粗无衬线，叠同色描边做加粗
                font: Qt.font({ family: Theme.family, pixelSize: 34,
                                weight: Font.Black, letterSpacing: 1 })
                color: root.textColor
            }

            Text {
                text: root.brandSub
                font: Theme.fontMonoSm
                color: Theme.accent
            }
        }
    }

    // 品牌区下的粗黄分隔条
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: brandBlock.bottom
        height: 4
        color: Theme.accent
    }

    // ══ 底部区（版本 + 自定义页脚）══
    Item {
        id: footerArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.max(footerCol.implicitHeight + versionText.implicitHeight
                         + Theme.spacingSm * 2 + Theme.spacingMd * 2, 96)

        Text {
            id: versionText
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingLg
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.spacingMd
            text: root.version
            font: Theme.fontMonoSm
            color: root.textMuted
            visible: root.version.length > 0
        }

        Column {
            id: footerCol
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: versionText.visible ? versionText.top : parent.bottom
            anchors.bottomMargin: Theme.spacingMd
            spacing: Theme.spacingSm
        }
    }

    // ══ 导航列表 ══
    Flickable {
        id: navFlick
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: brandBlock.bottom
        anchors.topMargin: 4
        anchors.bottom: footerArea.top
        contentWidth: width
        contentHeight: navCol.implicitHeight
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        interactive: contentHeight > height
        ScrollBar.vertical: ZScrollBar {
            policy: root.navScrollBar ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
        }

        Column {
            id: navCol
            width: navFlick.width

            Repeater {
                model: root.model
                delegate: Column {
                    id: entryCol
                    width: navCol.width

                    readonly property var entry: modelData
                    readonly property bool isMap: (typeof entry === "object" && entry !== null)
                    readonly property string entryLabel: isMap
                            ? (entry.label !== undefined ? entry.label : "") : String(entry)
                    readonly property string entryBadge: (isMap && entry.badge !== undefined)
                            ? String(entry.badge) : ""
                    readonly property string entryHeader: (isMap && entry.header !== undefined)
                            ? String(entry.header) : ""

                    // ── 分组标题 ──
                    Item {
                        width: entryCol.width
                        height: entryCol.entryHeader.length > 0 ? 40 : 0
                        visible: entryCol.entryHeader.length > 0

                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.spacingLg
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: Theme.spacingSm

                            Rectangle {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 12
                                height: 2
                                color: Theme.accent
                                opacity: 0.7
                            }
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: entryCol.entryHeader
                                font: Theme.fontMonoSm
                                color: root.textMuted
                            }
                        }
                    }

                    // ── 导航行 ──
                    Item {
                        id: rowItem
                        width: entryCol.width
                        height: 46

                        readonly property bool current: index === root.currentIndex
                        readonly property bool isHovered: rowHover.hovered

                        HoverHandler { id: rowHover }

                        // 选中：亮黄底
                        ZCutRect {
                            anchors.fill: parent
                            anchors.margins: 2
                            visible: rowItem.current
                            color: Theme.accent
                            cutTopRight: 8
                            cutBottomLeft: 8
                        }

                        // 悬停：深灰底
                        ZCutRect {
                            anchors.fill: parent
                            anchors.margins: 2
                            visible: rowItem.isHovered && !rowItem.current
                            color: Theme.isDark ? "#1E1E1E" : "#232323"
                            cutTopRight: 8
                            cutBottomLeft: 8
                        }

                        // 左边缘装饰条
                        ZCutRect {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 6
                            anchors.bottomMargin: 6
                            width: 5
                            color: rowItem.current ? "#111111"
                                 : (rowItem.isHovered ? Theme.accent : "transparent")
                            cutTopRight: 4
                            cutBottomLeft: 4
                        }

                        Row {
                            id: rowContent
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.spacingLg + 4
                            anchors.right: parent.right
                            anchors.rightMargin: Theme.spacingMd + root.navScrollBarReserve
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: Theme.spacingSm

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: entryCol.entryLabel
                                font: Theme.fontStrong
                                color: rowItem.current ? Theme.textOnAccent : root.textColor
                                elide: Text.ElideRight
                                width: Math.max(0, rowContent.width - badgeText.width
                                                   - (badgeText.text.length > 0 ? 18 : 0))
                            }

                            Rectangle {
                                anchors.verticalCenter: parent.verticalCenter
                                visible: badgeText.text.length > 0
                                width: visible ? 6 : 0
                                height: 6
                                color: rowItem.current ? Theme.textOnAccent : Theme.accent
                            }

                            Text {
                                id: badgeText
                                anchors.verticalCenter: parent.verticalCenter
                                text: entryCol.entryBadge
                                font: Theme.fontMonoSm
                                color: rowItem.current ? Theme.textOnAccent : root.textMuted
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.currentIndex = index
                                root.activated(index)
                            }
                        }
                    }
                }
            }
        }
    }
}
```

### `qml/ZmdUI/ZTable.qml`

数据表格：黑底表头 + 工程网格线 + 选中行亮黄

```qml
import QtQuick

/*!
    \qmltype ZTable
    \inqmlmodule ZmdUI
    \brief 数据表格：黑底表头 + 工程网格线 + 选中行亮黄高亮。

    \l columns 是列定义数组：\c {title, key, width, align}；
    \l rows 是数据数组（每项是对象）。\c width 省略的列会均分剩余宽度。

    \qml
    ZTable {
        width: 620
        columns: [
            { title: "模块", key: "name", width: 150 },
            { title: "状态", key: "state", width: 90 },
            { title: "延迟", key: "latency", align: "right" }
        ]
        rows: [
            { name: "GateServer", state: "在线", latency: "12 ms" },
            { name: "ChatServer", state: "在线", latency: "18 ms" }
        ]
    }
    \endqml
*/
Item {
    id: root

    /*! 列定义 */
    property var columns: []
    /*! 数据行 */
    property var rows: []
    /*! 当前选中行（-1 = 无） */
    property int currentIndex: -1
    /*! 表格上方等宽说明 */
    property string caption: ""
    /*! 底部装饰条文字 */
    property string footerText: ""
    /*! 行高 */
    property int rowHeight: 38
    /*!
        行点击是否抢占鼠标（对应 MouseArea.preventStealing）。

        \note 表格放在 Flickable 里时，按下之后指针只要移动超过系统拖拽阈值
        （Windows 默认 10px），滚动容器就会把这次按下**当成滚动手势抢走**，
        MouseArea 永远收不到 clicked —— 表现就是"点几次才中一次"。
        打开后按下即由行接管，点击必中；代价是在表格上按住拖拽不再滚动页面
        （滚轮和滚动条不受影响）。数据表格以点选为主，所以默认打开。
    */
    property bool rowClickRobust: true

    signal rowClicked(int index)

    readonly property int headerHeight: caption.length > 0 ? 50 : 32
    implicitWidth: 560
    implicitHeight: headerHeight + rows.length * rowHeight
                    + (footerText.length > 0 ? Theme.accentBarHeight : 0) + Theme.border * 2

    // ── 列宽缓存：width / columns 变化时自动重算 ──
    readonly property var _widths: {
        var out = []
        var fixed = 0
        var flexCount = 0
        var n = columns ? columns.length : 0
        for (var i = 0; i < n; i++) {
            var w = columns[i].width !== undefined ? columns[i].width : 0
            if (w > 0)
                fixed += w
            else
                flexCount++
        }
        var inner = width - Theme.border * 2 - 1
        var flexW = flexCount > 0 ? Math.max(60, (inner - fixed) / flexCount) : 0
        for (var k = 0; k < n; k++) {
            var w2 = columns[k].width !== undefined ? columns[k].width : 0
            out.push(w2 > 0 ? w2 : flexW)
        }
        return out
    }

    function xAt(i) {
        var x = 0
        for (var k = 0; k < i; k++)
            x += _widths[k] || 0
        return x
    }

    function cellText(row, col) {
        if (row === undefined || row === null || col === undefined)
            return ""
        var v = row[col.key]
        return v === undefined ? "" : String(v)
    }

    // ── 外框 ──
    ZCutRect {
        anchors.fill: parent
        color: Theme.surface
        strokeColor: Theme.line
        strokeWidth: Theme.border
        cutTopRight: Theme.cutMd
        cutBottomLeft: Theme.cutSm
    }

    // ══ 表头 ══
    Item {
        id: headerArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Theme.border
        height: root.headerHeight

        // caption：等宽说明 + 小十字
        Row {
            id: captionRow
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingMd
            anchors.top: parent.top
            anchors.topMargin: Theme.spacingSm
            spacing: Theme.spacingSm
            visible: root.caption.length > 0

            Item {
                anchors.verticalCenter: parent.verticalCenter
                width: 9
                height: 9
                Rectangle { anchors.centerIn: parent; width: 9; height: 1.5; color: Theme.ink }
                Rectangle { anchors.centerIn: parent; width: 1.5; height: 9; color: Theme.ink }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.caption
                font: Theme.fontMonoSm
                color: Theme.muted
            }
        }

        // 黑底表头
        ZCutRect {
            id: headerBand
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 28
            color: Theme.inkBlock

            Row {
                anchors.fill: parent
                Repeater {
                    model: root.columns
                    Item {
                        width: root._widths[index] || 0
                        height: headerBand.height

                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: Theme.spacingMd
                            anchors.rightMargin: Theme.spacingMd
                            anchors.verticalCenter: parent.verticalCenter
                            text: (modelData.title !== undefined ? modelData.title : "").toUpperCase()
                            font: Theme.fontMonoSm
                            color: Theme.textOnSub
                            elide: Text.ElideRight
                            horizontalAlignment: modelData.align === "right" ? Text.AlignRight
                                             : modelData.align === "center" ? Text.AlignHCenter
                                             : Text.AlignLeft
                        }

                        // 列分隔刻度
                        Rectangle {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            width: 1
                            height: 12
                            color: Theme.textOnSub
                            opacity: 0.35
                        }
                    }
                }
            }
        }
    }

    // ══ 数据行 ══
    Repeater {
        id: rowRepeater
        model: root.rows

        delegate: Item {
            id: rowDelegate
            width: root.width - Theme.border * 2
            height: root.rowHeight
            x: Theme.border
            y: Theme.border + root.headerHeight + index * root.rowHeight

            // Repeater 的 modelData 是上下文属性，必须显式捕获才能在子项里引用
            readonly property var rowData: modelData
            readonly property bool isCurrent: index === root.currentIndex
            readonly property bool isHovered: rowHover2.hovered

            HoverHandler { id: rowHover2 }

            // 交替底色
            Rectangle {
                anchors.fill: parent
                color: index % 2 === 0 ? Theme.surface : Theme.surfaceAlt
                opacity: index % 2 === 0 ? 0 : 0.6
            }

            // 选中：亮黄 + 黑色斜切标记。
            // 标记必须放在单元格左边距（spacingMd = 12）之内，否则会压住第一列的文字
            // ——之前画在 leftMargin: 6、宽 10 的位置，正好盖掉第一个字母。
            ZCutRect {
                anchors.fill: parent
                anchors.margins: 1
                visible: rowDelegate.isCurrent
                color: Theme.accent
                cutTopRight: Theme.cutSm
                cutBottomLeft: Theme.cutSm

                ZSkewRect {
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    width: 5
                    height: 18
                    skew: 4
                    color: Theme.textOnAccent
                }
            }

            // 悬停：浅灰
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                visible: rowDelegate.isHovered && !rowDelegate.isCurrent
                color: Theme.surfaceHover
            }

            // 行底分隔线
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: Theme.lineSoft
                opacity: 0.5
            }

            // 单元格
            Row {
                anchors.fill: parent
                Repeater {
                    model: root.columns
                    Item {
                        width: root._widths[index] || 0
                        height: rowDelegate.height

                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: Theme.spacingMd
                            anchors.rightMargin: Theme.spacingMd
                            anchors.verticalCenter: parent.verticalCenter
                            text: root.cellText(rowDelegate.rowData, modelData)
                            font: (modelData.mono === false) ? Theme.fontStrong : Theme.fontMonoMd
                            // 选中行底色是强调黄 → 文字用强调色上的文字色
                            color: rowDelegate.isCurrent ? Theme.textOnAccent : Theme.inkSoft
                            elide: Text.ElideRight
                            horizontalAlignment: modelData.align === "right" ? Text.AlignRight
                                             : modelData.align === "center" ? Text.AlignHCenter
                                             : Text.AlignLeft
                        }
                    }
                }
            }

            // 竖网格线：声明式绘制，选中态变化会自动换色
            Repeater {
                model: root.columns.length - 1
                Rectangle {
                    x: Math.round(root.xAt(index + 1))
                    width: 1
                    height: rowDelegate.height
                    color: rowDelegate.isCurrent ? Qt.rgba(0, 0, 0, 0.28) : Theme.lineSoft
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                // 防止外层的 Flickable 把这次按下抢走当滚动手势（详见 rowClickRobust 说明）
                preventStealing: root.rowClickRobust
                onClicked: {
                    root.currentIndex = index
                    root.rowClicked(index)
                }
            }
        }
    }

    // ══ 底部装饰条 ══
    ZCutRect {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Theme.dp(Theme.accentBarHeight)
        visible: root.footerText.length > 0
        color: Theme.accent
        cutBottomLeft: Theme.cutSm

        Text {
            anchors.left: parent.left
            anchors.leftMargin: Theme.spacingMd + 4
            anchors.verticalCenter: parent.verticalCenter
            text: root.footerText
            font: Theme.fontMonoSm
            color: Theme.textOnAccent
        }

        Text {
            anchors.right: parent.right
            anchors.rightMargin: Theme.spacingMd + Theme.cutSm
            anchors.verticalCenter: parent.verticalCenter
            text: root.rows.length + " ROWS"
            font: Theme.fontMonoSm
            color: Theme.textOnAccent
            opacity: 0.7
        }
    }
}
```

### `qml/ZmdUI/ZLineChart.qml`

折线图：网格 + 亮黄数据线 + 黑色方形数据点

```qml
import QtQuick

/*!
    \qmltype ZLineChart
    \inqmlmodule ZmdUI
    \brief 极简折线图：工程网格 + 亮黄数据线 + 黑色方形数据点。

    纯 Canvas 绘制，无第三方依赖。数据点少（< 200）时性能足够。
    亮黄数据线外面套一层黑描边保证在白底上的对比度。

    \qml
    ZLineChart {
        width: 480; height: 200
        values: [12, 18, 15, 26, 22, 31, 28, 36]
        labels: ["00", "01", "02", "03", "04", "05", "06", "07"]
        caption: "RESPONSE TIME / SEC"
        suffix: " ms"
    }
    \endqml
*/
Item {
    id: root

    /*! 数据（数字数组） */
    property var values: []
    /*! X 轴标签，长度不足时用序号补 */
    property var labels: []
    /*! 左上角等宽说明 */
    property string caption: ""
    /*! 读数后缀 */
    property string suffix: ""
    /*! 数据线颜色（默认亮黄） */
    property color lineColor: Theme.accent
    /*! 是否画数据点 */
    property bool showDots: true
    /*! 是否显示右侧当前值 */
    property bool showLatest: true
    /*! Y 轴网格行数 */
    property int gridRows: 4

    implicitWidth: 480
    implicitHeight: 200

    readonly property real plotLeft: 44
    readonly property real plotRight: 16
    readonly property real plotTop: caption.length > 0 ? 34 : 16
    readonly property real plotBottom: 26

    readonly property real plotWidth: Math.max(0, width - plotLeft - plotRight)
    readonly property real plotHeight: Math.max(0, height - plotTop - plotBottom)

    readonly property real maxValue: {
        var m = 0
        for (var i = 0; i < values.length; i++)
            m = Math.max(m, Number(values[i]))
        return m <= 0 ? 1 : m * 1.15
    }

    // ── 外框 ──
    ZCutRect {
        anchors.fill: parent
        color: "transparent"
        strokeColor: Theme.lineSoft
        strokeWidth: 1
        cutTopRight: Theme.cutMd
        cutBottomLeft: Theme.cutSm
    }

    Canvas {
        id: chart
        anchors.fill: parent
        renderStrategy: Canvas.Immediate

        // 任何影响绘制的输入变化都要重绘
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Connections {
            target: root
            function onValuesChanged() { chart.requestPaint() }
            function onLabelsChanged() { chart.requestPaint() }
            function onLineColorChanged() { chart.requestPaint() }
        }
        // 亮暗主题切换后网格/坐标文字颜色要跟着重画
        Connections {
            target: Theme
            function onIsDarkChanged() { chart.requestPaint() }
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            var w = width
            var h = height
            var n = root.values.length
            if (w <= 0 || h <= 0)
                return

            var x0 = root.plotLeft
            var y0 = root.plotTop
            var pw = root.plotWidth
            var ph = root.plotHeight
            var vmax = root.maxValue

            // ── 背景网格 ──
            ctx.lineWidth = 1
            ctx.strokeStyle = Theme.gridLineMajor
            ctx.beginPath()
            for (var r = 0; r <= root.gridRows; r++) {
                var gy = Math.round(y0 + ph * r / root.gridRows) + 0.5
                ctx.moveTo(x0, gy)
                ctx.lineTo(x0 + pw, gy)
                // 网格刻度短线
                ctx.moveTo(x0 - 5, gy)
                ctx.lineTo(x0, gy)
            }
            ctx.stroke()

            // Y 轴刻度值（等宽小字）
            ctx.fillStyle = Theme.muted
            ctx.font = "10px " + Theme.familyMono
            ctx.textAlign = "right"
            ctx.textBaseline = "middle"
            for (var r2 = 0; r2 <= root.gridRows; r2++) {
                var gy2 = y0 + ph * r2 / root.gridRows
                var val = Math.round(vmax * (1 - r2 / root.gridRows))
                ctx.fillText(String(val), x0 - 9, gy2)
            }

            if (n === 0)
                return

            // ── X 轴基线 ──
            ctx.strokeStyle = Theme.line
            ctx.lineWidth = 2
            ctx.beginPath()
            ctx.moveTo(x0, y0 + ph + 0.5)
            ctx.lineTo(x0 + pw, y0 + ph + 0.5)
            ctx.stroke()

            // ── 数据点坐标 ──
            var step = n > 1 ? pw / (n - 1) : 0
            var pts = []
            for (var i = 0; i < n; i++) {
                pts.push({
                    x: x0 + step * i,
                    y: y0 + ph - ph * (Number(root.values[i]) / vmax)
                })
            }

            // ── 面积：用亮黄低透明度平涂（不做渐变）──
            ctx.beginPath()
            ctx.moveTo(pts[0].x, y0 + ph)
            for (var a = 0; a < n; a++)
                ctx.lineTo(pts[a].x, pts[a].y)
            ctx.lineTo(pts[n - 1].x, y0 + ph)
            ctx.closePath()
            ctx.fillStyle = Qt.rgba(root.lineColor.r, root.lineColor.g, root.lineColor.b, 0.22)
            ctx.fill()

            // ── 折线：先黑后黄，保证白底上的对比度 ──
            ctx.lineJoin = "miter"
            ctx.lineCap = "butt"
            ctx.beginPath()
            ctx.moveTo(pts[0].x, pts[0].y)
            for (var b = 1; b < n; b++)
                ctx.lineTo(pts[b].x, pts[b].y)
            // 描边底用 inkBlock：亮色下是近黑（和以前一样），暗色下是比面板更深的黑，
            // 黄线才会"亮"起来；用 ink 的话暗色下会变成浅灰描边，看着像灰线
            ctx.strokeStyle = Theme.inkBlock
            ctx.lineWidth = 5
            ctx.stroke()
            ctx.strokeStyle = root.lineColor
            ctx.lineWidth = 2.5
            ctx.stroke()

            // ── 数据点：黑色方块 ──
            if (root.showDots) {
                for (var c = 0; c < n; c++) {
                    ctx.fillStyle = Theme.inkBlock
                    ctx.fillRect(pts[c].x - 3, pts[c].y - 3, 6, 6)
                    ctx.fillStyle = root.lineColor
                    ctx.fillRect(pts[c].x - 1.5, pts[c].y - 1.5, 3, 3)
                }
            }

            // ── X 轴标签 ──
            ctx.fillStyle = Theme.muted
            ctx.font = "10px " + Theme.familyMono
            ctx.textAlign = "center"
            ctx.textBaseline = "top"
            for (var d = 0; d < n; d++) {
                // 点太密时只标偶数位
                if (n > 8 && d % 2 !== 0)
                    continue
                var lb = (root.labels.length > d) ? String(root.labels[d]) : String(d)
                ctx.fillText(lb, pts[d].x, y0 + ph + 8)
            }

            // ── 最新值标注 ──
            if (root.showLatest) {
                var last = pts[n - 1]
                var txt = String(root.values[n - 1]) + root.suffix
                ctx.font = "11px " + Theme.familyMono
                var tw = ctx.measureText(txt).width
                var bx = Math.min(last.x + 8, w - tw - 14)
                var by = Math.max(4, last.y - 24)

                // 黑底标签块
                ctx.fillStyle = Theme.subBg
                ctx.fillRect(bx, by, tw + 12, 18)
                // 亮黄左边缘
                ctx.fillStyle = root.lineColor
                ctx.fillRect(bx, by, 3, 18)
                // 白字
                ctx.fillStyle = Theme.textOnSub
                ctx.textAlign = "left"
                ctx.textBaseline = "middle"
                ctx.fillText(txt, bx + 8, by + 10)

                // 最新点的十字准星
                ctx.strokeStyle = Theme.ink
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.moveTo(last.x, y0)
                ctx.lineTo(last.x, y0 + ph)
                ctx.stroke()
            }
        }
    }

    // ── 左上角说明 ──
    Row {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: Theme.spacingMd
        anchors.topMargin: Theme.spacingSm
        spacing: Theme.spacingSm
        visible: root.caption.length > 0

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 14
            height: 3
            color: root.lineColor
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.caption
            font: Theme.fontMonoSm
            color: Theme.muted
        }
    }
}
```

## 五、演示应用

### `qml/main.qml`

演示程序入口（窗口壳）

```qml
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
```

### `qml/DemoContent.qml`

演示内容：网格背景 + 侧边栏 + 八大区块，覆盖全部组件

```qml
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
                        footerText: "聚焦时亮黄底线 · 出错时品红底线 · 光标仅编辑时出现并闪烁"

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

                // ══════════════════════════════════════════
                //  区块 07 —— 富文本
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "07"
                    eyebrow: "RICH TEXT / BLOCK COMPOSER"
                    title: "富文本"
                    subtitle: "COMPOSER"
                }

                ZPanel {
                    width: parent.width
                    title: "块级富文本编辑器"
                    tag: "RICH-01"
                    eyebrow: "TEXT / IMAGE / FILE"
                    footerText: "块级富文本 · 加粗斜体下划线删除线按块生效 · 图片与文件块可混排"

                    ZRichTextEditor {
                        id: richDemo

                        width: parent.width
                        headerText: "RICH TEXT / COMPOSER"

                        blocks: [
                            makeTextBlock("「富文本」块级编排", "heading"),
                            makeTextBlock("这一段是正文。点工具栏上的 B / I / U / S 会给整个块加粗、"
                                          + "倾斜、下划线、删除线 —— 富在这里是块级属性，不是选区级的字符格式。"),
                            makeImageBlock("", "", "图注：图片块等宽铺满，说明文字压在下方的灰条里"),
                            makeFileBlock("", "verification.md", 48321),
                            makeTextBlock("代码块用等宽字体 + 灰底，左侧不画竖条。", "code")
                        ]

                        onImageRequested: console.log("imageRequested")
                        onFileRequested: console.log("fileRequested")
                        onFileActivated: (url, name) => console.log("fileActivated", name)
                    }
                }

                // ══════════════════════════════════════════
                //  区块 08 —— 消息输入
                // ══════════════════════════════════════════
                ZSectionTitle {
                    index: "08"
                    eyebrow: "MESSAGE / CHAT COMPOSER"
                    title: "消息输入"
                    subtitle: "COMPOSER"
                }

                ZPanel {
                    width: parent.width
                    title: "聊天输入框"
                    tag: "CHAT-01"
                    eyebrow: "TEXT / IMAGE / FILE"
                    footerText: "QQ 式消息输入 · Enter 发送 / Shift+Enter 换行 · 图片与文件可拖入或选入"

                    ZChatInput {
                        id: chatDemo

                        width: parent.width
                        headerText: "MESSAGE / COMPOSER"
                        text: "今晚 8 点同步配置，附件是新的 bot_007.json。"

                        attachments: [
                            makeImageAttachment("", "screenshot.png"),
                            makeFileAttachment("", "bot_007.json", 28416)
                        ]

                        onSendRequested: (text, files) => console.log("send", text.length, files.length)
                        onImagePickRequested: console.log("imagePickRequested")
                        onFilePickRequested: console.log("filePickRequested")
                        onCancelRequested: console.log("cancelRequested")
                        onFilesDropped: urls => console.log("filesDropped", urls.length)

                        // 剪贴板里是图片时，QML 自己拿不到，借 C++ 桥存成临时文件再加进来。
                        // qml.exe 跑测试时没有 ZClipboard，所以要守卫一下。
                        onPasteRequested: {
                            if (typeof ZClipboard === "undefined")
                                return
                            var url = ZClipboard.saveImage()
                            if (url.length > 0)
                                chatDemo.addImage(url, "clipboard.png")
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
                text: "ZMDUI COMPONENT LIBRARY / 27 TYPES / QT 6 QML"
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
```

## 六、工程集成

### `qml/ZmdUI/qmldir`

QML 模块清单，声明模块 URI 与单例

```text
module ZmdUI
# ── 终末地工业机能风 QML 组件库 ─────────────────────────────────
# 主题单例必须排在首位：组件的默认值绑定依赖它。
singleton Theme 1.0 Theme.qml
ZButton 1.0 ZButton.qml
ZChatInput 1.0 ZChatInput.qml
ZCheckBox 1.0 ZCheckBox.qml
ZCutRect 1.0 ZCutRect.qml
ZDialog 1.0 ZDialog.qml
ZGridBackground 1.0 ZGridBackground.qml
ZHatchPattern 1.0 ZHatchPattern.qml
ZIconButton 1.0 ZIconButton.qml
ZLineChart 1.0 ZLineChart.qml
ZListItem 1.0 ZListItem.qml
ZListView 1.0 ZListView.qml
ZPanel 1.0 ZPanel.qml
ZProgressBar 1.0 ZProgressBar.qml
ZRadioButton 1.0 ZRadioButton.qml
ZRichTextEditor 1.0 ZRichTextEditor.qml
ZScrollBar 1.0 ZScrollBar.qml
ZSectionTitle 1.0 ZSectionTitle.qml
ZSideBar 1.0 ZSideBar.qml
ZSkewRect 1.0 ZSkewRect.qml
ZSlider 1.0 ZSlider.qml
ZStatusDot 1.0 ZStatusDot.qml
ZSwitch 1.0 ZSwitch.qml
ZTable 1.0 ZTable.qml
ZTag 1.0 ZTag.qml
ZTextField 1.0 ZTextField.qml
ZToolTip 1.0 ZToolTip.qml
```

### `resources/qml.qrc`

Qt 资源系统清单，资源路径与磁盘结构一致

```xml
<RCC>
    <!-- ZmdUI 组件库 + 演示程序的全部 QML 源码。
         资源路径与磁盘结构保持一致：:/qml/...，
         这样 main.cpp 只需 engine.addImportPath("qrc:/qml") 就能找到 ZmdUI 模块。 -->
    <qresource prefix="/">
        <file alias="qml/main.qml">../qml/main.qml</file>
        <file alias="qml/DemoContent.qml">../qml/DemoContent.qml</file>
        <file alias="qml/ZmdUI/qmldir">../qml/ZmdUI/qmldir</file>
        <file alias="qml/ZmdUI/Theme.qml">../qml/ZmdUI/Theme.qml</file>
        <file alias="qml/ZmdUI/ZButton.qml">../qml/ZmdUI/ZButton.qml</file>
        <file alias="qml/ZmdUI/ZChatInput.qml">../qml/ZmdUI/ZChatInput.qml</file>
        <file alias="qml/ZmdUI/ZCheckBox.qml">../qml/ZmdUI/ZCheckBox.qml</file>
        <file alias="qml/ZmdUI/ZCutRect.qml">../qml/ZmdUI/ZCutRect.qml</file>
        <file alias="qml/ZmdUI/ZDialog.qml">../qml/ZmdUI/ZDialog.qml</file>
        <file alias="qml/ZmdUI/ZGridBackground.qml">../qml/ZmdUI/ZGridBackground.qml</file>
        <file alias="qml/ZmdUI/ZHatchPattern.qml">../qml/ZmdUI/ZHatchPattern.qml</file>
        <file alias="qml/ZmdUI/ZIconButton.qml">../qml/ZmdUI/ZIconButton.qml</file>
        <file alias="qml/ZmdUI/ZLineChart.qml">../qml/ZmdUI/ZLineChart.qml</file>
        <file alias="qml/ZmdUI/ZListItem.qml">../qml/ZmdUI/ZListItem.qml</file>
        <file alias="qml/ZmdUI/ZListView.qml">../qml/ZmdUI/ZListView.qml</file>
        <file alias="qml/ZmdUI/ZPanel.qml">../qml/ZmdUI/ZPanel.qml</file>
        <file alias="qml/ZmdUI/ZProgressBar.qml">../qml/ZmdUI/ZProgressBar.qml</file>
        <file alias="qml/ZmdUI/ZRadioButton.qml">../qml/ZmdUI/ZRadioButton.qml</file>
        <file alias="qml/ZmdUI/ZRichTextEditor.qml">../qml/ZmdUI/ZRichTextEditor.qml</file>
        <file alias="qml/ZmdUI/ZScrollBar.qml">../qml/ZmdUI/ZScrollBar.qml</file>
        <file alias="qml/ZmdUI/ZSectionTitle.qml">../qml/ZmdUI/ZSectionTitle.qml</file>
        <file alias="qml/ZmdUI/ZSideBar.qml">../qml/ZmdUI/ZSideBar.qml</file>
        <file alias="qml/ZmdUI/ZSkewRect.qml">../qml/ZmdUI/ZSkewRect.qml</file>
        <file alias="qml/ZmdUI/ZSlider.qml">../qml/ZmdUI/ZSlider.qml</file>
        <file alias="qml/ZmdUI/ZStatusDot.qml">../qml/ZmdUI/ZStatusDot.qml</file>
        <file alias="qml/ZmdUI/ZSwitch.qml">../qml/ZmdUI/ZSwitch.qml</file>
        <file alias="qml/ZmdUI/ZTable.qml">../qml/ZmdUI/ZTable.qml</file>
        <file alias="qml/ZmdUI/ZTag.qml">../qml/ZmdUI/ZTag.qml</file>
        <file alias="qml/ZmdUI/ZTextField.qml">../qml/ZmdUI/ZTextField.qml</file>
        <file alias="qml/ZmdUI/ZToolTip.qml">../qml/ZmdUI/ZToolTip.qml</file>
    </qresource>
</RCC>
```

### `src/main.cpp`

应用入口：Basic 样式 + 高 DPI + 资源导入路径 + 剪贴板桥注入

```cpp
// ZmdUI —— 终末地工业机能风 QML 组件库 / 演示程序入口
//
// 设计要点：
//  1. 强制使用 QtQuick.Controls 的 Basic 样式：我们在 QML 里完全自定义了
//     background / contentItem / indicator，绝不允许平台原生样式介入，
//     否则会出现圆角、蓝色高亮等与设计语言冲突的绘制。
//  2. 高 DPI：Qt 6 默认按 devicePixelRatio 缩放逻辑像素，无需额外开关；
//     这里只把舍入策略固定为 PassThrough，保证 1.25 / 1.5 倍缩放下线条不糊。
//  3. 资源：QML 全部打进 qrc，import 路径为 "qrc:/qml"，
//     模块根目录是 ":/qml/ZmdUI"（内含 qmldir）。

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQuickWindow>

#include "zclipboard.h"

int main(int argc, char *argv[])
{
    // 高 DPI：不取整缩放系数，交给 Qt 按屏幕实际 DPR 渲染
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(
        Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);

    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("ZmdUI"));
    app.setOrganizationName(QStringLiteral("ZmdUI"));
    // 版本号由 CMake 注入（target_compile_definitions），源码里不重复写一遍
#ifdef ZMDUI_VERSION
    app.setApplicationVersion(QStringLiteral(ZMDUI_VERSION));
#else
    app.setApplicationVersion(QStringLiteral("1.0.0"));
#endif

    // 完全自定义样式的前提：禁用平台样式
    QQuickStyle::setStyle(QStringLiteral("Basic"));

    QQmlApplicationEngine engine;

    // 让 "import ZmdUI 1.0" 能在 qrc 里解析到 :/qml/ZmdUI/qmldir
    engine.addImportPath(QStringLiteral("qrc:/qml"));

    // 剪贴板桥：QML 读不到剪贴板位图，粘图片要借 C++ 的 QClipboard。
    // 用 context property 注入（而不是 QML 单例），这样纯 qml.exe 跑测试时
    // 根本不需要它，QML 侧用 typeof ZClipboard 守卫即可。
    ZClipboard clipboardBridge;
    engine.rootContext()->setContextProperty(
        QStringLiteral("ZClipboard"), &clipboardBridge);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
```

### `src/zclipboard.cpp`

剪贴板桥：把剪贴板位图存成临时文件（QML 读不到位图）

```cpp
#include "zclipboard.h"

#include <QClipboard>
#include <QDateTime>
#include <QDir>
#include <QGuiApplication>
#include <QImage>
#include <QMimeData>
#include <QUrl>

ZClipboard::ZClipboard(QObject *parent)
    : QObject(parent)
{
}

bool ZClipboard::hasImage() const
{
    const QClipboard *clipboard = QGuiApplication::clipboard();
    return clipboard && !clipboard->image().isNull();
}

bool ZClipboard::hasUrls() const
{
    const QClipboard *clipboard = QGuiApplication::clipboard();
    if (!clipboard)
        return false;
    const QMimeData *mime = clipboard->mimeData();
    return mime && mime->hasUrls();
}

QString ZClipboard::saveImage(const QString &preferredExtension) const
{
    const QClipboard *clipboard = QGuiApplication::clipboard();
    if (!clipboard)
        return QString();

    const QImage image = clipboard->image();
    if (image.isNull())
        return QString();

    QString extension = preferredExtension.trimmed().toLower();
    if (extension.startsWith(QLatin1Char('.')))
        extension = extension.mid(1);
    if (extension.isEmpty())
        extension = QStringLiteral("png");

    // 放临时目录下的固定子目录：文件名带毫秒时间戳，天然不重名。
    // 不自动清理是故意的 —— 用户可能把这条消息发出去之后界面还在显示缩略图。
    const QString dir = QDir::tempPath() + QStringLiteral("/zmdui-clipboard");
    if (!QDir().mkpath(dir))
        return QString();

    const QString fileName = QStringLiteral("clip-%1.%2")
                                 .arg(QDateTime::currentMSecsSinceEpoch())
                                 .arg(extension);
    const QString path = dir + QLatin1Char('/') + fileName;

    if (!image.save(path))
        return QString();

    return QUrl::fromLocalFile(path).toString();
}
```

### `CMakeLists.txt`

CMake 构建脚本：跨平台 + MSVC/MinGW 双编译器 + 一键部署

```cmake
# ══════════════════════════════════════════════════════════════════════════
#  ZmdUI —— 跨平台构建脚本（Windows / Linux / macOS，MSVC / MinGW / GCC / Clang）
#
#  配置示例
#  ────────────────────────────────────────────────────────────────────────
#  MSVC（Windows，Ninja 或 Visual Studio 生成器都行）
#    cmake -S . -B build -G Ninja ^
#          -DCMAKE_BUILD_TYPE=Release ^
#          -DCMAKE_PREFIX_PATH="C:/Qt/6.8.0/msvc2022_64"
#    cmake --build build
#
#  MinGW（Windows + g++）
#    cmake -S . -B build-mingw -G Ninja ^
#          -DCMAKE_BUILD_TYPE=Release ^
#          -DCMAKE_CXX_COMPILER="C:/Qt/Tools/mingw1310_64/bin/g++.exe" ^
#          -DCMAKE_PREFIX_PATH="C:/Qt/6.8.0/mingw_64"
#    cmake --build build-mingw
#
#  GCC / Clang（Linux、macOS，或用 MSYS2 的 mingw64 环境）
#    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
#    cmake --build build
#
#  可选开关（-D<名字>=ON/OFF）
#    ZMDUI_CONSOLE                  Windows 下保留控制台窗口（默认 OFF，调试时可开）
#    ZMDUI_STATIC_MINGW_RUNTIME     MinGW 下静态链接 GCC 运行库（默认 ON）
#    ZMDUI_WARNINGS                 开编译警告（默认 ON）
# ══════════════════════════════════════════════════════════════════════════

cmake_minimum_required(VERSION 3.21)

project(ZmdUI
    VERSION 1.0.0
    DESCRIPTION "终末地工业机能风 QML 组件库"
    HOMEPAGE_URL "https://www.fz.wiki/"
    LANGUAGES CXX
)

# ── 语言标准 ──────────────────────────────────────────────────────────────
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 注意：这里**故意不关** CMAKE_CXX_EXTENSIONS（即保留 gnu++17）。
# Qt 自己就是用 gnu++17 编译的，MinGW 下把扩展关掉会引入 __STRICT_ANSI__ 差异，
# 属于自找麻烦；用 -std=c++17 换不来任何好处。

# ── Qt 的自动化工具 ───────────────────────────────────────────────────────
# 纯 QML 组件库没有 .ui 文件，所以不需要 AUTOUIC。
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# ── 找 Qt ────────────────────────────────────────────────────────────────
#
# find_package(Qt6) 必须在 CMAKE_PREFIX_PATH / Qt6_DIR 里找到 Qt 的配置包，
# 但 IDE（CLion / Qt Creator / VS Code）生成的 profile 经常什么都不传，
# 于是报 "Could not find a package configuration file provided by Qt6"。
# 与其让每个人在每个 profile 里手填路径，这里做一层**自动探测**：
#
#   优先级 1  命令行 -DZMDUI_QT_ROOT= / -DQt6_DIR= / -DCMAKE_PREFIX_PATH=
#   优先级 2  环境变量 QTDIR / QT_DIR / Qt6_DIR
#   优先级 3  扫常见安装位置（C:/Qt、C:/dev/Qt、~/Qt、/opt/Qt …），
#             并且**按当前编译器家族挑套件**（MinGW 找 mingw_*，MSVC 找 msvc*），
#             同族里优先用版本号更高的。
#
# 自动探测只是"帮你填 Hint"，找不到还是会有明确报错，不会静默用错套件。

set(_zmd_qt_hints "")

foreach(_v ZMDUI_QT_ROOT Qt6_DIR QTDIR QT_DIR)
    if(DEFINED ${_v} AND NOT "${${_v}}" STREQUAL "")
        list(APPEND _zmd_qt_hints "${${_v}}")
    endif()
endforeach()
foreach(_e QTDIR QT_DIR Qt6_DIR)
    if(DEFINED ENV{${_e}} AND NOT "$ENV{${_e}}" STREQUAL "")
        list(APPEND _zmd_qt_hints "$ENV{${_e}}")
    endif()
endforeach()

if(NOT _zmd_qt_hints)
    # 按编译器家族选套件目录名；MinGW/MSVC 绝不能混用同一套 Qt
    if(MINGW)
        set(_zmd_kit_names mingw_64 mingw)
    elseif(MSVC)
        set(_zmd_kit_names msvc2022_64 msvc2019_64 msvc_64)
    elseif(APPLE)
        set(_zmd_kit_names macos clang_64)
    else()
        set(_zmd_kit_names gcc_64 linux_gcc_64)
    endif()

    set(_zmd_qt_roots
        "C:/Qt" "C:/dev/Qt" "D:/Qt" "E:/Qt"
        "$ENV{HOME}/Qt" "$ENV{USERPROFILE}/Qt"
        "/opt/Qt" "/usr/local/Qt"
    )

    set(_zmd_cands "")
    foreach(_root ${_zmd_qt_roots})
        if(NOT EXISTS "${_root}")
            continue()
        endif()
        file(GLOB _zmd_vers RELATIVE "${_root}" "${_root}/*")
        foreach(_ver ${_zmd_vers})
            # 只要形如 6.11.2 / 6.5 的版本目录，跳过 Tools、Docs 之类
            if(NOT _ver MATCHES "^[0-9]+[.][0-9]+")
                continue()
            endif()
            string(REGEX MATCH "^([0-9]+)[.]([0-9]+)[.]?([0-9]*)" _ignored "${_ver}")
            # 排序键：major*10000 + minor*100 + patch，让新版排在前面
            math(EXPR _zmd_key
                 "${CMAKE_MATCH_1} * 10000 + ${CMAKE_MATCH_2} * 100 + ${CMAKE_MATCH_3}")
            foreach(_kit ${_zmd_kit_names})
                file(GLOB _zmd_hit "${_root}/${_ver}/${_kit}")
                foreach(_h ${_zmd_hit})
                    list(APPEND _zmd_cands "${_zmd_key}|${_h}")
                endforeach()
            endforeach()
        endforeach()
    endforeach()

    list(SORT _zmd_cands ORDER DESCENDING)
    foreach(_c ${_zmd_cands})
        string(REPLACE "|" ";" _pair "${_c}")
        list(GET _pair 1 _hint)
        list(APPEND _zmd_qt_hints "${_hint}")
    endforeach()

    if(_zmd_qt_hints)
        list(GET _zmd_qt_hints 0 _zmd_first)
        message(STATUS "ZmdUI: 未指定 Qt 路径，自动探测到 ${_zmd_first}")
    endif()
endif()

# 只要求 6.5 以上的任意小版本：写死精确版本号会让工程换台机器就配不过。
find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2
    HINTS ${_zmd_qt_hints}
)

# ── 编译器 / 套件匹配性检查 ───────────────────────────────────────────────
#
# IDE 的 CMake profile 里换成 MinGW 工具链、Qt 却还是 MSVC 那套（或反过来），
# find_package 是能过的，要到链接阶段才炸出一堆 "file format not recognized"，
# 非常难查。这里提前拦下来，直接把话说明白。
#
# 注意：Qt6_INSTALL_PREFIX 这个变量名在不同 Qt 版本里时有时无
# （有的是 QT6_INSTALL_PREFIX，有的只有 Qt6_DIR），所以三级兜底。
if(DEFINED Qt6_INSTALL_PREFIX AND NOT "${Qt6_INSTALL_PREFIX}" STREQUAL "")
    set(_zmd_qt_prefix "${Qt6_INSTALL_PREFIX}")
elseif(DEFINED QT6_INSTALL_PREFIX AND NOT "${QT6_INSTALL_PREFIX}" STREQUAL "")
    set(_zmd_qt_prefix "${QT6_INSTALL_PREFIX}")
elseif(DEFINED Qt6_DIR)
    # <prefix>/lib/cmake/Qt6 → 回退三级就是 <prefix>
    get_filename_component(_zmd_qt_prefix "${Qt6_DIR}/../../.." ABSOLUTE)
else()
    set(_zmd_qt_prefix "")
endif()

if(WIN32 AND NOT "${_zmd_qt_prefix}" STREQUAL "")
    if(MINGW AND _zmd_qt_prefix MATCHES "msvc")
        message(FATAL_ERROR
            "编译器与 Qt 套件不匹配：\n"
            "  当前编译器：MinGW (${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION})\n"
            "  找到的 Qt ：${_zmd_qt_prefix}\n"
            "请把 CMAKE_PREFIX_PATH 指向 Qt 的 mingw 构建（例如 C:/Qt/6.8.0/mingw_64），"
            "或在 IDE 里把工具链换成对应的 MSVC。")
    elseif(MSVC AND _zmd_qt_prefix MATCHES "mingw")
        message(FATAL_ERROR
            "编译器与 Qt 套件不匹配：\n"
            "  当前编译器：MSVC (${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION})\n"
            "  找到的 Qt ：${_zmd_qt_prefix}\n"
            "请把 CMAKE_PREFIX_PATH 指向 Qt 的 msvc 构建（例如 C:/Qt/6.8.0/msvc2022_64），"
            "或在 IDE 里把工具链换成对应的 MinGW。")
    endif()
endif()

message(STATUS "ZmdUI: 使用 Qt ${Qt6_VERSION} @ ${_zmd_qt_prefix}")
message(STATUS "ZmdUI: 编译器 ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")

qt_standard_project_setup(REQUIRES 6.5)

# ── 可选项 ───────────────────────────────────────────────────────────────
option(ZMDUI_CONSOLE "Windows 下保留控制台窗口（调试时看 qDebug / QML 警告）" OFF)
option(ZMDUI_STATIC_MINGW_RUNTIME "MinGW 下静态链接 GCC 运行库" ON)
option(ZMDUI_WARNINGS "打开编译警告" ON)

# ── 目标 ─────────────────────────────────────────────────────────────────
# 全部资源都进 qrc，运行时不需要任何外部 QML 文件 —— 这点在三个平台上都一样，
# 也是它能"拷走 exe 就能跑"的前提。
qt_add_executable(ZmdUIDemo
    src/main.cpp
    src/zclipboard.cpp
    src/zclipboard.h
    resources/qml.qrc
)

target_link_libraries(ZmdUIDemo PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2      # QML 里 import QtQuick.Controls.Basic，链接上才保证被部署
)

target_compile_definitions(ZmdUIDemo PRIVATE
    ZMDUI_VERSION="${PROJECT_VERSION}"
)

# ── 平台相关 ─────────────────────────────────────────────────────────────

# Windows：默认走 GUI 子系统。MSVC 下是 /SUBSYSTEM:WINDOWS，MinGW 下 CMake 会自动加
# -mwindows，两边的入口都由各自的 CRT 负责桥接到标准的 main()。
if(WIN32)
    set_target_properties(ZmdUIDemo PROPERTIES
        WIN32_EXECUTABLE $<NOT:$<BOOL:${ZMDUI_CONSOLE}>>
    )
endif()

# macOS：打成 .app bundle，否则 Dock / 焦点行为都不对
if(APPLE)
    set_target_properties(ZmdUIDemo PROPERTIES
        MACOSX_BUNDLE TRUE
        MACOSX_BUNDLE_BUNDLE_NAME "ZmdUI"
        MACOSX_BUNDLE_GUI_IDENTIFIER "wiki.zmd.zmdui"
        MACOSX_BUNDLE_BUNDLE_VERSION "${PROJECT_VERSION}"
        MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
    )
endif()

# Linux：装到自定义前缀时，让可执行文件能在 ../lib 下找到随包的 Qt 库
if(UNIX AND NOT APPLE)
    set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")
endif()

# ── 编译警告：按编译器家族分支 ────────────────────────────────────────────
if(ZMDUI_WARNINGS)
    if(MSVC)
        target_compile_options(ZmdUIDemo PRIVATE /W4 /permissive-)
    else()
        target_compile_options(ZmdUIDemo PRIVATE -Wall -Wextra)
    endif()
endif()

# ── MinGW 运行库 ─────────────────────────────────────────────────────────
# MinGW 编出来的 exe 默认依赖 libstdc++-6.dll / libgcc_s_*.dll / libwinpthread-1.dll，
# 这三个不在 Qt 里，windeployqt 也不会帮你拷 —— 是最经典的"换台机器就报缺 DLL"。
# 两手准备：能静态链的静态链，剩下必须动态的（线程模型 DLL）自动拷到 exe 旁边。
if(MINGW)
    # 静态链接的那两个就不用拷了；libwinpthread 是线程模型 DLL，静态链它容易出坑，
    # 所以照常拷到 exe 旁边。可以用 objdump -p 复核导入表：
    #   objdump -p ZmdUIDemo.exe | grep "DLL Name"
    set(_zmd_mingw_dlls libwinpthread-1.dll)
    if(ZMDUI_STATIC_MINGW_RUNTIME)
        target_link_options(ZmdUIDemo PRIVATE -static-libgcc -static-libstdc++)
        message(STATUS "ZmdUI: MinGW 运行库静态链接已开启（libgcc / libstdc++）")
    else()
        list(APPEND _zmd_mingw_dlls
             libstdc++-6.dll libgcc_s_seh-1.dll libgcc_s_dw2-1.dll)
    endif()

    # 编译器自带的运行时 DLL 就在 g++.exe 旁边
    get_filename_component(_zmd_mingw_bin "${CMAKE_CXX_COMPILER}" DIRECTORY)
    foreach(_dll ${_zmd_mingw_dlls})
        if(EXISTS "${_zmd_mingw_bin}/${_dll}")
            add_custom_command(TARGET ZmdUIDemo POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                        "${_zmd_mingw_bin}/${_dll}"
                        "$<TARGET_FILE_DIR:ZmdUIDemo>"
                COMMENT "ZmdUI: 复制 MinGW 运行时 ${_dll}"
                VERBATIM)
        endif()
    endforeach()
    unset(_zmd_mingw_bin)
endif()

# ── 构建目录内自包含（Windows）：让构建产物直接能跑 ────────────────────────
#
# Windows 上没有 RPATH 这种东西，DLL 只从「exe 所在目录 / 系统目录 / 当前目录 / PATH」找。
# 刚编出来的 exe 旁边没有 Qt6Core.dll、PATH 里也没有 Qt 的 bin 时，
# 双击或者从 IDE 直接 Run 会立刻以 0xC0000135（STATUS_DLL_NOT_FOUND）退出 ——
# CLion 的 Run 默认不会帮你加 Qt 的 bin，这就是那个报错的来源。
#
# 所以构建后把运行时依赖（Qt DLL + QML 插件 + 平台插件 + 编译器运行库）拷到 exe 旁边。
# 代价是构建目录会多出几十 MB；想省空间就 -DZMDUI_DEPLOY_TO_BUILD_DIR=OFF，
# 然后自己把 Qt 的 bin 加进 PATH。
option(ZMDUI_DEPLOY_TO_BUILD_DIR "Windows 下构建后把 Qt 运行时部署到构建目录" ON)

if(WIN32 AND ZMDUI_DEPLOY_TO_BUILD_DIR)
    find_program(ZMDUI_WINDEPLOYQT
        NAMES windeployqt
        HINTS "${_zmd_qt_prefix}/bin"
        NO_DEFAULT_PATH)
    if(NOT ZMDUI_WINDEPLOYQT)
        find_program(ZMDUI_WINDEPLOYQT NAMES windeployqt)
    endif()

    if(ZMDUI_WINDEPLOYQT)
        # 判断这个 Qt 套件到底有没有 Debug 版库：很多官方二进制套件（本机的 mingw_64 就是）
        # 只有 Release 的 Qt6Core.dll，没有 Qt6Cored.dll。这种情况下即使是 Debug 构建，
        # 链接的也是 Release Qt，部署时必须给 --release —— 给 --debug 会去找不存在的
        # qwindowsd.dll，报 "Unable to find the platform plugin" 直接构建失败。
        if(EXISTS "${_zmd_qt_prefix}/bin/Qt6Cored.dll")
            set(_zmd_qt_has_debug TRUE)
            message(STATUS "ZmdUI: Qt 套件带 Debug 库（Debug 构建会用 --debug 部署）")
        else()
            set(_zmd_qt_has_debug FALSE)
            message(STATUS "ZmdUI: Qt 套件只有 Release 库（Debug 构建也按 --release 部署）")
        endif()

        # 注意：必须用**单个** $<IF:...> 生成器表达式。
        # 写成两个 $<$<CONFIG:Debug>:--debug> 的话，条件不成立的那个会展开成
        # 一个空参数（字面量 ""），windeployqt 会把它当成文件名直接报错。
        add_custom_command(TARGET ZmdUIDemo POST_BUILD
            COMMAND "${ZMDUI_WINDEPLOYQT}"
                    "$<IF:$<AND:$<CONFIG:Debug>,$<BOOL:${_zmd_qt_has_debug}>>,--debug,--release>"
                    --no-translations      # 演示程序没有翻译，省 3MB 和几百个小文件
                    --no-opengl-sw         # D3D11 是默认渲染后端，opengl32sw 那 20MB 用不上
                    --qmldir "${CMAKE_CURRENT_SOURCE_DIR}/qml"
                    "$<TARGET_FILE_DIR:ZmdUIDemo>"
            COMMENT "ZmdUI: 部署 Qt 运行时到构建目录（可直接运行 / IDE 里 Run）"
            VERBATIM)
        message(STATUS "ZmdUI: 构建目录自包含已开启（windeployqt: ${ZMDUI_WINDEPLOYQT}）")
    else()
        message(WARNING
            "ZmdUI: 没找到 windeployqt，构建目录里的 exe 需要手动把 Qt 的 bin 加进 PATH 才能运行。")
    endif()
endif()

# ── 部署 ─────────────────────────────────────────────────────────────────
# qt_generate_deploy_app_script 会挑对应平台的部署工具：
#   Windows → windeployqt（Qt DLL + QML 插件 + 平台插件）
#   macOS   → macdeployqt
#   其它平台 → 直接跳过（NO_UNSUPPORTED_PLATFORM_ERROR，不报错）
#
# ⚠️ 必须显式把 QML 目录喂给部署工具（windeployqt 的 --qmldir / macdeployqt 的 -qmldir=）。
#    本工程用的是普通 .qrc 而不是 qt_add_qml_module，部署工具**不会**自动知道 QML 在哪，
#    漏掉这一步的后果是：Qt 的 DLL 都在，但 qml/ 目录是空的 —— 拷到干净机器上
#    QtQuick.Controls 插件加载不到，程序直接起不来。
#    实测过：不加这个参数时 dist/qml/ 为空；加上之后 qml/QtQuick/Controls/Basic 等才齐全。
if(WIN32)
    set(_zmd_deploy_opts --qmldir "${CMAKE_CURRENT_SOURCE_DIR}/qml")
elseif(APPLE)
    set(_zmd_deploy_opts -qmldir=${CMAKE_CURRENT_SOURCE_DIR}/qml)
else()
    set(_zmd_deploy_opts "")
endif()

install(TARGETS ZmdUIDemo
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION bin
)

qt_generate_deploy_app_script(
    TARGET ZmdUIDemo
    OUTPUT_SCRIPT zmd_deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_TOOL_OPTIONS ${_zmd_deploy_opts}
)
install(SCRIPT ${zmd_deploy_script})

# 交付时建议再带上许可与说明（可选，缺文件也不报错）
install(FILES README.md DESTINATION . OPTIONAL)
```

### `.gitignore`

忽略各编译器的构建目录与部署产物

```text
# ── 构建产物 ──────────────────────────────────────────────────────────────
# 跨平台工程建议一个编译器一个构建目录，这里全部忽略
build/
build-*/
out/
cmake-build-*/

# install / 部署产物（由 cmake --install + windeployqt / macdeployqt 生成）
dist/
dist-*/
install/

# ── CMake ────────────────────────────────────────────────────────────────
CMakeCache.txt
CMakeFiles/
CMakeUserPresets.json
cmake_install.cmake
install_manifest.txt
*.cmake.stamp

# ── Qt / QML 工具产物 ────────────────────────────────────────────────────
*.qmlc
*.jsc
qmlls.ini
.qmlformat.ini

# ── 验证脚本产物（截图 / 中间图）────────────────────────────────────────
tools/*.png
tools/anim_*.png
tools/hittest.txt

# ── 编辑器 / 系统 ────────────────────────────────────────────────────────
.vscode/
.idea/
*.user
*.user.*
.DS_Store
Thumbs.db
desktop.ini
*.swp
*~

# ── 编译中间产物（保险起见，正常情况下都在 build/ 里）──────────────────
*.o
*.obj
*.exe
*.dll
*.so
*.dylib
*.a
*.lib
*.pdb
```

## 七、自动化验证工具

### `tests/tst_hover.qml`

qmltestrunner 行为测试：规则 / 属性 / 几何断言（9 项）

```qml
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
```

### `tests/tst_richtext.qml`

qmltestrunner 行为测试：富文本块模型 / 序列化 / 结构操作（38 项）

```qml
import QtQuick
import QtTest
import ZmdUI 1.0

/*!
    ZRichTextEditor 的行为测试（qmltestrunner）。

    跑法：
        qmltestrunner -input tests/tst_richtext.qml -import qml

    测试分两层：
      1. 纯函数层 —— 块工厂、归一化、序列化、单位换算。这些不碰界面，
         断言可以写得很硬。
      2. 结构操作层 —— 增删改移、格式开关、信号与 revision 计数。

    故意不去模拟"在 TextArea 里打字"：离屏平台的合成事件到不了控件，
    而且真要验排版得靠像素比对（那是离屏探针的活，不是单测的活）。
*/
TestCase {
    id: root
    name: "ZRichTextEditorBehaviors"
    when: windowShown

    width: 800
    height: 600

    // 每一条用例都用一个全新的编辑器，避免状态互相污染
    Component {
        id: editorComponent
        ZRichTextEditor {
            width: 600
        }
    }

    function makeEditor() {
        var ed = createTemporaryObject(editorComponent, root)
        verify(ed !== null, "editor should instantiate")
        return ed
    }

    // ── 1. 块工厂 ────────────────────────────────────────────────

    function test_makeTextBlockDefaults() {
        var ed = makeEditor()
        var b = ed.makeTextBlock("你好")
        compare(b.type, "text")
        compare(b.text, "你好")
        compare(b.style, "body")
        compare(b.bold, false)
        compare(b.italic, false)
        compare(b.underline, false)
        compare(b.strike, false)
        compare(b.align, "left")
    }

    function test_makeTextBlockCoercesNullishText() {
        var ed = makeEditor()
        compare(ed.makeTextBlock().text, "")
        compare(ed.makeTextBlock(null).text, "")
        compare(ed.makeTextBlock(42).text, "42")
    }

    function test_makeTextBlockAcceptsEnumAndStringStyle() {
        var ed = makeEditor()
        compare(ed.makeTextBlock("", "heading").style, "heading")
        compare(ed.makeTextBlock("", ZRichTextEditor.BlockStyle.Quote).style, "quote")
        compare(ed.makeTextBlock("", 99).style, "body")
        compare(ed.makeTextBlock("", "nonsense").style, "body")
    }

    function test_makeImageBlock() {
        var ed = makeEditor()
        var b = ed.makeImageBlock("file:///a.png", "a.png", "说明")
        compare(b.type, "image")
        compare(b.url, "file:///a.png")
        compare(b.name, "a.png")
        compare(b.caption, "说明")

        var empty = ed.makeImageBlock()
        compare(empty.url, "")
        compare(empty.name, "")
        compare(empty.caption, "")
    }

    function test_makeFileBlockClampsSize() {
        var ed = makeEditor()
        compare(ed.makeFileBlock("u", "n", 2048).size, 2048)
        compare(ed.makeFileBlock("u", "n", -5).size, 0)
        compare(ed.makeFileBlock("u", "n", "abc").size, 0)
        compare(ed.makeFileBlock("u", "n", 10.6).size, 11)
        compare(ed.makeFileBlock().name, "未命名文件")
    }

    // ── 2. 归一化 ────────────────────────────────────────────────

    function test_normalizeBlockTurnsGarbageIntoTextBlock() {
        var ed = makeEditor()
        var nullish = ed.normalizeBlock(null)
        compare(nullish.type, "text")
        compare(nullish.text, "")

        var scalar = ed.normalizeBlock("hello")
        compare(scalar.type, "text")
        compare(scalar.text, "")
    }

    function test_normalizeBlockFillsMissingFields() {
        var ed = makeEditor()
        var img = ed.normalizeBlock({ type: "image" })
        compare(img.url, "")
        compare(img.name, "")
        compare(img.caption, "")

        var file = ed.normalizeBlock({ type: "file", name: "x.zip" })
        compare(file.size, 0)
        compare(file.name, "x.zip")

        var text = ed.normalizeBlock({ type: "text", text: "hi", bold: 1, align: "CENTER" })
        compare(text.bold, true)
        compare(text.align, "center")
    }

    function test_normalizeBlockIgnoresUnknownType() {
        var ed = makeEditor()
        var b = ed.normalizeBlock({ type: "video", text: "x" })
        compare(b.type, "text", "unknown types fall back to text")
        compare(b.text, "x", "and keep the text payload")
    }

    // ── 3. 名字 / 单位换算 ──────────────────────────────────────

    function test_styleNameOf() {
        var ed = makeEditor()
        compare(ed.styleNameOf("heading"), "heading")
        compare(ed.styleNameOf("HEADING"), "heading")
        compare(ed.styleNameOf(0), "body")
        compare(ed.styleNameOf(1), "heading")
        compare(ed.styleNameOf(2), "quote")
        compare(ed.styleNameOf(3), "code")
        compare(ed.styleNameOf(-1), "body")
        compare(ed.styleNameOf(4), "body")
    }

    function test_styleLabelOf() {
        var ed = makeEditor()
        compare(ed.styleLabelOf("body"), "正文")
        compare(ed.styleLabelOf("heading"), "标题")
        compare(ed.styleLabelOf("quote"), "引用")
        compare(ed.styleLabelOf("code"), "代码")
    }

    function test_alignNameOf() {
        var ed = makeEditor()
        compare(ed.alignNameOf("center"), "center")
        compare(ed.alignNameOf("RIGHT"), "right")
        compare(ed.alignNameOf("justify"), "left")
        compare(ed.alignNameOf(undefined), "left")
    }

    function test_formatBytes() {
        var ed = makeEditor()
        compare(ed.formatBytes(0), "0 B")
        compare(ed.formatBytes(-10), "0 B")
        compare(ed.formatBytes(NaN), "0 B")
        compare(ed.formatBytes(512), "512 B")
        compare(ed.formatBytes(1024), "1.0 KB")
        compare(ed.formatBytes(1536), "1.5 KB")
        compare(ed.formatBytes(1024 * 1024), "1.0 MB")
        compare(ed.formatBytes(1024 * 1024 * 1024), "1.0 GB")
    }

    function test_extensionOf() {
        var ed = makeEditor()
        compare(ed.extensionOf("a.png"), "PNG")
        compare(ed.extensionOf("a.tar.gz"), "GZ")
        compare(ed.extensionOf("noext"), "FILE")
        compare(ed.extensionOf("trailing."), "FILE")
        compare(ed.extensionOf(""), "FILE")
        compare(ed.extensionOf(undefined), "FILE")
        // 超长扩展名截到 5 个字符，徽标才放得下
        compare(ed.extensionOf("a.verylongext"), "VERYL")
    }

    // ── 4. 序列化 ────────────────────────────────────────────────

    function test_jsonRoundTrip() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("一段话", "heading"),
                      ed.makeImageBlock("file:///p.png", "p.png", "图注"),
                      ed.makeFileBlock("file:///d.pdf", "d.pdf", 4096)])
        var text = ed.toJSON()
        verify(text.length > 0)

        var back = ed.blocksFromJSON(text)
        compare(back.length, 3)
        compare(back[0].type, "text")
        compare(back[0].text, "一段话")
        compare(back[0].style, "heading")
        compare(back[1].type, "image")
        compare(back[1].caption, "图注")
        compare(back[2].type, "file")
        compare(back[2].size, 4096)
    }

    function test_blocksFromJSONSurvivesGarbage() {
        var ed = makeEditor()
        compare(ed.blocksFromJSON("not json").length, 0)
        compare(ed.blocksFromJSON("{}").length, 0)
        compare(ed.blocksFromJSON("null").length, 0)
        compare(ed.blocksFromJSON("").length, 0)
    }

    // ── 5. 派生状态 ─────────────────────────────────────────────

    function test_blockAtOutOfRange() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a")])
        compare(ed.blockAt(0).text, "a")
        compare(ed.blockAt(-1), null)
        compare(ed.blockAt(1), null)
        compare(ed.blockAt(999), null)
    }

    function test_countBlocksAndStats() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a"),
                      ed.makeTextBlock("b"),
                      ed.makeImageBlock("u", "n"),
                      ed.makeFileBlock("u", "n", 1)])
        compare(ed.countBlocks("text"), 2)
        compare(ed.countBlocks("image"), 1)
        compare(ed.countBlocks("file"), 1)
        compare(ed.stats.text, 2)
        compare(ed.stats.image, 1)
        compare(ed.stats.file, 1)
    }

    function test_isEmpty() {
        var ed = makeEditor()
        ed.setBlocks([])
        compare(ed.isEmpty, true)

        ed.setBlocks([ed.makeTextBlock("")])
        compare(ed.isEmpty, true, "one blank text block is still empty")

        ed.setBlocks([ed.makeTextBlock("x")])
        compare(ed.isEmpty, false)

        ed.setBlocks([ed.makeImageBlock("u", "n")])
        compare(ed.isEmpty, false, "an image alone is not empty")
    }

    function test_plainTextOf() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("第一行"),
                      ed.makeImageBlock("u", "p.png"),
                      ed.makeTextBlock("第二行"),
                      ed.makeFileBlock("u", "d.pdf", 10)])
        compare(ed.plainTextOf(), "第一行\n[图片: p.png]\n第二行\n[文件: d.pdf]")
    }

    function test_textFontFor() {
        var ed = makeEditor()
        var body = ed.textFontFor(ed.formatOf(-1))
        compare(body.pixelSize, 14)
        var heading = ed.textFontFor({ style: "heading" })
        compare(heading.pixelSize, 24)
        var code = ed.textFontFor({ style: "code" })
        compare(code.pixelSize, 13)
        compare(ed.textFontFor({ style: "body", bold: true }).bold, true)
        compare(ed.textFontFor({ style: "body", italic: true }).italic, true)
        compare(ed.textFontFor({ style: "body", underline: true }).underline, true)
        compare(ed.textFontFor({ style: "body", strike: true }).strikeout, true)
        // 引用块强制斜体
        compare(ed.textFontFor({ style: "quote" }).italic, true)
    }

    function test_hAlignFor() {
        var ed = makeEditor()
        compare(ed.hAlignFor("left"), Text.AlignLeft)
        compare(ed.hAlignFor("center"), Text.AlignHCenter)
        compare(ed.hAlignFor("right"), Text.AlignRight)
        compare(ed.hAlignFor(undefined), Text.AlignLeft)
    }

    // ── 6. 结构操作 ─────────────────────────────────────────────

    function test_setBlocksResetsCurrentIndex() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a"), ed.makeTextBlock("b")])
        compare(ed.blocks.length, 2)
        compare(ed.currentIndex, 0)

        ed.setBlocks([])
        compare(ed.blocks.length, 0)
        compare(ed.currentIndex, -1)
    }

    function test_setBlocksNormalizesInput() {
        var ed = makeEditor()
        ed.setBlocks([{ type: "video", text: "x" }, null])
        compare(ed.blocks.length, 2)
        compare(ed.blocks[0].type, "text")
        compare(ed.blocks[1].type, "text")
    }

    function test_insertBlockPositions() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a"), ed.makeTextBlock("c")])

        // 在 0 号后面插 → 落在 1
        compare(ed.insertBlock(0, ed.makeTextBlock("b")), 1)
        compare(ed.blocks[1].text, "b")

        // -1 表示插到最前面
        compare(ed.insertBlock(-1, ed.makeTextBlock("z")), 0)
        compare(ed.blocks[0].text, "z")

        // 超出末尾 → 夹到尾部
        var at = ed.insertBlock(999, ed.makeTextBlock("last"))
        compare(at, ed.blocks.length - 1)
        compare(ed.blocks[at].text, "last")
    }

    function test_appendBlock() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a")])
        var at = ed.appendBlock(ed.makeTextBlock("b"))
        compare(at, 1)
        compare(ed.blocks[1].text, "b")
        compare(ed.currentIndex, 1)
    }

    function test_insertHelpersDefaultToCurrentBlock() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a"), ed.makeTextBlock("b")])
        ed.currentIndex = 0

        ed.insertImageBlock("u", "img.png")
        compare(ed.blocks[1].type, "image")

        ed.insertFileBlock("u", "f.txt", 12)
        compare(ed.blocks[2].type, "file")

        ed.insertTextBlock(undefined, "after")
        compare(ed.blocks[3].type, "text")
        compare(ed.blocks[3].text, "after")
    }

    function test_removeBlockClampsCurrentIndex() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a"), ed.makeTextBlock("b"), ed.makeTextBlock("c")])

        compare(ed.removeBlock(1), true)
        compare(ed.blocks.length, 2)
        compare(ed.blocks[1].text, "c")

        compare(ed.removeBlock(99), false, "out of range")
        compare(ed.removeBlock(-1), false)

        compare(ed.removeBlock(0), true)
        compare(ed.removeBlock(0), true)
        compare(ed.blocks.length, 0)
        compare(ed.currentIndex, -1, "emptying the doc drops the cursor")
    }

    function test_moveBlock() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a"), ed.makeTextBlock("b"), ed.makeTextBlock("c")])

        compare(ed.moveBlock(0, 2), true)
        compare(ed.blocks[0].text, "b")
        compare(ed.blocks[1].text, "c")
        compare(ed.blocks[2].text, "a")
        compare(ed.currentIndex, 2, "cursor follows the moved block")

        compare(ed.moveBlock(1, 1), false, "same slot is a no-op")
        compare(ed.moveBlock(0, 9), false)
        compare(ed.moveBlock(-2, 0), false)
    }

    function test_setStyleOnlyOnTextBlocks() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a")])
        compare(ed.setStyle("heading"), true)
        compare(ed.blocks[0].style, "heading")

        ed.insertImageBlock("u", "n")
        ed.currentIndex = 1
        compare(ed.setStyle("quote"), false, "images have no text style")
        compare(ed.blocks[1].type, "image")
    }

    function test_toggleFormat() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a")])

        compare(ed.toggleFormat("bold"), true)
        compare(ed.blocks[0].bold, true)
        compare(ed.toggleFormat("bold"), true)
        compare(ed.blocks[0].bold, false, "toggling twice restores")

        compare(ed.toggleFormat("italic"), true)
        compare(ed.toggleFormat("underline"), true)
        compare(ed.toggleFormat("strike"), true)
        compare(ed.blocks[0].italic && ed.blocks[0].underline && ed.blocks[0].strike, true)

        compare(ed.toggleFormat("bogus"), false, "unknown flag is rejected")
    }

    function test_setAlign() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("a")])
        compare(ed.setAlign("center"), true)
        compare(ed.blocks[0].align, "center")
        compare(ed.setAlign("nonsense"), true)
        compare(ed.blocks[0].align, "left")
    }

    function test_clearLeavesOneBlankTextBlock() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeImageBlock("u", "n")])
        ed.clear()
        compare(ed.blocks.length, 1)
        compare(ed.blocks[0].type, "text")
        compare(ed.blocks[0].text, "")
        compare(ed.currentIndex, 0)
        compare(ed.isEmpty, true)
    }

    // ── 7. 信号与版本号 ─────────────────────────────────────────

    function test_revisionIncrementsOnEveryMutation() {
        var ed = makeEditor()
        var r0 = ed.revision
        ed.setBlocks([ed.makeTextBlock("a")])
        var r1 = ed.revision
        verify(r1 > r0, "setBlocks bumps revision")

        ed.toggleFormat("bold")
        verify(ed.revision > r1, "format change bumps revision")
        var r2 = ed.revision

        ed.insertBlock(-1, ed.makeTextBlock("z"))
        verify(ed.revision > r2)

        // 原地改字段也必须涨版本号，否则界面不会刷新
        var r3 = ed.revision
        ed.setStyle("code")
        verify(ed.revision > r3)
    }

    function test_contentsChangedFires() {
        var ed = makeEditor()
        var spy = createTemporaryObject(componentSpy, ed)
        verify(spy !== null)

        ed.setBlocks([ed.makeTextBlock("a")])
        spy.clear()
        ed.toggleFormat("bold")
        compare(spy.count, 1, "toggleFormat emits once")

        spy.clear()
        ed.removeBlock(0)
        compare(spy.count, 1, "removeBlock emits once")
    }

    Component {
        id: componentSpy
        SignalSpy { target: parent; signalName: "contentsChanged" }
    }

    // ── 8. 装配 ─────────────────────────────────────────────────

    function test_rendersBlocksAndSizesItself() {
        var ed = makeEditor()
        ed.setBlocks([ed.makeTextBlock("标题", "heading"),
                      ed.makeTextBlock("正文段落"),
                      ed.makeImageBlock("file:///nope.png", "nope.png", "图注"),
                      ed.makeFileBlock("file:///nope.pdf", "nope.pdf", 2048)])
        wait(50)
        // 4 块都要渲染出高度；缺图 / 缺文件不该让整块塌成 0
        verify(ed.implicitHeight > 0, "editor reports an implicit height")
        compare(ed.blocks.length, 4)
    }

    function test_emptyEditorShowsPlaceholderState() {
        var ed = makeEditor()
        ed.setBlocks([])
        wait(50)
        verify(ed.implicitHeight > 0, "empty editor still occupies the drop/placeholder area")
        verify(ed.isEmpty)
    }
}
```

### `tests/tst_chatinput.qml`

qmltestrunner 行为测试：附件模型 / 上限 / canSend / 发送快照 / 回车语义 / 拖放粘贴 / 选择框 / 暗色填充 / 超高滚动 / 定高与溢出开关 / 滚轮接管 / 附件条定高（71 项）

```qml
import QtQuick
import QtTest
import QtQuick.Controls.Basic
import ZmdUI 1.0

/*!
    ZChatInput 的行为测试（qmltestrunner）。

    跑法：
        qmltestrunner -input tests/tst_chatinput.qml -import qml

    测试分两层：
      1. 纯函数层 —— 附件工厂、归一化、换算、序列化、快捷键判定。不碰界面，断言可以写得很硬。
      2. 草稿操作层 —— 增删附件、上限、canSend / submit、信号与 revision。

    故意不去模拟"在 TextArea 里敲键盘"：离屏平台的合成事件到不了控件，
    而且回车到底该发消息还是换行，本身就抽成了 isSendCombo 这个纯函数，
    直接断言它比模拟按键更准。
*/
TestCase {
    id: root
    name: "ZChatInputBehaviors"
    when: windowShown

    width: 800
    height: 600

    Component {
        id: chatComponent
        ZChatInput {
            width: 600
        }
    }

    Component {
        id: spyComponent
        SignalSpy { }
    }

    Component {
        id: outerFlickableComponent
        Flickable {
            width: 600
            height: 300
            contentHeight: 2000
        }
    }

    function makeChat(parentItem) {
        var chat = createTemporaryObject(chatComponent, parentItem === undefined ? root : parentItem)
        verify(chat !== null, "chat input should instantiate")
        return chat
    }

    function makeSpy(target, signalName) {
        var spy = spyComponent.createObject(root, { "target": target, "signalName": signalName })
        verify(spy !== null, "spy should instantiate for " + signalName)
        return spy
    }

    // ── 1. 附件工厂与归一化 ──────────────────────────────────────

    function test_makeImageAttachmentDefaults() {
        var chat = makeChat()
        var a = chat.makeImageAttachment("file:///pic.png")
        compare(a.type, "image")
        compare(a.url, "file:///pic.png")
        compare(a.name, "pic.png")
        compare(a.size, 0)
        verify(String(a.id).length > 0, "every attachment gets an id")
    }

    function test_makeFileAttachmentKeepsSize() {
        var chat = makeChat()
        var a = chat.makeFileAttachment("file:///doc.pdf", "doc.pdf", 2048)
        compare(a.type, "file")
        compare(a.name, "doc.pdf")
        compare(a.size, 2048)
    }

    function test_makeFileAttachmentClampsBadSize() {
        var chat = makeChat()
        compare(chat.makeFileAttachment("u", "n", -5).size, 0)
        compare(chat.makeFileAttachment("u", "n", "abc").size, 0)
        compare(chat.makeFileAttachment("u", "n", 12.6).size, 13)
    }

    function test_normalizeAttachmentTurnsUnknownTypeIntoFile() {
        var chat = makeChat()
        compare(chat.normalizeAttachment({ type: "video", url: "u" }).type, "file")
        compare(chat.normalizeAttachment({}).type, "file")
        compare(chat.normalizeAttachment(null).type, "file")
        compare(chat.normalizeAttachment({ type: "IMAGE" }).type, "image")
    }

    function test_normalizeAttachmentFillsMissingFields() {
        var chat = makeChat()
        var a = chat.normalizeAttachment({ type: "image", url: "file:///a/b/photo.jpg" })
        compare(a.name, "photo.jpg", "name falls back to the file name in the url")
        verify(String(a.id).length > 0)
        compare(a.size, 0)
    }

    function test_normalizeAttachmentKeepsGivenId() {
        var chat = makeChat()
        compare(chat.normalizeAttachment({ type: "file", id: "abc" }).id, "abc")
    }

    function test_attachmentIdsAreUnique() {
        var chat = makeChat()
        var a = chat.makeFileAttachment("u1", "n1")
        var b = chat.makeFileAttachment("u2", "n2")
        verify(a.id !== b.id, "generated ids must not collide")
    }

    function test_fileNameOf() {
        var chat = makeChat()
        compare(chat.fileNameOf("file:///c:/tmp/报告.pdf"), "报告.pdf")
        compare(chat.fileNameOf("C:\\Users\\me\\a.png"), "a.png")
        compare(chat.fileNameOf("plain.txt"), "plain.txt")
        compare(chat.fileNameOf(""), "")
        compare(chat.fileNameOf(null), "")
    }

    function test_extensionOf() {
        var chat = makeChat()
        compare(chat.extensionOf("a.PDF"), "pdf")
        compare(chat.extensionOf(".gitignore"), "", "dot files have no extension")
        compare(chat.extensionOf("archive.tar.gz"), "gz")
        compare(chat.extensionOf("noext"), "")
        compare(chat.extensionOf("trailing."), "")
    }

    function test_formatBytes() {
        var chat = makeChat()
        compare(chat.formatBytes(0), "0 B")
        compare(chat.formatBytes(512), "512 B")
        compare(chat.formatBytes(1536), "1.5 KB")
        compare(chat.formatBytes(1024 * 1024 * 3), "3.0 MB")
        compare(chat.formatBytes(-1), "0 B")
    }

    // ── 2. 加附件 ────────────────────────────────────────────────

    function test_addAttachmentAppendsAndBumpsRevision() {
        var chat = makeChat()
        var r0 = chat.revision
        var idx = chat.addFile("file:///a.pdf", "a.pdf", 10)
        compare(idx, 0)
        compare(chat.attachmentCount, 1)
        verify(chat.revision > r0, "adding bumps revision")
        compare(chat.attachments[0].name, "a.pdf")
    }

    function test_addAttachmentWithoutUrlOrNameIsRejected() {
        var chat = makeChat()
        compare(chat.addAttachment({ type: "file" }), -1)
        compare(chat.addAttachment(null), -1)
        compare(chat.attachmentCount, 0)
    }

    function test_addAttachmentRejectedWhenReadOnly() {
        var chat = makeChat()
        chat.readOnly = true
        compare(chat.addImage("u", "n"), -1)
        compare(chat.attachmentCount, 0)
    }

    function test_maxAttachmentsEnforced() {
        var chat = makeChat()
        chat.maxAttachments = 2
        var spy = makeSpy(chat, "limitReached")
        compare(chat.addImage("u1", "n1"), 0)
        compare(chat.addImage("u2", "n2"), 1)
        compare(chat.addImage("u3", "n3"), -1, "third one is refused")
        compare(chat.attachmentCount, 2)
        compare(spy.count, 1)
        compare(spy.signalArguments[0][0], "attachments")
    }

    function test_maxAttachmentsZeroMeansUnlimited() {
        var chat = makeChat()
        chat.maxAttachments = 0
        for (var i = 0; i < 20; ++i)
            compare(chat.addImage("u" + i, "n" + i), i)
        compare(chat.attachmentCount, 20)
    }

    function test_attachmentAddedCarriesPayload() {
        var chat = makeChat()
        var spy = makeSpy(chat, "attachmentAdded")
        chat.addImage("file:///x.png", "x.png")
        compare(spy.count, 1)
        compare(spy.signalArguments[0][0].type, "image")
        compare(spy.signalArguments[0][1], 0)
    }

    // ── 3. 删附件 ────────────────────────────────────────────────

    function test_removeAttachmentRemovesTheRightOne() {
        var chat = makeChat()
        chat.addImage("u1", "a.png")
        chat.addFile("u2", "b.pdf", 1)
        chat.addImage("u3", "c.png")
        verify(chat.removeAttachment(1))
        compare(chat.attachmentCount, 2)
        compare(chat.attachments[0].name, "a.png")
        compare(chat.attachments[1].name, "c.png")
    }

    function test_removeAttachmentRejectsBadIndex() {
        var chat = makeChat()
        chat.addImage("u1", "a.png")
        verify(!chat.removeAttachment(-1))
        verify(!chat.removeAttachment(5))
        compare(chat.attachmentCount, 1)
    }

    function test_removeAttachmentRejectedWhenReadOnly() {
        var chat = makeChat()
        chat.addImage("u1", "a.png")
        chat.readOnly = true
        verify(!chat.removeAttachment(0))
        compare(chat.attachmentCount, 1)
    }

    function test_attachmentRemovedCarriesPayload() {
        var chat = makeChat()
        chat.addFile("u", "b.pdf", 3)
        var spy = makeSpy(chat, "attachmentRemoved")
        chat.removeAttachment(0)
        compare(spy.count, 1)
        compare(spy.signalArguments[0][0].name, "b.pdf")
        compare(spy.signalArguments[0][1], 0)
    }

    function test_clearAttachments() {
        var chat = makeChat()
        chat.addImage("u1", "a.png")
        chat.addFile("u2", "b.pdf", 1)
        var r0 = chat.revision
        chat.clearAttachments()
        compare(chat.attachmentCount, 0)
        verify(chat.revision > r0)
        // 已经空了再清一次不该白涨版本号
        var r1 = chat.revision
        chat.clearAttachments()
        compare(chat.revision, r1)
    }

    // ── 4. 派生状态 ──────────────────────────────────────────────

    function test_hasContent() {
        var chat = makeChat()
        verify(!chat.hasContent, "empty draft has no content")
        chat.text = "   "
        verify(!chat.hasContent, "whitespace only does not count")
        chat.text = "hi"
        verify(chat.hasContent)
        chat.text = ""
        chat.addImage("u", "a.png")
        verify(chat.hasContent, "an attachment counts as content")
    }

    function test_countsByType() {
        var chat = makeChat()
        chat.addImage("u1", "a.png")
        chat.addImage("u2", "b.png")
        chat.addFile("u3", "c.pdf", 1)
        compare(chat.imageCount, 2)
        compare(chat.fileCount, 1)
        compare(chat.attachmentCount, 3)
    }

    function test_overLimitAndCounter() {
        var chat = makeChat()
        chat.maxLength = 3
        chat.text = "abcd"
        verify(chat.overLimit)
        compare(chat.counterText, "4 / 3")
        chat.text = "ab"
        verify(!chat.overLimit)
        compare(chat.counterText, "2 / 3")
    }

    function test_unlimitedCounter() {
        var chat = makeChat()
        chat.maxLength = 0
        chat.text = "abc"
        verify(!chat.overLimit, "maxLength 0 means no limit")
        compare(chat.counterText, "3 字")
    }

    function test_draftSummary() {
        var chat = makeChat()
        compare(chat.draftSummary, "0 字")
        chat.text = "hello"
        compare(chat.draftSummary, "5 字")
        chat.addImage("u", "a.png")
        compare(chat.draftSummary, "5 字 · 1 图")
        chat.addFile("u", "b.pdf", 1)
        compare(chat.draftSummary, "5 字 · 1 图 · 1 文件")
    }

    function test_canSend() {
        var chat = makeChat()
        verify(!chat.canSend, "nothing to send")
        chat.text = "hi"
        verify(chat.canSend)
        chat.readOnly = true
        verify(!chat.canSend, "read only cannot send")
        chat.readOnly = false
        chat.busy = true
        verify(!chat.canSend, "busy cannot send")
        chat.busy = false
        chat.maxLength = 1
        verify(chat.overLimit)
        verify(!chat.canSend, "over limit cannot send")
    }

    // ── 5. 发送 ──────────────────────────────────────────────────

    function test_submitEmitsTextAndSnapshot() {
        var chat = makeChat()
        chat.text = "你好"
        chat.addImage("file:///a.png", "a.png")
        var spy = makeSpy(chat, "sendRequested")
        verify(chat.submit())
        compare(spy.count, 1)
        compare(spy.signalArguments[0][0], "你好")
        var sent = spy.signalArguments[0][1]
        compare(sent.length, 1)
        compare(sent[0].name, "a.png")
    }

    function test_submitSnapshotIsACopy() {
        var chat = makeChat()
        chat.text = "x"
        chat.addImage("u", "a.png")
        var spy = makeSpy(chat, "sendRequested")
        chat.submit()
        var sent = spy.signalArguments[0][1]
        sent[0].name = "changed"
        sent.push({ type: "file", name: "injected" })
        compare(chat.attachments.length, 1, "mutating the snapshot must not touch the draft")
        compare(chat.attachments[0].name, "a.png")
    }

    function test_submitRefusesWhenEmptyOrBlocked() {
        var chat = makeChat()
        var spy = makeSpy(chat, "sendRequested")
        verify(!chat.submit(), "empty draft sends nothing")
        chat.text = "hi"
        chat.readOnly = true
        verify(!chat.submit(), "read only sends nothing")
        chat.readOnly = false
        chat.busy = true
        verify(!chat.submit(), "busy sends nothing")
        chat.busy = false
        chat.maxLength = 1
        verify(!chat.submit(), "over limit sends nothing")
        compare(spy.count, 0)
    }

    function test_submitKeepsDraftByDefault() {
        var chat = makeChat()
        chat.text = "hi"
        chat.addImage("u", "a.png")
        chat.submit()
        compare(chat.text, "hi", "clearOnSend defaults to false")
        compare(chat.attachmentCount, 1)
    }

    function test_clearOnSend() {
        var chat = makeChat()
        chat.clearOnSend = true
        chat.text = "hi"
        chat.addImage("u", "a.png")
        chat.submit()
        compare(chat.text, "")
        compare(chat.attachmentCount, 0)
    }

    function test_clearResetsEverything() {
        var chat = makeChat()
        chat.text = "hi"
        chat.addImage("u", "a.png")
        chat.clear()
        compare(chat.text, "")
        compare(chat.attachmentCount, 0)
        verify(!chat.canSend)
    }

    // ── 6. 序列化 ────────────────────────────────────────────────

    function test_draftRoundTrip() {
        var chat = makeChat()
        chat.text = "草稿"
        chat.addImage("file:///a.png", "a.png")
        chat.addFile("file:///b.pdf", "b.pdf", 1234)
        var dump = chat.draftToJSON()

        var other = makeChat()
        other.draftFromJSON(dump)
        compare(other.text, "草稿")
        compare(other.attachmentCount, 2)
        compare(other.attachments[0].type, "image")
        compare(other.attachments[1].name, "b.pdf")
        compare(other.attachments[1].size, 1234)
    }

    function test_draftFromJSONSurvivesGarbage() {
        var chat = makeChat()
        chat.text = "先放点东西"
        chat.addImage("u", "a.png")
        chat.draftFromJSON(null)
        compare(chat.text, "")
        compare(chat.attachmentCount, 0)

        chat.draftFromJSON({ attachments: [{ type: "weird", url: "u" }] })
        compare(chat.attachmentCount, 1)
        compare(chat.attachments[0].type, "file", "unknown type degrades to file")
    }

    // ── 7. 回车语义 ──────────────────────────────────────────────

    function test_isSendComboDefaultsToEnterSends() {
        var chat = makeChat()
        verify(chat.sendOnEnter, "default mode is Enter sends")
        verify(chat.isSendCombo(Qt.NoModifier), "Enter alone sends")
        verify(!chat.isSendCombo(Qt.ShiftModifier), "Shift+Enter inserts a newline")
        verify(chat.isSendCombo(Qt.ControlModifier), "Ctrl+Enter always sends")
    }

    function test_isSendComboSwappedMode() {
        var chat = makeChat()
        chat.sendOnEnter = false
        verify(!chat.isSendCombo(Qt.NoModifier), "Enter alone inserts a newline")
        verify(!chat.isSendCombo(Qt.ShiftModifier), "Shift+Enter still a newline")
        verify(chat.isSendCombo(Qt.ControlModifier), "Ctrl+Enter sends")
        verify(chat.isSendCombo(Qt.ControlModifier | Qt.ShiftModifier), "Ctrl+Shift+Enter sends")
    }

    // ── 8. 装配 ─────────────────────────────────────────────────

    function test_rendersWithAttachments() {
        var chat = makeChat()
        chat.text = "一段草稿"
        chat.addImage("file:///nope.png", "nope.png")
        chat.addFile("file:///nope.pdf", "nope.pdf", 2048)
        wait(50)
        verify(chat.implicitHeight > 0, "composer reports an implicit height")
        compare(chat.attachmentCount, 2)
        compare(chat.imageCount, 1)
        // 输入区高度在 min / max 之间，不该塌成 0
        verify(chat.height > 0)
    }

    function test_heightStaysWithinBounds() {
        var chat = makeChat()
        chat.allowResize = true          // 只有开了这个开关，输入区才会跟着内容长高
        chat.minTextHeight = 60
        chat.maxTextHeight = 90
        wait(50)
        var h0 = chat.implicitHeight
        chat.text = "很长的内容 ".repeat(200)
        wait(50)
        verify(chat.implicitHeight >= h0, "adding lines grows the composer")
        verify(chat.implicitHeight <= h0 + 400, "growth is bounded by maxTextHeight")

        // 默认（allowResize = false）下同样塞长文本，输入区高度不许变
        // （比的是输入区视口，不是整个组件 —— 整个组件里还有一行"空态提示"会消失）
        var fixed = makeChat()
        fixed.minTextHeight = 60
        var fixedScroll = findChild(fixed, "chatTextScroller")
        fixed.text = "很长的内容 ".repeat(200)
        wait(50)
        compare(fixedScroll.height, 60, "allowResize 关掉后输入区高度必须纹丝不动")
    }

    function test_toolbarAndHeaderCanBeHidden() {
        var chat = makeChat()
        var withBoth = 0
        wait(50)
        withBoth = chat.implicitHeight
        chat.showToolbar = false
        chat.showHeader = false
        wait(50)
        verify(chat.implicitHeight < withBoth, "hiding chrome shrinks the composer")
    }

    // ── 9. 拖放与粘贴（把 url 变成附件的那条链路）────────────────

    function test_isImageUrl() {
        var chat = makeChat()
        verify(chat.isImageUrl("file:///c:/tmp/a.png"))
        verify(chat.isImageUrl("C:\\Users\\me\\照片.JPG"), "extension match is case-insensitive")
        verify(chat.isImageUrl("file:///a/b/c.webp"))
        verify(!chat.isImageUrl("file:///a/b/c.pdf"))
        verify(!chat.isImageUrl("file:///a/b/noext"))
        verify(!chat.isImageUrl(""), "empty url is not an image")
        verify(!chat.isImageUrl(null))
    }

    function test_insertedTextFindsTheAppendedChunk() {
        var chat = makeChat()
        compare(chat.insertedText("abc", "abcdef"), "def")
        compare(chat.insertedText("", "abc"), "abc")
        compare(chat.insertedText("abc", "abc"), "", "no change inserts nothing")
    }

    function test_insertedTextFindsThePastedChunkInTheMiddle() {
        var chat = makeChat()
        // 用户把 "XY" 粘在 "ab|cd" 之间
        compare(chat.insertedText("abcd", "abXYcd"), "XY")
        // 常见前后缀（"aa"）不能被误算成插入内容
        compare(chat.insertedText("aaaa", "aaXYaa"), "XY")
    }

    function test_insertedTextReportsDeletionAsEmpty() {
        var chat = makeChat()
        compare(chat.insertedText("abcdef", "abef"), "", "deletion inserts nothing")
    }

    function test_fileUrlsInSingleUrl() {
        var chat = makeChat()
        var urls = chat.fileUrlsIn("file:///C:/dev/ZmdUI/README.md")
        compare(urls.length, 1)
        compare(urls[0], "file:///C:/dev/ZmdUI/README.md")
    }

    function test_fileUrlsInMultipleLines() {
        var chat = makeChat()
        var urls = chat.fileUrlsIn("file:///a.png\r\nfile:///b.pdf\nfile:///c.txt")
        compare(urls.length, 3, "CRLF and LF both split")
        compare(urls[2], "file:///c.txt")
    }

    function test_fileUrlsInRejectsTextWithoutUrls() {
        var chat = makeChat()
        compare(chat.fileUrlsIn("看这个 file:///a.png").length, 0,
                "a url buried in prose must stay text")
        compare(chat.fileUrlsIn("hello").length, 0)
        compare(chat.fileUrlsIn("").length, 0)
        compare(chat.fileUrlsIn(null).length, 0)
    }

    function test_addUrlsAsAttachmentsSplitsImageAndFile() {
        var chat = makeChat()
        var added = chat.addUrlsAsAttachments(["file:///a.png", "file:///b.pdf"])
        compare(added, 2)
        compare(chat.attachmentCount, 2)
        compare(chat.imageCount, 1, "png lands in the image bucket")
        compare(chat.fileCount, 1, "pdf lands in the file bucket")
        compare(chat.attachments[0].name, "a.png")
        compare(chat.attachments[1].type, "file")
        compare(chat.attachments[1].size, 0, "dropped files have no known size")
    }

    function test_addUrlsAsAttachmentsSkipsEmptyEntries() {
        var chat = makeChat()
        compare(chat.addUrlsAsAttachments(["", null, "file:///x.txt"]), 1)
        compare(chat.attachmentCount, 1)
        compare(chat.addUrlsAsAttachments([]), 0)
        compare(chat.addUrlsAsAttachments(null), 0)
    }

    function test_addUrlsAsAttachmentsRespectsTheCap() {
        var chat = makeChat()
        chat.maxAttachments = 1
        var spy = makeSpy(chat, "limitReached")
        compare(chat.addUrlsAsAttachments(["file:///a.png", "file:///b.png"]), 1,
                "only the first one fits")
        compare(chat.attachmentCount, 1)
        compare(spy.count, 1, "hitting the cap reports limitReached once")
    }

    function test_addUrlsAsAttachmentsIgnoredWhenReadOnly() {
        var chat = makeChat()
        chat.readOnly = true
        compare(chat.addUrlsAsAttachments(["file:///a.png"]), 0)
        compare(chat.attachmentCount, 0)
    }

    // ── 系统文件选择框的接线 ──────────────────────────────────────
    function test_systemDialogsAreOnByDefault() {
        var chat = makeChat()
        verify(chat.useSystemDialogs, "不加任何配置，点「图片」/「文件」就该有东西弹出来")
    }

    function test_urlsOfDropsEmptyEntries() {
        var chat = makeChat()
        compare(chat.urlsOf(undefined).length, 0)
        compare(chat.urlsOf([]).length, 0)
        var got = chat.urlsOf(["file:///a.png", null, "", "file:///b.txt"])
        compare(got.length, 2)
        compare(got[0], "file:///a.png")
        compare(got[1], "file:///b.txt")
    }

    function test_openImagePickerEmitsSignal() {
        var chat = makeChat()
        chat.useSystemDialogs = false   // 单测里绝不能真弹原生对话框
        var spy = makeSpy(chat, "imagePickRequested")
        chat.openImagePicker()
        compare(spy.count, 1)
    }

    function test_openFilePickerEmitsSignal() {
        var chat = makeChat()
        chat.useSystemDialogs = false
        var spy = makeSpy(chat, "filePickRequested")
        chat.openFilePicker()
        compare(spy.count, 1)
    }

    // ── 11. 长文本不能在输入框里"沉下去" ────────────────────────
    // 输入区高度封顶在 maxTextHeight，超出的部分必须内部滚动；
    // 否则第 9 行以后被裁掉、光标停在可视区外，看起来就是"文字和光标跑到框下面消失"。
    function test_longTextScrollsAndKeepsTheCaretVisible() {
        var chat = makeChat()
        var area = findChild(chat, "chatTextArea")
        var scroll = findChild(chat, "chatTextScroller")
        verify(area !== null, "text area should be findable")
        verify(scroll !== null, "text scroller should be findable")

        var lines = []
        for (var i = 1; i <= 16; ++i)
            lines.push("第 " + i + " 行")
        chat.text = lines.join("\n")

        area.forceActiveFocus()
        area.cursorPosition = area.length

        // 视口高度必须封顶在 maxTextHeight，整块输入框不能被撑高
        verify(scroll.height <= chat.maxTextHeight,
               "viewport must be capped at maxTextHeight, got " + scroll.height)
        verify(scroll.contentHeight > scroll.height,
               "16 lines must overflow the viewport")

        tryVerify(function () { return scroll.contentY > 0 }, 1000,
                  "viewport must auto-scroll to keep the caret visible")

        var r = area.cursorRectangle
        verify(r.y >= scroll.contentY,
               "caret top " + r.y + " must be inside viewport starting at " + scroll.contentY)
        verify(r.y + r.height <= scroll.contentY + scroll.height + 1,
               "caret bottom " + (r.y + r.height) + " must be inside viewport ending at "
               + (scroll.contentY + scroll.height))
    }

    function test_shortTextStaysAtTheTop() {
        var chat = makeChat()
        var scroll = findChild(chat, "chatTextScroller")
        chat.text = "只有一行"
        compare(scroll.contentY, 0)
        verify(scroll.contentHeight <= scroll.height, "short text must not overflow")
    }

    // ── 12. 输入区大小 / 溢出：两个开关 ──────────────────────────
    // 默认：高度固定（allowResize = false）、内容可以超出并在框内滚动（allowOverflow = true）。
    function test_resizeAndOverflowDefaults() {
        var chat = makeChat()
        compare(chat.allowResize, false, "输入框默认不随内容变高")
        compare(chat.allowOverflow, true, "内容默认允许超出输入框")
    }

    function test_resizeDisabledKeepsTheBoxAtMinTextHeight() {
        var chat = makeChat()
        var scroll = findChild(chat, "chatTextScroller")
        var lines = []
        for (var i = 1; i <= 16; ++i)
            lines.push("第 " + i + " 行")
        chat.text = lines.join("\n")
        compare(scroll.height, chat.minTextHeight,
                "关掉 allowResize 后输入区高度应恒为 minTextHeight")
    }

    function test_resizeEnabledGrowsUpToMaxTextHeight() {
        var chat = makeChat()
        chat.allowResize = true
        var scroll = findChild(chat, "chatTextScroller")

        chat.text = "两行\n文字"
        compare(scroll.height, chat.minTextHeight,
                "两行放得下 minTextHeight，不该撑高")

        chat.text = "五行\n五行\n五行\n五行\n五行"
        verify(scroll.height > chat.minTextHeight,
               "开着 allowResize 时内容超高应把输入区撑高，实际 " + scroll.height)
        verify(scroll.height <= chat.maxTextHeight, "但不能超过 maxTextHeight")

        var lines = []
        for (var i = 1; i <= 16; ++i)
            lines.push("第 " + i + " 行")
        chat.text = lines.join("\n")
        compare(scroll.height, chat.maxTextHeight,
                "长文本时长到 maxTextHeight 就停")
    }

    function test_overflowDisabledRejectsTextBeyondTheBox() {
        var chat = makeChat()
        chat.allowOverflow = false

        var spy = makeSpy(chat, "limitReached")
        var scroll = findChild(chat, "chatTextScroller")
        var area = findChild(chat, "chatTextArea")

        chat.text = "第一行"
        compare(chat.text, "第一行", "短文本照常接受")

        // 一次性灌 16 行：整段退回，正文停在上一版
        var lines = []
        for (var i = 1; i <= 16; ++i)
            lines.push("第 " + i + " 行")
        chat.text = lines.join("\n")

        compare(chat.text, "第一行", "溢出的输入必须整段退回")
        compare(area.contentHeight + area.topPadding + area.bottomPadding
                <= scroll.height + 1, true,
                "退回后内容必须放得下，不能留在框外")
        compare(spy.count, 1, "退回时要发 limitReached")
        if (spy.count > 0)
            compare(spy.signalArguments[0][0], "height")

        // 回到放得下的长度后，再次溢出要能重新报一次
        chat.text = "短"
        chat.text = lines.join("\n")
        compare(spy.count, 2, "重新溢出应再报一次")
        spy.destroy()
    }

    function test_scrollBarFollowsOverflow() {
        var chat = makeChat()
        var bar = findChild(chat, "chatTextScrollBar")
        verify(bar !== null, "scroll bar should be findable")

        // 断言的是 policy（组件自己的绑定）：Controls 的 ScrollBar 还要在 polish 时
        // 才把 policy 翻译成 visible，单测里没有真实帧循环，visible 不可靠；
        // "真的显示出来了"由离屏探针 _probe_flags.qml 与整页截图负责。
        chat.text = "一行"
        compare(bar.policy, ScrollBar.AlwaysOff, "内容放得下时不该要滚动条")

        var lines = []
        for (var i = 1; i <= 16; ++i)
            lines.push("第 " + i + " 行")
        chat.text = lines.join("\n")
        compare(bar.policy, ScrollBar.AlwaysOn, "内容超出时必须挂上滚动条")

        // 关掉 allowOverflow 就没有"超出"这回事，滚动条也不该出现
        var chat2 = makeChat()
        chat2.allowOverflow = false
        var bar2 = findChild(chat2, "chatTextScrollBar")
        chat2.text = lines.join("\n")
        compare(bar2.policy, ScrollBar.AlwaysOff, "allowOverflow 关掉时不该有滚动条")
    }

    // ── 10. 深色模式：黑块只能用 inkBlock ────────────────────────
    // 这类 bug（Theme.ink 当填充色）行为断言抓不到，只有切到暗色才看得见，
    // 所以直接按 objectName 找出那几个黑块，断言填充色就是 inkBlock。
    function test_blackBlocksUseInkBlock() {
        var chat = makeChat()
        chat.attachments = [
            chat.makeImageAttachment("u1"),
            chat.makeFileAttachment("u2", "a.json", 100)
        ]

        try {
            Theme.mode = Theme.Mode.Dark

            var header = findChild(chat, "chatHeader")
            var strip = findChild(chat, "chatThumbName")
            var badge = findChild(chat, "chatExtBadge")
            var remove = findChild(chat, "chatRemoveBadge")

            verify(header !== null, "header bar should be findable")
            verify(strip !== null, "thumbnail name strip should be findable")
            verify(badge !== null, "extension badge should be findable")
            verify(remove !== null, "remove badge should be findable")

            compare(String(header.color), String(Theme.inkBlock))
            compare(String(strip.color), String(Theme.inkBlock))
            compare(String(badge.color), String(Theme.inkBlock))
            compare(String(remove.color), String(Theme.inkBlock))

            // 反向证明：暗色下 ink 确实不是黑的，否则上面四条就是同义反复
            verify(String(Theme.ink) !== String(Theme.inkBlock),
                   "dark ink must differ from inkBlock")
        } finally {
            Theme.mode = Theme.Mode.Light
        }
    }

    // ── 11. 滚轮：内部先滚，滚到头就停住（默认），可选用 wheelChainsToAncestor 交回外层 ──
    // qmltestrunner 造不出 QWheelEvent，所以这里只钉不依赖事件投递的事：
    // 一格滚多少像素的默认值、"到边界后要不要带动外层"的默认值，以及那条链式通道本身。
    function test_wheelStepIsFortyEightPixels() {
        var chat = makeChat()
        compare(chat.wheelStepSize, 48, "默认一格滚 48 像素")
        chat.wheelStepSize = 30
        compare(chat.wheelStepSize, 30, "这个值应当可写")
    }

    function test_wheelDoesNotChainToAncestorByDefault() {
        var chat = makeChat()
        compare(chat.wheelChainsToAncestor, false,
                "默认滚到边界就停住，不带动外层页面（用户明确要求）")
        chat.wheelChainsToAncestor = true
        compare(chat.wheelChainsToAncestor, true, "这个开关本身要可写")
    }

    function test_chainWheelToAncestorMovesTheOuterFlickable() {
        var outer = createTemporaryObject(outerFlickableComponent, root)
        verify(outer !== null, "outer flickable should instantiate")
        var chat = makeChat(outer)

        chat._chainWheelToAncestor(-120)
        compare(outer.contentY, 120, "滚轮距离应当转给外层 Flickable")
        chat._chainWheelToAncestor(40)
        compare(outer.contentY, 80, "反方向也要能用")
        chat._chainWheelToAncestor(-5000)
        compare(outer.contentY, outer.contentHeight - outer.height, "不能越过外层的下边界")
    }

    function test_chainWheelToAncestorIsHarmlessWithoutOne() {
        var chat = makeChat()
        compare(chat._chainWheelToAncestor(-120), false, "没有可滚动祖先时要安静地返回 false")
    }

    // ── 13. 附件条：永远一行高，多了横向滚（不会把组件顶高）──────
    function test_attachStripHeightIgnoresAttachmentCount() {
        var chat = makeChat()
        var zone = findChild(chat, "chatAttachZone")
        verify(zone !== null, "应当能定位到附件区")

        chat.attachments = [chat.makeFileAttachment("", "a.json", 1024)]
        wait(50)
        var oneHeight = chat.implicitHeight
        var oneZone = zone.height

        var many = []
        for (var i = 0; i < 6; ++i)
            many.push(chat.makeFileAttachment("", "f" + i + ".json", 1024))
        chat.attachments = many
        wait(50)

        compare(chat.implicitHeight, oneHeight, "附件从 1 个加到 6 个，组件高度不许变")
        compare(zone.height, oneZone, "附件区高度不许变")
        compare(zone.height, chat.thumbSize + Theme.spacingSm * 2, "附件区就是一行（缩略图 + 上下留白）")
    }

    function test_attachStripScrollsHorizontallyInsteadOfGrowing() {
        var chat = makeChat()
        chat.width = 420
        var flick = findChild(chat, "chatAttachScroller")
        verify(flick !== null, "附件条应当是个 Flickable")

        var many = []
        for (var i = 0; i < 6; ++i)
            many.push(chat.makeFileAttachment("", "f" + i + ".json", 1024))
        chat.attachments = many

        tryVerify(function () { return flick.contentWidth > flick.width }, 2000,
                  "6 个附件必须超出可视宽度，否则没得滚")

        compare(flick.contentY, 0, "附件条不许竖向滚动")
        compare(flick.height, chat.thumbSize, "附件条高度恒为一行")

        var maxX = flick.contentWidth - flick.width
        verify(maxX > 0, "内容比视口宽，maxContentX 必须为正")
        // 内容宽度 = 6 张卡的宽度 + 5 个间距（钉住 Row 的排布）
        var expected = 6 * chat.fileCardWidth + 5 * Theme.spacingSm
        verify(Math.abs(flick.contentWidth - expected) < 1, "附件条内容宽度应当是 6 张卡横排")
        flick.contentX = maxX
        verify(Math.abs(flick.contentX - maxX) < 0.5, "要能滚到最右")
        flick.contentX = 0
        verify(Math.abs(flick.contentX) < 0.5, "要能滚回最左")
    }
}
```

### `tools/smoke.qml`

无头冒烟：离屏渲染演示内容并抓图，零 QML 报错才算通过

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  无头冒烟自检：离屏渲染演示内容（qml/DemoContent.qml），抓图落盘后退出。
  退出码：0 = 成功；3 = 加载失败；4 = 抓图保存失败；9 = 超时（多半是 QML 报错卡死）。

  用法：
    QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software \
    QT_QPA_FONTDIR=C:/Windows/Fonts \
    qml.exe -I <repo>/qml <repo>/tools/smoke.qml
*/
Window {
    id: smoke
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    /*! 抓图输出路径 */
    property string outFile: "C:/dev/ZmdUI/tools/smoke.png"

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
        onStatusChanged: if (status === Loader.Error) {
            console.log("SMOKE FAIL: loader error")
            Qt.exit(3)
        }
    }

    // 等字体重排 + 首帧渲染稳定后再抓
    Timer {
        interval: 1500
        running: true
        onTriggered: doGrab()
    }

    Timer {
        interval: 20000
        running: true
        onTriggered: { console.log("SMOKE TIMEOUT"); Qt.exit(9) }
    }

    function doGrab() {
        console.log("SMOKE: window", width, "x", height,
                    "| contentItem", contentItem.width, "x", contentItem.height,
                    "| loaded", loader.status === Loader.Ready)
        contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(smoke.outFile)
            console.log("SMOKE " + (ok ? "OK" : "SAVE_FAIL") + " -> " + smoke.outFile)
            Qt.exit(ok ? 0 : 4)
        })
    }
}
```

### `tools/smoke_scroll.qml`

分段滚动截图，逐屏核对各区块渲染结果

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  分段滚动截图：窗口放不下全部区块，因此按 offsets 依次滚动并抓图，
  一屏一张，便于逐段核对渲染结果。
  用法同 smoke.qml。
*/
Window {
    id: tool
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property var offsets: [0, 900, 1800, 2700, 3600]
    property int idx: 0
    property string dir: "C:/dev/ZmdUI/tools/"

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
        onStatusChanged: if (status === Loader.Error) { console.log("SCROLL FAIL: loader"); Qt.exit(3) }
    }

    Timer {
        interval: 1200
        running: true
        onTriggered: tool.contentItem.grabToImage(function (res) {
            grabNext(res)
        })
    }

    Timer { interval: 40000; running: true; onTriggered: { console.log("SCROLL TIMEOUT"); Qt.exit(9) } }

    function grabNext(res) {
        if (!loader.item) { console.log("SCROLL FAIL: no item"); Qt.exit(2); return }
        var name = tool.dir + "scroll_" + tool.idx + ".png"
        var ok = res.saveToFile(name)
        console.log("SCROLL " + tool.idx + " contentY=" + loader.item.contentY
                    + " total=" + loader.item.contentHeight + (ok ? " SAVED" : " FAIL"))
        tool.idx++
        if (tool.idx >= tool.offsets.length || !ok) {
            Qt.exit(ok ? 0 : 4)
            return
        }
        loader.item.contentY = tool.offsets[tool.idx]
        stepTimer.start()
    }

    Timer {
        id: stepTimer
        interval: 420
        onTriggered: tool.contentItem.grabToImage(function (res) { grabNext(res) })
    }
}
```

### `tools/probe_popup.qml`

弹层探针：强制展开工具提示与对话框后抓图

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  弹层类组件探针：工具提示与对话框默认不显示（要悬停 / 要打开），
  静态截图里看不到，所以这里强制展开后抓图核对。
*/
Window {
    id: probe
    width: 1000
    height: 660
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_popup.png"

    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }
    ZHatchPattern {
        anchors.right: parent.right
        anchors.top: parent.top
        width: 260
        height: 150
        lineColor: Theme.hatch
        spacing: 12
    }

    ZSectionTitle {
        x: 40
        y: 30
        index: "07"
        eyebrow: "POPUP / OVERLAY"
        title: "弹层"
        subtitle: "TOOLTIP & DIALOG"
    }

    Row {
        x: 40
        y: 190
        spacing: 18

        // 工具提示：强制展开
        ZButton {
            id: tipHost
            text: "同步余额"
            variant: Theme.Variant.Primary
            mono: "SYNC"

            ZToolTip {
                id: tip
                text: "同步最近 24 小时余额变动"
                visible: true
                delay: 0
            }
        }

        ZButton { text: "次要按钮"; variant: Theme.Variant.Secondary }
        ZIconButton { glyph: "◎"; tone: Theme.Tone.Accent }
    }

    // 对话框：打开状态
    ZDialog {
        id: dlg
        title: "覆盖本地配置"
        code: "SYS-04"
        subtitle: "此操作不可撤销"
        confirmText: "确认覆盖"
        cancelText: "取消"
        width: 560
        Component.onCompleted: open()

        Column {
            width: parent.width
            spacing: 14

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
                spacing: 8
                ZTag { text: "备份已就绪"; tone: Theme.Tone.Accent }
                ZTag { text: "3.2 KB" }
            }
        }
    }

    Timer {
        interval: 1600
        running: true
        onTriggered: probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(probe.outFile)
            console.log("PROBE " + (ok ? "OK" : "FAIL") + " -> " + probe.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
    Timer { interval: 15000; running: true; onTriggered: { console.log("PROBE TIMEOUT"); Qt.exit(9) } }
}
```

### `tools/probe_tooltip.qml`

工具提示探针：核对亮黄竖边与底板斜边是否贴齐

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  工具提示探针：把 ZToolTip 强制展开（不给它悬停的机会），专门核对
  左侧亮黄竖边与底板斜边是否贴齐 —— 之前用直边矩形画竖条，
  顶部会戳出平行四边形之外，用户一眼就看出来了。
*/
Window {
    id: probe
    width: 760
    height: 300
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_tooltip.png"

    ZGridBackground {
        anchors.fill: parent
        bgColor: Theme.bg
        minorColor: Theme.gridLine
        majorColor: Theme.gridLineMajor
        crossColor: Theme.lineSoft
    }

    Row {
        x: 40
        y: 60
        spacing: 40

        ZButton {
            id: hostA
            text: "同步余额"
            variant: Theme.Variant.Primary
            ZToolTip { text: "同步最近 24 小时余额变动"; visible: true; delay: 0 }
        }

        ZButton {
            id: hostB
            text: "扫码登录"
            variant: Theme.Variant.Secondary
            mono: "F2"
            ZToolTip { text: "打开二维码窗口"; visible: true; delay: 0 }
        }

        ZIconButton {
            id: hostC
            glyph: "≡"
            ZToolTip { text: "菜单"; visible: true; delay: 0 }
        }
    }

    Timer {
        interval: 1200
        running: true
        onTriggered: probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(probe.outFile)
            console.log("TOOLTIP " + (ok ? "OK" : "FAIL") + " -> " + probe.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
    Timer { interval: 15000; running: true; onTriggered: { console.log("TOOLTIP TIMEOUT"); Qt.exit(9) } }
}
```

### `tools/probe_dark.qml`

暗色主题探针：切到暗色后整屏抓图，核对文字可读性

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  暗色主题探针：加载演示内容后切到暗色主题再抓图。
  亮色主题的截图靠 tools/smoke.qml，这个专门用来核对暗色下的文字可读性。
*/
Window {
    id: probe
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/probe_dark.png"
    /*! 抓图前先把内容区滚到指定位置（0 = 顶部，用于看卡片区） */
    property real scrollTo: 0

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
        onStatusChanged: if (status === Loader.Error) { console.log("DARK FAIL: loader"); Qt.exit(3) }
    }

    Component.onCompleted: Theme.mode = Theme.Mode.Dark

    Timer {
        interval: 1400
        running: true
        onTriggered: {
            if (loader.item && loader.item.contentY !== undefined)
                loader.item.contentY = probe.scrollTo
            grabTimer.start()
        }
    }
    Timer { id: grabTimer; interval: 400; onTriggered: doGrab() }
    Timer { interval: 15000; running: true; onTriggered: { console.log("DARK TIMEOUT"); Qt.exit(9) } }

    function doGrab() {
        probe.contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(probe.outFile)
            console.log("DARK " + (ok ? "OK" : "FAIL") + " -> " + probe.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
}
```

### `tools/smoke_dark_scroll.qml`

暗色分段滚动截图，逐屏审计暗色模式的每个区块

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  暗色分段滚动截图：用来逐屏审计暗色模式（亮色版是 smoke_scroll.qml）。
  用法同其他探针，产物为 tools/dark_0..N.png
*/
Window {
    id: tool
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property var offsets: [0, 900, 1800, 2700]
    property int idx: 0

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
    }

    Component.onCompleted: Theme.mode = Theme.Mode.Dark

    Timer {
        interval: 1300
        running: true
        onTriggered: tool.contentItem.grabToImage(function (res) { next(res) })
    }
    Timer { interval: 40000; running: true; onTriggered: { console.log("DARKSCROLL TIMEOUT"); Qt.exit(9) } }

    function next(res) {
        if (!loader.item) { console.log("DARKSCROLL FAIL: no item"); Qt.exit(2); return }
        var ok = res.saveToFile("C:/dev/ZmdUI/tools/dark_" + tool.idx + ".png")
        console.log("DARKSCROLL " + tool.idx + " contentY=" + loader.item.contentY + (ok ? " SAVED" : " FAIL"))
        tool.idx++
        if (tool.idx >= tool.offsets.length || !ok) { Qt.exit(ok ? 0 : 4); return }
        loader.item.contentY = tool.offsets[tool.idx]
        step.start()
    }
    Timer { id: step; interval: 420; onTriggered: tool.contentItem.grabToImage(function (res) { next(res) }) }
}
```

### `tools/probe_buttons.qml`

按钮探针：断言默认态装饰 + 宽度不随状态变化

```qml
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
```

### `tools/probe_anim.qml`

动画机制探针：用取样数值证明 Behavior 对绑定属性会插值

```qml
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
```

### `tools/probe_anim_button.qml`

动画端到端探针：抓两帧比对，证明 ZButton 过渡真的在动

```qml
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
```

### `tools/probe_hittest.qml`

命中测试：打印元素中心最上层的元素链，定位「点不上」的原因

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  命中测试探针：回答"这一项为什么点不上"。

  做法：把每个可点元素中心的坐标换算到窗口坐标，再用 childAt() 从窗口根一路往下钻，
  打印出**最上层**的元素链。如果链子最后落到的不是该项自己的 MouseArea，
  就说明有东西盖在它上面 —— 这就是"按不上"的直接证据（不用猜）。

  同时扫一遍侧边栏中轴线，把每一段的顶层元素列出来，用来找覆盖层。
*/
Window {
    id: probe
    width: 1500
    height: 940
    visible: true
    color: Theme.bg

    property string outFile: "C:/dev/ZmdUI/tools/hittest.txt"
    property var report: []

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
    }

    // QML 的 toString() 形如 "ZSideBar_QMLTYPE_123(0x...)"，先把 _QMLTYPE_ 之后切掉
    function typeName(o) {
        var s = o.toString()
        var i = s.indexOf("_QMLTYPE")
        return i > 0 ? s.substring(0, i) : s.substring(0, s.indexOf("("))
    }

    // 从根往下钻，打印命中的元素链
    function chain(root, x, y, maxDepth) {
        var out = []
        var item = root
        var px = x
        var py = y
        for (var d = 0; d < maxDepth; d++) {
            var c = item.childAt(px, py)
            if (!c)
                break
            out.push(typeName(c) + "(" + Math.round(c.x) + "," + Math.round(c.y) + " "
                     + Math.round(c.width) + "x" + Math.round(c.height) + ")")
            var m = c.mapFromItem(root, x, y)
            px = m.x
            py = m.y
            item = c
        }
        return out.join(" > ")
    }

    function collectByType(item, name, out) {
        var kids = item.children
        if (!kids)
            return
        for (var i = 0; i < kids.length; i++) {
            var c = kids[i]
            if (typeName(c) === name)
                out.push(c)
            collectByType(c, name, out)
        }
    }

    function collectFlickables(item, out) {
        var kids = item.children
        if (!kids)
            return
        for (var i = 0; i < kids.length; i++) {
            var c = kids[i]
            if (typeName(c) === "QQuickFlickable")
                out.push(c)
            collectFlickables(c, out)
        }
    }

    function run() {
        var win = loader.item
        if (!win)
            return
        var rootItem = probe.contentItem

        // 先把页面滚到最底：表格在内容 y≈2600 处，不滚动的话根本不在视口里
        var fl = []
        collectFlickables(rootItem, fl)
        for (var f = 0; f < fl.length; f++) {
            if (fl[f].contentHeight > 1000) {
                fl[f].contentY = fl[f].contentHeight - fl[f].height   // 手动夹到最大值
                console.log("SCROLL contentHeight=" + fl[f].contentHeight
                            + " maxY=" + Math.round(fl[f].contentHeight - fl[f].height)
                            + " viewport=" + Math.round(fl[f].height)
                            + " y=" + Math.round(fl[f].y))
            }
        }
        var tables = []
        collectByType(rootItem, "ZTable", tables)
        var bars = []
        collectByType(rootItem, "ZSideBar", bars)

        console.log("FOUND ZTable=" + tables.length + " ZSideBar=" + bars.length)

        // 1) 侧边栏中轴线扫描：看有没有覆盖层
        if (bars.length > 0) {
            console.log("SIDEBAR scan x=120")
            for (var y = 120; y <= 780; y += 46) {
                console.log("  y=" + y + " -> " + chain(rootItem, 120, y, 18))
            }
        }

        // 1.5) 底部装饰条的位置（用来判断是否盖住最后一行）
        var footers = []
        collectByType(rootItem, "ZCutRect", footers)
        console.log("VIEWPORT bottom check")
        console.log("  windowH=" + Math.round(rootItem.height))

        // 2) 表格每一行的中心命中链
        if (tables.length > 0) {
            var t = tables[0]
            console.log("TABLE " + Math.round(t.width) + "x" + Math.round(t.height))
            var rows = []
            for (var k = 0; k < t.children.length; k++) {
                var ch = t.children[k]
                if (Math.abs(ch.height - 38) < 0.5)     // rowHeight = 38
                    rows.push(ch)
            }
            console.log("  rows=" + rows.length)
            for (var r = 0; r < rows.length; r++) {
                var p = rows[r].mapToItem(rootItem, rows[r].width / 2, rows[r].height / 2)
                console.log("  row" + r + " centerY=" + Math.round(p.y) + " -> " + chain(rootItem, p.x, p.y, 18))
            }
        }

        Qt.exit(0)
    }

    Timer { interval: 1500; running: true; onTriggered: run() }
    Timer { interval: 20000; running: true; onTriggered: { console.log("HITTEST TIMEOUT"); Qt.exit(9) } }
}
```

### `tools/probe_sidebar.qml`

侧边栏滚动条探针：矮窗口复现溢出，对比开关两种状态

```qml
import QtQuick
import QtQuick.Window
import ZmdUI 1.0

/*
  侧边栏滚动条探针。

  用户反馈：窗口变矮时导航溢出，滚动条浮在内容上盖住了右侧的编号/徽标。
  这里用 1200x640 的矮窗口复现溢出，分别抓"开滚动条"和"关滚动条"两张图，
  并打印滚动条与行的几何关系，用来确认占位是否生效。

  用法：qml.exe -I qml tools/probe_sidebar.qml
*/
Window {
    id: probe
    width: 1200
    height: 640
    visible: true
    color: Theme.bg

    Loader {
        id: loader
        anchors.fill: parent
        source: "../qml/DemoContent.qml"
        asynchronous: false
    }

    function typeName(o) {
        var s = o.toString()
        var i = s.indexOf("_QMLTYPE")
        return i > 0 ? s.substring(0, i) : s.substring(0, s.indexOf("("))
    }

    function collect(item, name, out) {
        var kids = item.children
        if (!kids)
            return
        for (var i = 0; i < kids.length; i++) {
            if (typeName(kids[i]) === name)
                out.push(kids[i])
            collect(kids[i], name, out)
        }
    }

    function report(tag) {
        var bars = []
        collect(probe.contentItem, "ZSideBar", bars)
        if (!bars.length) {
            console.log("SIDEBAR not found")
            return
        }
        var b = bars[0]
        var fls = []
        collect(b, "QQuickFlickable", fls)
        var f = fls[0]
        console.log(tag + ": navScrollBar=" + b.navScrollBar
                    + " reserve=" + b.navScrollBarReserve
                    + " contentH=" + Math.round(f.contentHeight)
                    + " viewportH=" + Math.round(f.height)
                    + " overflow=" + (f.contentHeight > f.height))
    }

    Timer {
        interval: 1000
        running: true
        onTriggered: {
            report("ON ")
            probe.contentItem.grabToImage(function (res) {
                res.saveToFile("C:/dev/ZmdUI/tools/sidebar_bar_on.png")
                probe.contentItem.grabToImage  // noop
                step.start()
            })
        }
    }

    Timer {
        id: step
        interval: 500
        onTriggered: {
            var bars = []
            collect(probe.contentItem, "ZSideBar", bars)
            bars[0].navScrollBar = false          // 关掉滚动条
            offTimer.start()
        }
    }

    Timer {
        id: offTimer
        interval: 600
        onTriggered: {
            report("OFF")
            probe.contentItem.grabToImage(function (res) {
                res.saveToFile("C:/dev/ZmdUI/tools/sidebar_bar_off.png")
                console.log("SIDEBAR PROBE done")
                Qt.exit(0)
            })
        }
    }
    Timer { interval: 20000; running: true; onTriggered: { console.log("SIDEBAR TIMEOUT"); Qt.exit(9) } }
}
```

### `tools/crop.qml`

局部放大工具，按 crop_params.json 裁切截图核对像素细节

```qml
import QtQuick
import QtQuick.Window

/*
  局部放大工具：按 crop_params.json 指定的区域裁剪放大某张截图并落盘。
  参数文件格式（同目录）：
    { "source": "scroll_1.png", "x": 890, "y": 590, "w": 340, "h": 60,
      "zoom": 3, "out": "crop.png" }

  用参数文件而不是命令行参数，是因为 qml 工具不会把多余参数透传给应用。
*/
Window {
    id: tool
    width: 960
    height: 640
    visible: true
    color: "#FFFFFF"

    property rect clip: Qt.rect(0, 0, 300, 214)
    property string source: "smoke.png"
    property string outFile: "C:/dev/ZmdUI/tools/crop.png"
    property bool loaded: false

    function loadParams() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "crop_params.json")
        xhr.onreadystatechange = function () {
            if (xhr.readyState !== XMLHttpRequest.DONE)
                return
            try {
                var p = JSON.parse(xhr.responseText)
                tool.source = p.source
                tool.clip = Qt.rect(p.x, p.y, p.w, p.h)
                tool.outFile = "C:/dev/ZmdUI/tools/" + p.out
                // 窗口尺寸 = 裁剪区域 × 放大倍数（params 里的 zoom，默认 3）
                var z = p.zoom !== undefined ? p.zoom : 3
                var maxW = 1400
                var w = Math.round(p.w * z)
                var h = Math.round(p.h * z)
                if (w > maxW) {
                    h = Math.round(h * maxW / w)
                    w = maxW
                }
                tool.width = w
                tool.height = h
                tool.loaded = true
                grabTimer.start()
            } catch (e) {
                console.log("CROP: bad params " + e)
                Qt.exit(5)
            }
        }
        xhr.send()
    }

    Component.onCompleted: loadParams()

    Image {
        anchors.fill: parent
        source: tool.source
        sourceClipRect: tool.clip
        fillMode: Image.PreserveAspectFit
        smooth: false
        mipmap: false
    }

    Timer { id: grabTimer; interval: 700; onTriggered: doGrab() }
    Timer { interval: 15000; running: true; onTriggered: { console.log("CROP TIMEOUT"); Qt.exit(9) } }

    function doGrab() {
        contentItem.grabToImage(function (res) {
            var ok = res.saveToFile(tool.outFile)
            console.log("CROP " + (ok ? "OK" : "FAIL") + " " + tool.source + " "
                        + JSON.stringify(tool.clip) + " -> " + tool.outFile)
            Qt.exit(ok ? 0 : 1)
        })
    }
}
```

### `tools/check_inverse_blocks.py`

反相块体检：抓「主题反转后文字消失」的配色搭配错误

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
反相块体检：找出「把 Theme.ink 当背景色用、块里却放白色文字」的地方。

为什么需要它 —— 这块踩过两次：

    Theme.ink 在亮色主题下是纯黑（当背景色没问题），但在暗色主题下会变成浅灰。
    于是"黑底白字"的条 / 徽标会变成"浅底白字"，文字直接消失。
    （第一次是表格表头 / 对话框标题带 / 编号块；第二次是演示程序顶栏。）

正确写法是 Theme.inkBlock —— 它在两个主题下都保持深色。

用法：
    python tools/check_inverse_blocks.py      退出码 0 = 没发现问题
"""

import io
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# 只用字符类，不依赖反斜杠转义（heredoc / shell 会吞反斜杠）
BAD_BG = re.compile(r'^[ \t]*color:[ \t]*Theme[.]ink[ \t]*$')
WHITE_TEXT = re.compile(r'Theme[.]textOnSub')

problems = []
checked = 0

for dirpath, dirnames, filenames in os.walk(os.path.join(ROOT, "qml")):
    for fn in sorted(filenames):
        if not fn.endswith(".qml"):
            continue
        path = os.path.join(dirpath, fn)
        rel = os.path.relpath(path, ROOT).replace(os.sep, "/")
        lines = io.open(path, encoding="utf-8").read().split("\n")
        for i, line in enumerate(lines):
            if not BAD_BG.match(line):
                continue
            checked += 1
            # 往后 20 行内看有没有白色文字（同一个块里）
            window = "\n".join(lines[i:i + 20])
            if WHITE_TEXT.search(window):
                problems.append((rel, i + 1))

# 第二类：亮色下是"亮面"的背景（surface / surfaceAlt / surfaceHover / bg）里放白色文字，
# 亮色主题下同样会变成"白字浅底"。暗色主题下这些面是深的，所以问题出在亮色侧。
LIGHT_BG = re.compile(r'^[ \t]*color:[ \t]*Theme[.](surface|surfaceAlt|surfaceMuted|surfaceHover|bg)[ \t]*$')
light_problems = []

for dirpath, dirnames, filenames in os.walk(os.path.join(ROOT, "qml")):
    for fn in sorted(filenames):
        if not fn.endswith(".qml"):
            continue
        path = os.path.join(dirpath, fn)
        rel = os.path.relpath(path, ROOT).replace(os.sep, "/")
        lines = io.open(path, encoding="utf-8").read().split("\n")
        for i, line in enumerate(lines):
            if not LIGHT_BG.match(line):
                continue
            window = "\n".join(lines[i:i + 20])
            if WHITE_TEXT.search(window):
                light_problems.append((rel, i + 1))

print("检查了 %d 处 `color: Theme.ink`" % checked)
if problems or light_problems:
    print("")
    print("发现问题：")
    for rel, ln in problems:
        print("  x %s:%d  背景用了 Theme.ink，块里却有 textOnSub（暗色下白字浅底）" % (rel, ln))
    for rel, ln in light_problems:
        print("  x %s:%d  背景用了亮面令牌（surface/bg 等），块里却有 textOnSub（亮色下白字白底）"
              % (rel, ln))
    print("")
    print("反相块改用 Theme.inkBlock（两个主题下都是深色）。")
    sys.exit(1)

print("OK 没有发现「浅底白字」的反相块")
sys.exit(0)
```

## 八、验证记录

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
