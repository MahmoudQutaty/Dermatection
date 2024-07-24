import 'package:dermatechtion/modules/chat/chat_screen.dart';
import 'package:dermatechtion/modules/chat/pages/messages_page.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../controllers/provider/auth.dart';
import '../../chat/home_screen.dart';
import '../../chat/models/app.dart';
import '../../chat/models/demo_users.dart';
import '../../chat/profile_screen.dart';
import '../../chat/widgets/avatar.dart';
import '../../chat/widgets/glowing_action_button.dart';
import '../../chatbot/Chatbot.dart';
import 'tabs/home/home.dart';
import 'tabs/mails.dart';
import 'tabs/me.dart';
import 'tabs/schedule.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final List<Widget> _tabs =  [const Home(), const MessagesPage(), const Mails(), ProfileScreen()];




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:_selectedIndex !=3?AppBar(
        backgroundColor: _selectedIndex==1?kBackgroundColor:Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Hero(
              tag: 'hero-profile-picture',
              child: Avatar.small(
                  url: context.currentUserImage,
                  onTap:() {
                    Navigator.of(context).push(ProfileScreen.route);
                  }
              ),
            ),
          )
        ],
      ):null,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          color: kBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GNav(
              color: Colors.black38,
              backgroundColor: kBackgroundColor,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              activeColor: kTextColor,
              tabBackgroundColor: const Color.fromRGBO(38, 38, 38, 0.1),
              gap: 8,
              padding: const EdgeInsets.all(15),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.messenger,
                  text: 'Messages',
                ),
                GButton(
                  icon: Icons.mail,
                  text: 'Mails',
                ),
                GButton (
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: GlowingActionButton(color: kSecondaryColor,icon: Icons.mark_chat_unread_rounded,onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const Chatbot()),)
    ),
  );
  }
}
