import 'package:flutter/material.dart';

class ChatbotMessage extends StatelessWidget {
  final String text;

  ChatbotMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26.0),
                  topRight: Radius.circular(26.0),
                  bottomRight: Radius.circular(26.0),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(text),
              ),
            ),

          ],
        ),
      ),
    );
  }
}