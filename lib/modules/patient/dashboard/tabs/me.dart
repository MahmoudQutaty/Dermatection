import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/provider/auth.dart';
import '../../../../shared/styles/colors.dart';

class Me extends StatelessWidget {
  String userName;
  String userPhone;
  String userMail;
  String profilePictureUrl = 'lib/assets/images/user.png';

  Me(this.userName, this.userPhone, this.userMail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 65),
              child: Text(
                "My Profile",
                style: TextStyle(
                    fontSize: 21.0,
                    color: kBackgroundColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              height: 100,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Image.asset(
                    profilePictureUrl,
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 30,),
                      InfoCard(
                        title: userName,
                        label: 'Name',
                      ),
                      InfoCard(
                        title: userPhone,
                        label: 'Phone',
                      ),
                      InfoCard(
                        title: userMail,
                        label: 'G-mail',
                      ),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Provider.of<Auth>(context, listen: false).logOut(),
        backgroundColor: kTextColor,
        icon: const Icon(Icons.output),
        label: const Text('Log Out'),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard(
      {Key? key, required this.title, required this.label})
      : super(key: key);

  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      //color: Colors.blueAccent,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [kDefaultShadow]
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              height: 100,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 1.5,
                      vertical: kDefaultPadding / 4,
                    ),
                    decoration: const BoxDecoration(
                      color: kTextLightColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  //const Spacer(),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.button,
                      overflow: TextOverflow.fade,
                    ),
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
