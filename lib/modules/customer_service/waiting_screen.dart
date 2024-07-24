import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body:
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.asset('lib/assets/images/DermaTection.png',),
                  const Text('You\'re almost there',style: TextStyle(
                    fontSize: 24,
                    color: kTextColor
                  ),),
                  const SizedBox(height: 10.0,),
                  const Text('We need some more time to look over your application.',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 20,
                    color: kTextLightColor
                  ),),
                  const SizedBox(height: 10.0,),
                  const Text('why do I have to wait?',style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18
                  ),),
                  const SizedBox(height: 10.0,),
                  const Text('We just want to confirm the information you have uploaded to make sure your skills and experience is valid with us.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kTextLightColor,
                    ),),
                  const SizedBox(height: 90.0,),
                  InkWell(
                    child: const Text('Cancel my application and delete all my information',
                    style: TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 16
                    ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: (){},
                  )

                ],
              ),
            ),
          ),
    );
  }
}
