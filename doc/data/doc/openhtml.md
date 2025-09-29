在 Flutter 中打开 web 根目录下的 HTML 文件有几种方法，具体取决于你的使用场景：
1. 使用 url_launcher 打开外部 HTML 文件
安装依赖
<YAML>
dependencies:
url_launcher: ^6.2.1
示例代码
<DART>
import 'package:url_launcher/url_launcher.dart';

// 打开本地 HTML 文件
Future<void> openLocalHtml() async {
// 假设 HTML 文件在 web 目录下
final Uri url = Uri.parse('/your_file.html');

if (await canLaunchUrl(url)) {
await launchUrl(
url,
webOnlyWindowName: '_blank', // 在新标签页打开
);
}
}

// 或者使用相对路径
Future<void> openHtmlFile() async {
final Uri url = Uri.parse('assets/html/index.html');
await launchUrl(url);
}
2. 使用 webview_flutter 在应用内显示
安装依赖
<YAML>
dependencies:
webview_flutter: ^4.4.2
webview_flutter_web: ^0.2.2+3
示例代码
<DART>
import 'package:webview_flutter/webview_flutter.dart';

class HtmlViewer extends StatefulWidget {
@override
_HtmlViewerState createState() => _HtmlViewerState();
}

class _HtmlViewerState extends State<HtmlViewer> {
late final WebViewController controller;

@override
void initState() {
super.initState();
controller = WebViewController()
..setJavaScriptMode(JavaScriptMode.unrestricted)
..loadRequest(Uri.parse('/path/to/your.html'));
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('HTML Viewer')),
body: WebViewWidget(controller: controller),
);
}
}
3. 将 HTML 文件放在 assets 中并加载
配置 pubspec.yaml
<YAML>
flutter:
assets:
- assets/html/
加载 assets 中的 HTML
<DART>
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalHtmlViewer extends StatefulWidget {
@override
_LocalHtmlViewerState createState() => _LocalHtmlViewerState();
}

class _LocalHtmlViewerState extends State<LocalHtmlViewer> {
late final WebViewController controller;

@override
void initState() {
super.initState();
_loadHtmlFromAssets();
}

Future<void> _loadHtmlFromAssets() async {
String fileHtmlContents = await rootBundle.loadString(
'assets/html/index.html'
);

controller = WebViewController()
..setJavaScriptMode(JavaScriptMode.unrestricted)
..loadHtmlString(fileHtmlContents);
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: WebViewWidget(controller: controller),
);
}
}
4. Flutter Web 特定方案 - 使用 IFrameElement
<DART>
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HtmlElementView extends StatefulWidget {
@override
_HtmlElementViewState createState() => _HtmlElementViewState();
}

class _HtmlElementViewState extends State<HtmlElementView> {
@override
void initState() {
super.initState();

// 注册一个平台视图
ui.platformViewRegistry.registerViewFactory(
'html-view',
(int viewId) => html.IFrameElement()
..src = '/your_file.html'
..style.border = 'none',
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: HtmlElementView(
viewType: 'html-view',
),
);
}
}
5. 直接导航到 HTML 文件（仅 Flutter Web）
<DART>
import 'dart:html' as html;

void openHtmlInSameTab() {
html.window.location.href = '/your_file.html';
}

void openHtmlInNewTab() {
html.window.open('/your_file.html', '_blank');
}
注意事项
文件位置：确保 HTML 文件放在正确的位置：
Flutter Web: 放在 web/ 目录下 Assets: 放在项目根目录的 assets/ 文件夹中
路径问题：
使用相对路径时，注意当前路由的影响 建议使用绝对路径或完整的 URL
跨平台兼容：
dart:html 只能在 Web 平台使用 webview_flutter 支持多平台
选择哪种方法取决于你的具体需求：
如果只需要打开链接，使用 url_launcher 如果需要在应用内嵌入显示，使用 webview_flutter 如果是 Flutter Web 专用，可以使用 dart:html