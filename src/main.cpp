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
