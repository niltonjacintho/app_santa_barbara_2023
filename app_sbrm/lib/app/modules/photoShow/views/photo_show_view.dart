import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/photo_show_controller.dart';

class PhotoShowView extends GetView<PhotoShowController> {
  const PhotoShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
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
          onPageFinished: (String url) {
            isLoading = false;
          },
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
          title: const Text('Album de fotos'),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              GoRouter.of(context).go('/photos');
            },
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Stack(),
          ],
        ));
  }
}
