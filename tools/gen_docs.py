#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
生成 docs/ZmdUI_组件库文档.md —— 把仓库里每个源文件的完整内容汇成一份 Markdown。

为什么要脚本化：源码才是唯一事实来源，手抄一份文档必然会和代码漂移。
改完代码执行一次本脚本，文档即同步：

    python tools/gen_docs.py
"""

import io
import os
import time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "docs", "ZmdUI_组件库文档.md")

# 章节 -> [(相对路径, 一句话说明, 代码块语言)]
CHAPTERS = [
    ("一、主题与基础图元", [
        ("qml/ZmdUI/Theme.qml", "全局主题单例：配色 / 字体 / 尺寸 / 动画，一键切换亮暗主题", "qml"),
        ("qml/ZmdUI/ZCutRect.qml", "斜切角矩形图元，整套设计语言的地基", "qml"),
        ("qml/ZmdUI/ZSkewRect.qml", "平行四边形图元（副标题块、标签、高亮块）", "qml"),
        ("qml/ZmdUI/ZHatchPattern.qml", "斜线纹理 / 斜线阴影，Canvas 绘制", "qml"),
        ("qml/ZmdUI/ZGridBackground.qml", "工程网格背景（细网格 + 主刻度 + 十字星）", "qml"),
    ]),
    ("二、交互控件", [
        ("qml/ZmdUI/ZButton.qml", "按钮：主要 / 次要 / 危险 / 幽灵 / 平行四边形", "qml"),
        ("qml/ZmdUI/ZIconButton.qml", "方形图标按钮，自带工具提示", "qml"),
        ("qml/ZmdUI/ZTextField.qml", "输入框：黑硬边 + 聚焦亮黄底线 + 内嵌铭牌", "qml"),
        ("qml/ZmdUI/ZCheckBox.qml", "复选框：切角方框 + 黑色对勾 + 半选态", "qml"),
        ("qml/ZmdUI/ZRadioButton.qml", "单选按钮：菱形指示灯", "qml"),
        ("qml/ZmdUI/ZSwitch.qml", "开关：矩形滑轨 + 方形滑块 + 轨道刻度", "qml"),
        ("qml/ZmdUI/ZSlider.qml", "滑块：黑色导轨 + 亮黄填充 + 刻度 + 切角把手", "qml"),
        ("qml/ZmdUI/ZProgressBar.qml", "进度条：亮黄填充 + 刻度 + 循环扫描不确定态", "qml"),
        ("qml/ZmdUI/ZRichTextEditor.qml", "块级富文本编辑器：文字 / 图片 / 文件块混排，块级格式 + 序列化", "qml"),
        ("qml/ZmdUI/ZChatInput.qml", "QQ 式消息输入框：正文 + 图片 / 文件附件，内置系统文件选择框，拖放与粘贴自动转附件，回车发送", "qml"),
    ]),
    ("三、容器与展示", [
        ("qml/ZmdUI/ZPanel.qml", "面板 / 卡片：斜切角 + 角落斜线纹理 + 亮黄装饰底边", "qml"),
        ("qml/ZmdUI/ZSectionTitle.qml", "区块大标题：编号 + 「超粗标题」 + 黑底斜切副标题", "qml"),
        ("qml/ZmdUI/ZTag.qml", "标签 / 徽章：平行四边形，深灰底白字或亮黄底黑字", "qml"),
        ("qml/ZmdUI/ZStatusDot.qml", "状态点：极小面积的切角方块（点缀色专用）", "qml"),
        ("qml/ZmdUI/ZListItem.qml", "列表项：选中 = 亮黄底 + 黑色斜切高亮块", "qml"),
        ("qml/ZmdUI/ZListView.qml", "列表视图：切角外框 + 自带滚动条 + 默认委托", "qml"),
        ("qml/ZmdUI/ZScrollBar.qml", "滚动条：细长切角方块 + 导轨刻度", "qml"),
        ("qml/ZmdUI/ZToolTip.qml", "工具提示：深灰底白字 + 左侧亮黄竖边", "qml"),
    ]),
    ("四、复合组件", [
        ("qml/ZmdUI/ZDialog.qml", "对话框：顶部黑底黄字 + 中央大面积斜线纹理", "qml"),
        ("qml/ZmdUI/ZSideBar.qml", "侧边导航栏：黑底白字，当前项亮黄底 + 亮黄左边缘", "qml"),
        ("qml/ZmdUI/ZTable.qml", "数据表格：黑底表头 + 工程网格线 + 选中行亮黄", "qml"),
        ("qml/ZmdUI/ZLineChart.qml", "折线图：网格 + 亮黄数据线 + 黑色方形数据点", "qml"),
    ]),
    ("五、演示应用", [
        ("qml/main.qml", "演示程序入口（窗口壳）", "qml"),
        ("qml/DemoContent.qml", "演示内容：网格背景 + 侧边栏 + 八大区块，覆盖全部组件", "qml"),
    ]),
    ("六、工程集成", [
        ("qml/ZmdUI/qmldir", "QML 模块清单，声明模块 URI 与单例", "text"),
        ("resources/qml.qrc", "Qt 资源系统清单，资源路径与磁盘结构一致", "xml"),
        ("src/main.cpp", "应用入口：Basic 样式 + 高 DPI + 资源导入路径 + 剪贴板桥注入", "cpp"),
        ("src/zclipboard.cpp", "剪贴板桥：把剪贴板位图存成临时文件（QML 读不到位图）", "cpp"),
        ("CMakeLists.txt", "CMake 构建脚本：跨平台 + MSVC/MinGW 双编译器 + 一键部署", "cmake"),
        (".gitignore", "忽略各编译器的构建目录与部署产物", "text"),
    ]),
    ("七、自动化验证工具", [
        ("tests/tst_hover.qml", "qmltestrunner 行为测试：规则 / 属性 / 几何断言（9 项）", "qml"),
        ("tests/tst_richtext.qml", "qmltestrunner 行为测试：富文本块模型 / 序列化 / 结构操作（38 项）", "qml"),
        ("tests/tst_chatinput.qml", "qmltestrunner 行为测试：附件模型 / 上限 / canSend / 发送快照 / 回车语义 / 拖放粘贴 / 选择框（57 项）", "qml"),
        ("tools/smoke.qml", "无头冒烟：离屏渲染演示内容并抓图，零 QML 报错才算通过", "qml"),
        ("tools/smoke_scroll.qml", "分段滚动截图，逐屏核对各区块渲染结果", "qml"),
        ("tools/probe_popup.qml", "弹层探针：强制展开工具提示与对话框后抓图", "qml"),
        ("tools/probe_tooltip.qml", "工具提示探针：核对亮黄竖边与底板斜边是否贴齐", "qml"),
        ("tools/probe_dark.qml", "暗色主题探针：切到暗色后整屏抓图，核对文字可读性", "qml"),
        ("tools/smoke_dark_scroll.qml", "暗色分段滚动截图，逐屏审计暗色模式的每个区块", "qml"),
        ("tools/probe_buttons.qml", "按钮探针：断言默认态装饰 + 宽度不随状态变化", "qml"),
        ("tools/probe_anim.qml", "动画机制探针：用取样数值证明 Behavior 对绑定属性会插值", "qml"),
        ("tools/probe_anim_button.qml", "动画端到端探针：抓两帧比对，证明 ZButton 过渡真的在动", "qml"),
        ("tools/probe_hittest.qml", "命中测试：打印元素中心最上层的元素链，定位「点不上」的原因", "qml"),
        ("tools/probe_sidebar.qml", "侧边栏滚动条探针：矮窗口复现溢出，对比开关两种状态", "qml"),
        ("tools/crop.qml", "局部放大工具，按 crop_params.json 裁切截图核对像素细节", "qml"),
        ("tools/check_inverse_blocks.py", "反相块体检：抓「主题反转后文字消失」的配色搭配错误", "python"),
    ]),
]


def read(rel):
    with io.open(os.path.join(ROOT, rel), encoding="utf-8") as f:
        return f.read().rstrip("\n")


def tree():
    """生成目录树（跳过隐藏目录与二进制）。"""
    lines = []

    def walk(path, prefix):
        entries = sorted(os.listdir(path))
        dirs = [e for e in entries if os.path.isdir(os.path.join(path, e)) and not e.startswith(".")]
        files = [e for e in entries if os.path.isfile(os.path.join(path, e))
                 and not e.startswith(".") and not e.endswith(".png")]
        items = [(d, True) for d in dirs] + [(f, False) for f in files]
        for i, (name, is_dir) in enumerate(items):
            last = i == len(items) - 1
            lines.append(prefix + ("└── " if last else "├── ") + name + ("/" if is_dir else ""))
            if is_dir:
                walk(os.path.join(path, name), prefix + ("    " if last else "│   "))

    lines.append("ZmdUI/")
    walk(ROOT, "")
    return "\n".join(lines)


def main():
    out = []
    out.append("# ZmdUI · 终末地工业机能风 QML 组件库 —— 完整源码集\n")
    out.append("> 本文由 `tools/gen_docs.py` 从仓库源码自动汇总生成，内容与磁盘上的文件逐字一致。\n")
    out.append("> 生成时间：%s\n" % time.strftime("%Y-%m-%d %H:%M:%S"))
    out.append("| 项目 | 说明 |")
    out.append("| --- | --- |")
    out.append("| Qt 版本 | 6.5+（开发验证于 6.11.2 / MSVC 2022 x64） |")
    out.append("| 模块 URI | `ZmdUI 1.0` |")
    out.append("| 组件数量 | 27 个类型（1 主题单例 + 4 图元 + 22 控件） |")
    out.append("| 依赖 | 仅 QtQuick / QtQuick.Controls.Basic / QtQuick.Shapes，无第三方库 |")
    out.append("| 图片资源 | 0 张（网格、斜线、斜切、图标全部走 Shape / Canvas 绘制） |")
    out.append("")

    # 目录
    out.append("## 目录\n")
    out.append("- [零、项目目录结构](#零项目目录结构)")
    for title, files in CHAPTERS:
        anchor = title.replace("、", "").replace(" ", "").lower()
        out.append("- [%s](#%s)" % (title, anchor))
        for rel, desc, _ in files:
            out.append("  - [`%s`](#%s) — %s" % (rel, rel.lower().replace("/", "").replace(".", "")
                                                  .replace("_", "").replace("-", ""), desc))
    out.append("- [八、验证记录](#八验证记录)")
    out.append("")

    # 目录结构
    out.append("## 零、项目目录结构\n")
    out.append("```text")
    out.append(tree())
    out.append("```\n")
    out.append("设计上分三层：**主题层**（`Theme.qml` 单例）→ **图元层**（4 个 Shape/Canvas 图元）"
               "→ **组件层**（22 个控件）。组件只从主题取值、只用图元绘制，"
               "因此换主题不用改组件，换视觉不用改业务。\n")

    # 各章节源码
    for title, files in CHAPTERS:
        out.append("## %s\n" % title)
        for rel, desc, lang in files:
            out.append("### `%s`\n" % rel)
            out.append("%s\n" % desc)
            out.append("```%s" % lang)
            out.append(read(rel))
            out.append("```\n")

    # 验证记录
    out.append("## 八、验证记录\n")
    out.append(read("docs/verification.md") if os.path.exists(os.path.join(ROOT, "docs/verification.md"))
               else "（见 README 的「验证」一节）")
    out.append("")

    with io.open(OUT, "w", encoding="utf-8") as f:
        f.write("\n".join(out))
    print("已生成 %s（%.1f KB）" % (OUT, os.path.getsize(OUT) / 1024.0))


if __name__ == "__main__":
    main()
