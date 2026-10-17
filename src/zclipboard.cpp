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
