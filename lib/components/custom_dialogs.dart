import 'package:flutter/material.dart';

class CustomDialogs {
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
                    Theme.of(context).primaryColor,
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
