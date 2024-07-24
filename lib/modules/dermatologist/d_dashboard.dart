
import 'package:dermatechtion/modules/chat/models/app.dart';
import 'package:dermatechtion/modules/chat/profile_screen.dart';
import 'package:dermatechtion/modules/dermatologist/d_dashboard/my_patients.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../shared/styles/colors.dart';
import '../chat/pages/messages_page.dart';
import '../chat/widgets/avatar.dart';
import '../chat/widgets/icon_buttons.dart';
import '../patient/dashboard/tabs/mails.dart';
import '../patient/dashboard/tabs/me.dart';
import 'd_dashboard/Home.dart';
import 'd_dashboard/explore.dart';
class DDashboard extends StatefulWidget {
  const DDashboard({Key? key}) : super(key: key);

  @override
  State<DDashboard> createState() => _DDashboardState();
}

class _DDashboardState extends State<DDashboard> {

  int _selectedIndex = 0;
  final List<Widget> _tabs =  [MessagesPage(), const Mails(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_selectedIndex != 2?AppBar(
        backgroundColor:_selectedIndex == 1?kPrimaryColor: Colors.transparent,
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
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: GNav(
              color: Colors.black38,
              backgroundColor: kBackgroundColor,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              activeColor: kTextColor,
              tabBackgroundColor: const Color.fromRGBO(38, 38, 38, 0.1),
              gap: 0,
              padding: const EdgeInsets.all(15),
              tabs:
              const [

                GButton(
                  icon: Icons.groups_sharp,
                  text: 'Patients',
                ),
                GButton(
                  icon: Icons.mail,
                  text: 'Mails',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
