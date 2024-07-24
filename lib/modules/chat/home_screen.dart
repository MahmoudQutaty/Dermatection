import 'package:dermatechtion/modules/chat/models/app.dart';
import 'package:dermatechtion/modules/chat/profile_screen.dart';
import 'package:dermatechtion/modules/chat/widgets/glowing_action_button.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';

import 'pages/contacts_page.dart';

import 'pages/calls_page.dart';
import 'package:flutter/material.dart';

import 'pages/messages_page.dart';
import 'pages/notifications_page.dart';
import 'widgets/avatar.dart';
import 'widgets/helpers.dart';
import 'widgets/icon_buttons.dart';

class ChatHomeScreen extends StatelessWidget {
  ChatHomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              title.value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print('To Do Search');
              }),
        ),
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
      ),
      backgroundColor: kBackgroundColor,
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                label: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                index: 0,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 0),
              ),
              _NavigationBarItem(
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                index: 1,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 1),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GlowingActionButton(
                    color: kPrimaryColor,
                    icon: CupertinoIcons.add,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: AspectRatio(
                            aspectRatio: 8/7,
                            child: ContactsPage(),
                          ),
                        )
                      );
                    }),
              ),
              _NavigationBarItem(
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
                index: 2,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 2),
              ),
              _NavigationBarItem(
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                index: 3,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);
  final ValueChanged<int> onTap;
  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? kTextColor : Colors.grey,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 11, color: isSelected ? kTextColor : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
