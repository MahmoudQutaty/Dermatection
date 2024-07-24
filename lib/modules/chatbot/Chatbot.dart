import 'dart:convert';

import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controllers/provider/chatbot.dart';
import 'chatbot_message.dart';
import 'input_field.dart';
import 'user_message.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DermaTection Assistant",style: TextStyle(color: kTextColor),),backgroundColor: kBackgroundColor,elevation:0.0,
        leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios),color: kTextColor,),

      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                controller: ChatbotController.scrollController,
                itemCount: _messages.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if(index == _messages.length)
                    {
                      return Container(
                        height: 150,
                      );
                    }
                  Message message = _messages[index];
                  return message.isUser
                      ? UserMessage(message.text)
                      : ChatbotMessage(message.text);
                },
              ),
            ),

          ),
          InputField(onSubmit: _sendMessage),
        ],
      ),
    );
  }
  Future<Map<String, dynamic>> _sendMessage(String message) async {
    setState(() {
      _messages.add(Message(message, true));
    });

    String url = 'http://192.168.43.168:4000/chat';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'Keep-Alive',
    };
    Map<String, dynamic> data = {'message': message};
    String body = json.encode(data);
    http.Response response = await http.post(Uri.parse(url), headers: headers, body: body);
    var messageResponse = json.decode(response.body);

    setState(() {
      _messages.add(Message(messageResponse['response'], false));
    });

    return json.decode(response.body);
  }

}




class Message {
  final String text;
  final bool isUser;

  Message(this.text, this.isUser);
}
