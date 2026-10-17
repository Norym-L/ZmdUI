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
