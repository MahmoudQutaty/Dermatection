import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class UserMessage extends StatelessWidget {
  final String text;

  UserMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration:  BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26.0),
                  bottomRight: Radius.circular(26.0),
                  bottomLeft: Radius.circular(26.0),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(text,
                    style: const TextStyle(
                      color: kBackgroundColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}