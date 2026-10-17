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

    \section1 为什么输入区会"长高"而不是一开始就带滚动条

    高度在 \l minTextHeight 与 \l maxTextHeight 之间跟着 \c contentHeight 走：
    一两行时没有滚动条，写长消息超过上限后由 \c TextEdit 内部滚动，光标始终可见。
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

    /*! 空输入时的占位提示 */
    property string placeholderText: "输入消息，Enter 发送，Shift+Enter 换行…"

    /*! 发送按钮文字 */
    property string sendText: "发送"

    /*! 附件区留空时要显示的一行提示（空串则不显示） */
    property string attachHintText: "可粘贴图片、拖动文件到此处"

    /*! 输入区最小高度（一行文字的呼吸感） */
    property int minTextHeight: 74

    /*! 输入区最大高度，超过后输入区内部滚动 */
    property int maxTextHeight: 140

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
            width: parent.width
            height: composer.showHeader ? 30 : 0
            visible: composer.showHeader
            color: Theme.ink
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
        Item {
            id: attachZone
            width: parent.width
            height: composer.attachmentCount > 0 ? attachFlow.height + Theme.spacingSm * 2
                 : (composer.attachHintText.length > 0 ? 26 : 0)
            visible: height > 0

            Flow {
                id: attachFlow
                x: Theme.spacingMd
                y: Theme.spacingSm
                width: parent.width - Theme.spacingMd * 2
                spacing: Theme.spacingSm
                visible: composer.attachmentCount > 0

                Repeater {
                    model: composer.attachments

                    delegate: Loader {
                        id: attachLoader

                        required property int index
                        required property var modelData

                        // 委托里的两个 Component 声明在文件级作用域，看不到 attachLoader 这个 id，
                        // 但它们靠上下文直接读 modelData / index —— 这两个是 Repeater 委托的上下文属性，
                        // sourceComponent 造出来的项会继承它。
                        sourceComponent: modelData && modelData.type === "image" ? imageThumb : fileCard
                    }
                }
            }

            Text {
                anchors.left: parent.left
                anchors.leftMargin: Theme.spacingMd
                anchors.verticalCenter: parent.verticalCenter
                visible: composer.attachmentCount === 0
                text: composer.attachHintText
                font: Theme.fontMonoSm
                color: Theme.muted
            }
        }

        // ── 输入区 ────────────────────────────────────────────────
        Item {
            id: textWrap
            width: parent.width
            height: area.height

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
                visible: area.text.length === 0 && !composer.readOnly
                elide: Text.ElideRight
            }

            TextArea {
                id: area

                width: parent.width
                height: Math.max(composer.minTextHeight,
                                 Math.min(contentHeight + topPadding + bottomPadding,
                                          composer.maxTextHeight))

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
                color: Theme.ink
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
                width: 40
                // 描边有宽度，徽标要收在描边内侧，否则黑块会盖过卡片边框
                y: Theme.border
                height: parent.height - Theme.border * 2
                color: Theme.ink
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
            color: Theme.ink
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
