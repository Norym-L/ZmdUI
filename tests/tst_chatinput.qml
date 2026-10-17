import QtQuick
import QtTest
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

    function makeChat() {
        var chat = createTemporaryObject(chatComponent, root)
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
        chat.minTextHeight = 60
        chat.maxTextHeight = 90
        wait(50)
        var h0 = chat.implicitHeight
        chat.text = "很长的内容 ".repeat(200)
        wait(50)
        verify(chat.implicitHeight >= h0, "adding lines grows the composer")
        verify(chat.implicitHeight <= h0 + 400, "growth is bounded by maxTextHeight")
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
}
