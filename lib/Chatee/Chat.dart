import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:likh_bee/GetStarted/Finishing.dart';
import 'package:likh_bee/Usefull/Avatars.dart';
import 'package:likh_bee/Usefull/Buttons.dart';
import 'package:likh_bee/Usefull/Colors.dart';
import 'package:likh_bee/Usefull/Functions.dart';

class chat extends StatefulWidget {
  Map data;

  chat({Key? key,required this.data}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isHide = false;
  final fieldText = TextEditingController();
  List<Widget> sendButton = [];
  String msg = "";
  int _sendIndex = 0;
  bool _showSend = false;

  final ScrollController _scrollController = ScrollController();

  String chatID = "";

  String id_one = "";
  String id_two = "";

  Map<dynamic, dynamic> chatData = {};
  List<Widget> allChats = [];
  List<String> chatIds = [];


  @override
  void initState() {
    getChatId();
  }

  getChatId() async {
    var x = widget.data['uid'].toString();
    var userId = user!.uid;
    List l = [x, userId];
    l.sort();
    var p = l[0];
    var q = l[1];
    id_one = p;
    id_two = q;
    setState(() {
      chatID = "$p&$q";
    });

    final ref = await FirebaseDatabase.instance.ref('chats').child(chatID);
    await ref.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        if (data != null) {
          chatData = data;

          List a = chatData.keys.toList()..sort();

          print(chatData);
          // for(var x in chatData.keys) {
          for (var x in a) {
            print("batman $x");
            Future.delayed(Duration(seconds: 1), () {
              scroolDown();
            });
            var sender = x.toString().split("&")[1].toString();
            String mainMsg = chatData[x]['msg'];
            var item = chatbox(id: sender, msg: mainMsg);
            if (!chatIds.contains(x)) {
              setState(() {
                allChats.add(item);
                chatIds.add(x);
              });
            }
          }
        }
      } else {
        toaster('null');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          color: transparent_overlay,
          margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
          child: Row(
            children: [
              Flexible(
                  child: TextFormField(
                    controller: fieldText,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: darkblue,
                      fontSize: 13.0,
                      fontFamily: 'pop'
                    ),
                    decoration: InputDecoration(
                      fillColor: lightColor,
                      filled: true,
                      hintText: "Message",
                      labelStyle: TextStyle(
                        color: lightText,
                        fontFamily: 'pop',
                        fontSize: 13.0,
                      ),
                      errorStyle: TextStyle(
                        color: errorColor,
                        fontFamily: 'pop',
                        fontSize: 15.0,
                      ),

                      disabledBorder: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (text) {
                      msg = text;
                      if (text.isNotEmpty) {
                        setState(() {
                          _sendIndex = 1;
                          _showSend = true;
                        });
                      } else {
                        setState(() {
                          _sendIndex = 0;
                          _showSend = false;
                        });
                      }
                    },
                  )
              ),
              SizedBox(width: 2.0,),
              Visibility(
                visible: _showSend,
                child: FloatingActionButton(onPressed: (){
                  Send();
                },
                  backgroundColor: yellowColor,
                  child: Icon(Icons.send,color: mainColor,),),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 100,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.close,color: mainColor,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              circleAvatar(index: widget.data['index'], radius: 20.0),
            ],
          ),
          title: mainText(widget.data['name'], darktext, 15.0, FontWeight.normal,1),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 70.0),
              child: Column(
                children: allChats,
              ),
            ),
            loaderss(isHide, context)
          ],
        ),
      ),
    );
  }
  Send() async {
    var id = user!.uid;
    String dates = DateTime.now().toIso8601String().split(".")[0].toString();
    String disId = dates + "&" + id;
    String datekey = DateTime.now().toString();
    var sendMsg = {
      disId: {
        'msg': msg,
        'date': datekey,
      }
    };

    var lastmsg = {
      'dt': {
        'id_one': id_one,
        'id_two': id_two,
        "lastmsg": msg,
        "date": DateTime.now().toString()
      }
    };
    final ref = FirebaseDatabase.instance.reference();
    ref.child('chats').child(chatID).update(sendMsg).then((value) => {
      setState(() {
        fieldText.clear();
        scroolDown();
        ref.child('chats').child(chatID).update(lastmsg);
      })
    });
  }

  scroolDown() async {
    await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

}


class chatbox extends StatefulWidget {
  String id;
  String msg;

  chatbox({Key? key, required this.id, required this.msg}) : super(key: key);

  @override
  State<chatbox> createState() => _chatboxState();
}

class _chatboxState extends State<chatbox> {
  User? user = FirebaseAuth.instance.currentUser;
  Color boxColor = mainColor;
  bool isUser = false;
  MainAxisAlignment alignment = MainAxisAlignment.start;
  double topleft = 0.0;
  double topright = 7.0;

  @override
  void initState() {
    var x = user!.uid;
    if (x == widget.id) {
      setState(() {
        boxColor = yellowColor;
        isUser = true;
        alignment = MainAxisAlignment.end;
        topright = 0.0;
        topleft = 7.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent_overlay,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: alignment,
        children: [
          // Visibility(
          //     visible: isUser,
          //     child: SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.30,
          // )),

          GestureDetector(
            child: Container(
              constraints: BoxConstraints(
                  minWidth: 20,
                  maxWidth: MediaQuery.of(context).size.width * 0.68),
              color: transparent_overlay,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topleft),
                    topRight: Radius.circular(topright),
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),

                  ),
                ),
                color: boxColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
                  child: mainTextFAQS(
                      widget.msg, Colors.white, 15.0, FontWeight.normal, 100),
                ),
              ),
            ),
          ),
          // Visibility(
          //     visible: !isUser,
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.30,
          //     )),
        ],
      ),
    );
  }
}
