import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ers/components/message_inputbox.dart';
import 'package:ers/model/chat_model.dart';
import 'package:ers/utils/global_data_utils.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  ChatPage({this.userId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _controller = ScrollController();
  String text;
  bool lastSeen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: GoogleFonts.abel(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection(GlobalDataUtils.chat)
                    .document(widget.userId)
                    .collection(GlobalDataUtils.virus)
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  // this sets the values to default when the list rebuilds
                  //lastSeen = false;
                  //text = null;
                  if (snapshot.hasError) {
                    return Container();
                  } else if (snapshot.hasData) {
                    List<ChatModel> list = ChatModel.fromQuerySnapshot(
                        querySnapshot: snapshot.data);
                    return ListView(
                      controller: _controller,
                      padding: EdgeInsets.only(bottom: 16.0),
                      reverse: true,
                      children: <Widget>[
                        for (int index = 0; index < list.length; index++)
                          ChatBox(
                            message: list[index].message,
                            time: list[index].time,
                            isUser: list[index].isUser,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            MyTextField(userId: widget.userId),
          ],
        ),
      ),
    );
  }
/* 
  bool aDayAgo(int index, List list) {
    int day = DateTime.now().difference(list[index].dateTime).inDays;
    if (day >= 1 && day < 2) {
      return true;
    } else {
      return false;
    }
  }

  bool toDay(int index, List list) {
    int hours = DateTime.now().difference(list[index].dateTime).inHours;
    if (hours < 24) {
      return true;
    } else {
      return false;
    }
  }

  String formatMyDate(int index, List list) {
    int day = DateTime.now().difference(list[index].dateTime).inDays;
    if (day >= 2) {
      var format = DateFormat.yMMMMd('en_US');
      var correctDate = format.format(list[index].dateTime);
      return correctDate;
    } else {
      return null;
    }
  }

  structureMyDate(int index, List list) {
    lastSeen = false;
    String anyDate = formatMyDate(index, list);
    if (text != anyDate && anyDate != null) {
      text = anyDate;
      lastSeen = true;
    } else if (aDayAgo(index, list) && text != "Yesterday") {
      text = "Yesterday";
      lastSeen = true;
    } else if (toDay(index, list) && text != "Today") {
      text = "Today";
      lastSeen = true;
    }
  } */
}

class ChatBox extends StatelessWidget {
  final String message;
  final String time;
  final bool isUser;
  const ChatBox({this.message, this.time, this.isUser});
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(
          top: 12, left: isUser ? 50.0 : 0.0, right: isUser ? 0.0 : 50.0),
      padding: BubbleEdges.all(8.0),
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      nip: isUser ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: isUser ? Color.fromRGBO(225, 255, 199, 1.0) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 15.5),
          ),
          SizedBox(height: 5.0),
          Text(
            time,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
