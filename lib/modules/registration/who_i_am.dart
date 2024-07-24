
import 'package:flutter/material.dart';

import '../../components/my_button.dart';
import '../../shared/styles/colors.dart';
import 'signin_or_signup_screen.dart';
import 'take_photo_screen.dart';

import '../../controllers/provider/auth.dart';

class WhoIAm extends StatefulWidget {
  const WhoIAm({Key? key}) : super(key: key);

  @override
  State<WhoIAm> createState() => _WhoIAmState();
}

class _WhoIAmState extends State<WhoIAm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body:
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Image.asset('lib/assets/images/DermaTection.png'),
                Text("Who are you?!",style: TextStyle(fontSize: 18,color: Colors.grey[300]),),
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
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2),
                        child: Column(
                          children: [
                            const SizedBox(height: kDefaultPadding,),
                            myButton(function: (){
                              setState(() {
                                Auth.user='patient';
                              });
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const InOrUp(),
                              ),
                            );},title: 'I am a Patient'),
                            myButton(function: (){
                              setState(() {
                                Auth.user='dermatologist';
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const InOrUp(),
                              ),);
                            },title: 'I am a Dermatologist'),
                            myButton(function: (){
                              setState(() {
                                Auth.user='customer_service';
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const InOrUp(),
                                ),);
                            },title: 'I am a Customer Service'),
                          ],
                        ),
                      )

                    ],
                  ),
                )

              ],

            ),
          ),


    );
  }
}
