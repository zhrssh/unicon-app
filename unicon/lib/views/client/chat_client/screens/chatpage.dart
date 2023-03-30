import 'package:flutter/material.dart';
import '../../client_navigation_routes.dart';
import '../models/chat_users.dart';
import '../widgets/conversationlist.dart';

class ClientChatPage extends StatefulWidget {
  final String token;
  const ClientChatPage({super.key, required this.token});

  @override
  State<ClientChatPage> createState() => _ClientChatPageState();
}

class _ClientChatPageState extends State<ClientChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      name: "Juan Dela Cruz",
      messageText: "Yes, sure!",
      imageURL:
          "https://i.pinimg.com/originals/8a/63/04/8a6304985aa67c8133bf8881256d31be.jpg",
      time: "04:20 PM",
    ),
    ChatUsers(
        name: "Jay Sonza",
        messageText: "Is the Job still available?",
        imageURL: "",
        time: "06:32 PM"),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Inbox"),
      //   titleTextStyle: const TextStyle(
      //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      //   backgroundColor: Colors.white,
      //   leading: const BackButton(
      //     color: Colors.black,
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height * .075,
            ),
            SizedBox(
              child: Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      navigateToClientHome(context, widget.token);
                      // Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Inbox",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      height: 20,
                    ))
          ],
        ),
      ),
    );
  }
}
