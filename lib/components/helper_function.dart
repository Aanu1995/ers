import 'package:flutter/material.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperFunction {
  static launchURL({String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'error';
    }
  }

  static void showSnackBar(final globalKey, final content) {
    globalKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }

  static displayProgressDialog(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (
            BuildContext context,
            _,
            __,
          ) {
            return ProgressDialog();
          }),
    );
  }

  static closeProgressDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static showSuccessDialog({BuildContext context}) {
    final textTheme = Theme.of(context).textTheme;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Feedback",
            style: textTheme.title.copyWith(
              color: ColorUtils.primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text(
            "Thank you we would be in touch shortly. Till then, stay safe.",
            textAlign: TextAlign.justify,
            style: textTheme.subhead.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OKAY',
                style: TextStyle(
                  fontSize: 15.0,
                  color: ColorUtils.primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(200),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Please wait....",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
