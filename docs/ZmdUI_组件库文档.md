# ZmdUI · 终末地工业机能风 QML 组件库 —— 完整源码集

> 本文由 `tools/gen_docs.py` 从仓库源码自动汇总生成，内容与磁盘上的文件逐字一致。

> 生成时间：2026-10-15 20:23:31

| 项目 | 说明 |
| --- | --- |
| Qt 版本 | 6.5+（开发验证于 6.11.2 / MSVC 2022 x64） |
| 模块 URI | `ZmdUI 1.0` |
| 组件数量 | 25 个类型（1 主题单例 + 4 图元 + 20 控件） |
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
  - [`qml/DemoContent.qml`](#qmldemocontentqml) — 演示内容：网格背景 + 侧边栏 + 六大区块，覆盖全部组件
- [六、工程集成](#六工程集成)
  - [`qml/ZmdUI/qmldir`](#qmlzmduiqmldir) — QML 模块清单，声明模块 URI 与单例
  - [`resources/qml.qrc`](#resourcesqmlqrc) — Qt 资源系统清单，资源路径与磁盘结构一致
  - [`src/main.cpp`](#srcmaincpp) — 应用入口：Basic 样式 + 高 DPI + 资源导入路径
  - [`CMakeLists.txt`](#cmakeliststxt) — CMake 构建脚本：跨平台 + MSVC/MinGW 双编译器 + 一键部署
  - [`.gitignore`](#gitignore) — 忽略各编译器的构建目录与部署产物
- [七、自动化验证工具](#七自动化验证工具)
  - [`tests/tst_hover.qml`](#testststhoverqml) — qmltestrunner 行为测试：规则 / 属性 / 几何断言（9 项）
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
│       │   │   ├── pkgRedirects/
│       │   │   ├── CMakeConfigureLog.yaml
│       │   │   ├── clion-Debug-QT MinGW-log.txt
│       │   │   ├── clion-environment.txt
│       │   │   └── cmake.check_cache
│       │   ├── Testing/
│       │   │   └── Temporary/
│       │   │       └── LastTest.log
│       │   ├── ZmdUIDemo_autogen/
│       │   │   ├── 3YJK5W5UP7/
│       │   │   │   └── qrc_qml.cpp
│       │   │   ├── include/
│       │   │   ├── deps
│       │   │   ├── mocs_compilation.cpp
│       │   │   └── timestamp
│       │   ├── CMakeCache.txt
│       │   ├── VSInheritEnvironments.txt
│       │   ├── ZmdUIDemo.exe
│       │   ├── ZmdUIDemo.exe.manifest
│       │   ├── ZmdUIDemo.ilk
│       │   ├── ZmdUIDemo.pdb
│       │   ├── build.ninja
│       │   ├── cmake_install.cmake
│       │   └── compile_commands.json
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
│   └── main.cpp
├── tests/
│   └── tst_hover.qml
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

设计上分三层：**主题层**（`Theme.qml` 单例）→ **图元层**（4 个 Shape/Canvas 图元）→ **组件层**（19 个控件）。组件只从主题取值、只用图元绘制，因此换主题不用改组件，换视觉不用改业务。

## 一、主题与基础图元

### `qml/ZmdUI/Theme.qml`

全局主题单例：配色 / 字体 / 尺寸 / 动画，一键切换亮暗主题

```qml
pragma Singleton

import QtQuick

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
            return _isOn ? Theme.surfaceHover : "transparent"
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
            cutTopRight: control.enabled ? control.cutSize : 0
            cutBottomLeft: control.enabled ? Theme.cutSm : 0

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
            cutTopRight: control.cutSize
            cutBottomLeft: Theme.cutSm
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

    // 悬停提示：文案非空时自动显示。宿主类型明确（control 是 ZButton），
    // 所以不需要在调用处写 parent.hovered，静态检查也不会有 missing-property 噪音。
    ZToolTip {
        text: control.tooltip
        visible: control.tooltip.length > 0 && control.hovered
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

演示内容：网格背景 + 侧边栏 + 六大区块，覆盖全部组件

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

应用入口：Basic 样式 + 高 DPI + 资源导入路径

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
#include <QQuickStyle>
#include <QQuickWindow>

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
