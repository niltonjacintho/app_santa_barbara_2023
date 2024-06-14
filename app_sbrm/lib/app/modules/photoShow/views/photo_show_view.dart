import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/photo_show_controller.dart';

class PhotoShowView extends GetView<PhotoShowController> {
  const PhotoShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(avisoRepository.avisoAtual.conteudo!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoShowView'),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
