import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../../../components/mail_card.dart';
import '../../../../controllers/provider/auth.dart';

class Mails extends StatelessWidget {
  const Mails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180.0,
            child: Column(
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(left: 138.0, top: 65.0),
                //   child: Row(
                //     children: <Widget>[
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: const <Widget>[
                //           Text(
                //             "All Mails",
                //             style: TextStyle(
                //                 fontSize: 21.0,
                //                 color: kBackgroundColor,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 60.0,
                ),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      child: Container(
                        height: 70.0,
                        width: 315.0,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      child: Container(
                        height: 95.0,
                        width: 330,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    'lib/assets/images/user.png',
                                    height: 60.0,
                                    width: 60.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            Auth.name,
                                            style: TextStyle(
                                                color: kTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${DateTime.now().hour}:${DateTime.now().minute}",
                                            style: const TextStyle(
                                                color: kTextColor,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5),
            child: Row(
              children: const <Widget>[
                Icon(
                  Icons.inbox,
                  color: kTextColor,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Inbox',
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  decoration: const BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                ),
                ListView.builder(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const MailCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
