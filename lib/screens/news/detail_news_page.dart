import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailNewsPage extends StatefulWidget {
  final String url;
  final String title;
  DetailNewsPage({this.url, this.title});

  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  InAppWebViewController webView;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.abel(),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5.0,
              child: progress < 1.0
                  ? Container(
                      color: Colors.amber,
                      width: progress * MediaQuery.of(context).size.width,
                    )
                  : Container(
                      width: double.maxFinite,
                      color: Theme.of(context).appBarTheme.color,
                    ),
            ),
            Expanded(
              child: InAppWebView(
                initialUrl: widget.url,
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
