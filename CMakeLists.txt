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
