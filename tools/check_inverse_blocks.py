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
