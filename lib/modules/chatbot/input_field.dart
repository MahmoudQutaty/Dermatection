import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../controllers/provider/chatbot.dart';
import '../chat/widgets/glowing_action_button.dart';
import 'Chatbot.dart';

class InputField extends StatefulWidget {
  final Function(String) onSubmit;

  InputField({required this.onSubmit});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final inputFieldController = TextEditingController();

  void clearText()
  {
    inputFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    String _text = "";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                controller: inputFieldController,
                style: TextStyle(fontSize: 16),
                onChanged: (value) => _text = value,
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),

          GlowingActionButton(color: kSecondaryColor, onPressed: (){
            ChatbotController.scrollController.animateTo(ChatbotController.scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            widget.onSubmit(_text);
            clearText();
          }, icon: Icons.send,),
        ],
      ),
    );
  }
}