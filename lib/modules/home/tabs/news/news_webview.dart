import 'package:crypto_flutter/modules/home/tabs/news/news_controller.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends GetView<NewsController> {
  final String url;

  NewsWebView({Key? key, required this.url}) : super(key: key);

  late WebViewController webViewController;

  final double h = SizeConfig().screenWidth;

  @override
  Widget build(BuildContext context) {
   // EasyLoading.show();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 0.1 * h,
      ),
      body: Stack(children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          // onWebViewCreated: (controller) {},
          onPageFinished: (finish) {
            //EasyLoading.dismiss();
          },
        ),
      ]),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.import_export,
      //     size: 32,
      //   ),
      //   onPressed: () {

      //   },
      // ),
    );
  }
}
