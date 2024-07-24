
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../../../../components/my_button.dart';
import '../../../../../../controllers/provider/auth.dart';
import '../../../../../../models/predection.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../../../../chat/home_screen.dart';
import '../../../../../chat/models/app.dart';
import '../../../../../chat/select_user_screen.dart';
import 'disease_image.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.predection}) : super(key: key);
  final PredictionCard predection;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loading = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )
            ),
            child: Column(
              children: <Widget>[
                Container(child: DiseaseImage(size: size,image:widget.predection.image,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                  child: Text(widget.predection.title,style: Theme.of(context).textTheme.headline6,

                  ),
                ),
                Text('%${widget.predection.prop}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor,
                ),
                ),
                const SizedBox(height: kDefaultPadding,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                  child: Text(widget.predection.description,
                  style: const TextStyle(color: kTextLightColor),),
                ),
                const SizedBox(height: kDefaultPadding,),
              ],
            ),

          ),
          const SizedBox(height: 20,),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          //   child: myButton(
          //     function: () async{
          //
          //         Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => ChatHomeScreen()),
          //         );
          //
          //
          //     },
          //     title: 'Contact with a Dermatologist',),
          // ),
        ],
      ),
    );
  }
}
