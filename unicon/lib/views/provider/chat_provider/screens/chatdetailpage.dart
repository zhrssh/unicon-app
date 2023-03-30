import 'package:flutter/material.dart';

import '../models/chatmessagemodel.dart';

class ProviderChatDetailPage extends StatefulWidget {
  const ProviderChatDetailPage({super.key});

  @override
  State<ProviderChatDetailPage> createState() => _ProviderChatDetailPageState();
}

class _ProviderChatDetailPageState extends State<ProviderChatDetailPage> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, may I apply?", messageType: "sender"),
    ChatMessage(messageContent: "Yes, sure!", messageType: "receiver"),
    ChatMessage(
        messageContent: "What do you want to know?", messageType: "receiver"),
    ChatMessage(
        messageContent:
            "Do you still need materials for the wall repainting task of the project?",
        messageType: "sender"),
    ChatMessage(
        messageContent: "Yes, we're almost out of paint.",
        messageType: "receiver"),
    ChatMessage(
        messageContent:
            "Noted! I'll purchase later and then deliver it on the site.",
        messageType: "sender"),
  ];
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut);
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/originals/8a/63/04/8a6304985aa67c8133bf8881256d31be.jpg"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Juan Dela Cruz",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: const <Widget>[
                          Text(
                            "Task: ",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            "Wall Repainting",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.call),
                    color: Colors.black54,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : const Color.fromARGB(255, 84, 122, 70)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(
                            color: messages[index].messageType == "receiver"
                                ? Colors.black
                                : Colors.white,
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 90,
              width: double.infinity,
              color: const Color.fromARGB(255, 84, 122, 70),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: IconButton(
                      icon: const Icon(Icons.file_upload_outlined),
                      onPressed: () {},
                      iconSize: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: const TextStyle(color: Colors.black54),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
