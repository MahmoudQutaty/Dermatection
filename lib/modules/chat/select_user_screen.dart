/*import 'package:dermatechtion/modules/chat/models/demo_users.dart';
import 'package:dermatechtion/modules/chat/widgets/avatar.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'home_screen.dart';
import 'models/app.dart';

class SelectUserScreen extends StatefulWidget {
  static Route get route=> MaterialPageRoute(
      builder: (context) => const SelectUserScreen(),
  );
  const SelectUserScreen({Key? key}) : super(key: key);
  @override
  _SelectUserScreenState createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    Future<void> onUserSelected(DemoUser user) async {
      setState(() {
        _loading = true;
      });

      try{
        final client = StreamChatCore.of(context).client;
        await client.connectUser(
          User(
              id: user.id,
              extraData: {
                'name': user.name,
                'image': user.image
              }),
          client.devToken(user.id).rawValue,
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> ChatHomeScreen())
        );
      } on Exception catch (e ,st){
        logger.e('Could not connect user', e, st);
        setState(() {
          _loading = false;
        });
      }
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: (_loading)
        ? const CircularProgressIndicator()
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'Choose An Account',
                  style: TextStyle(fontSize: 24, letterSpacing: 0.4),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return SelectUserButton(
                      user: users[index],
                      onPressed: onUserSelected,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectUserButton extends StatelessWidget {
  const SelectUserButton({
    Key? key,
    required this.user,
    required this.onPressed,
}) : super (key: key);
  final DemoUser user;
  final Function(DemoUser user) onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => onPressed(user),
        child: Row(
          children: [
            Avatar.large(url: user.image,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.name,
                style: const TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }

}
*/