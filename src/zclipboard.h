// ZmdUI —— 剪贴板桥（演示程序用，不是组件库的一部分）
//
// 为什么需要它：
//   QML 里没有任何办法读到剪贴板里的**位图**。TextEdit.canPaste 在剪贴板装的是
//   图片时直接是 false，paste() 也什么都拿不到；Qt 的 QML 模块里也没有 Clipboard
//   类型（搜过 mingw_64/qml，Qt.labs.platform 只有 labsplatformplugin.dll）。
//   所以"Ctrl+V 粘图片"必须由宿主语言代劳。
//
// 用法（见 main.cpp）：
//   ZClipboard clipboard;
//   engine.rootContext()->setContextProperty("ZClipboard", &clipboard);
//
//   QML 侧：ZChatInput.onPasteRequested 里调 ZClipboard.saveImage() 拿到 file:// URL。
//
// 注意：用 context property 而不是 QML 单例，是为了让纯 `qml.exe` 跑测试时
// 完全不需要这个对象（QML 侧用 typeof ZClipboard !== "undefined" 守卫）。

#pragma once

#include <QObject>
#include <QString>

class ZClipboard : public QObject
{
    Q_OBJECT

public:
    explicit ZClipboard(QObject *parent = nullptr);

    /*! 剪贴板里有没有位图。 */
    Q_INVOKABLE bool hasImage() const;

    /*! 剪贴板里有没有文件（资源管理器里 Ctrl+C 复制文件时是有的）。 */
    Q_INVOKABLE bool hasUrls() const;

    /*!
        把剪贴板里的位图存成临时文件，返回 `file:///…` URL；没有位图返回空串。

        \a preferredExtension 决定落盘格式（png / jpg / bmp，默认 png）。
        每次调用都生成**新文件**：上一次的图可能还被界面上的 Image 用着，
        覆盖掉会出现"粘贴后上一张变破图"。
    */
    Q_INVOKABLE QString saveImage(const QString &preferredExtension = QStringLiteral("png")) const;
};
