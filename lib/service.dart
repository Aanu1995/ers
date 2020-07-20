import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:ers/components/export_components.dart';
import 'package:ers/model/chat_model.dart';
import 'package:ers/screens/chat_page.dart';
import 'package:ers/utils/global_data_utils.dart';
import 'package:ers/utils/helper_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServcice {
  static void goToChat({BuildContext context, GlobalKey globalKey}) async {
    String userId;
    HelperFunction.displayProgressDialog(context);
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        // this function takes user to the chat
        SharedPreferences _preferences = await SharedPreferences.getInstance();
        // gets the userId from the local storage
        userId = _preferences.getString(GlobalDataUtils.userId);
        // checks if the userId is null
        if (userId == null) {
          // this generate a string of length 64
          String genUserId = HelperUtils.createRandomString();
          // sets the userId in the local storage
          await _preferences.setString(GlobalDataUtils.userId, genUserId);
          // gets the userId from the local storage
          userId = _preferences.getString(GlobalDataUtils.userId);
          Firestore.instance
              .collection(GlobalDataUtils.chat)
              .document(userId)
              .setData({
            'name': 'Anonymous',
            'userId': userId,
            'time': Timestamp.now(),
          });
        }
      } else {
        HelperFunction.closeProgressDialog(context);
        HelperFunction.showSnackBar(globalKey, "No Internet Connection");
        return;
      }
      HelperFunction.closeProgressDialog(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userId: userId,
          ),
        ),
      );
    } catch (e) {
      print(e);
      HelperFunction.closeProgressDialog(context);
      HelperFunction.showSnackBar(
          globalKey, "Error Encountered. Please try again");
    }
  }

  static Future<bool> sendMessage({String message, String userId}) async {
    if (message.isNotEmpty) {
      Firestore.instance
          .collection(GlobalDataUtils.chat)
          .document(userId)
          .collection(GlobalDataUtils.virus)
          .document()
          .setData(ChatModel.toMap(message: message));
      return true;
    }
    return false;
  }
}
