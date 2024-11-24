import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const WebViewApp());

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  String url = '';
  @override
  void initState() {
    super.initState();
    url = 'https://house-of-ham.tistory.com/';
  }

  void onPressPathBtn(String newUrl) {
    setState(() {
      url = newUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('안드로이드 웹뷰 테스트'),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewScreen(
                url: url,
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          onPressPathBtn("https://github.com/goeunleee"),
                      icon: const FaIcon(FontAwesomeIcons.github),
                    ),
                    IconButton(
                      onPressed: () =>
                          onPressPathBtn('https://house-of-ham.tistory.com/'),
                      icon: const FaIcon(
                        FontAwesomeIcons.blog,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  String url;
  WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is AndroidWebViewController) {
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  void didUpdateWidget(WebViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.url != oldWidget.url) {
      _controller.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
