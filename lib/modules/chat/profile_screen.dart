import 'package:dermatechtion/modules/chat/models/app.dart';
import 'package:dermatechtion/modules/chat/widgets/avatar.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../registration/who_i_am.dart';

class ProfileScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
    builder: (context) => const ProfileScreen(),
  );
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Hero(
              tag: 'hero_profile-picture',
              child: Avatar.large(url: user?.image,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user?.name?? 'No name'),
            ),
            const Divider(),
            const _SignOutButton(),
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({
    Key? key,
}) : super(key: key);

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;


  @override
  Widget build(BuildContext context) {

    Future<void> _signOut() async{
      setState(() {
        _loading = true;
      });

      try{
        await StreamChatCore.of(context).client.disconnectUser();

        //Navigator.of(context).push(SelectUserScreen.route);
      } on Exception catch (e, st) {
        logger.e('Could not sign out', e, st);
        setState(() {
          _loading = false;
        });
      }
    }


    return _loading
    ? const CircularProgressIndicator()
    : TextButton(
        onPressed: ()=>{
          _signOut,
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WhoIAm(),
        ),(
        route) => false
        )
        },
        child: const Text('Sign out'));
  }
}
