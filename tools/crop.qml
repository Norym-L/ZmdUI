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
