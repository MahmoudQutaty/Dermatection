import 'package:dermatechtion/components/my_button.dart';
import 'package:dermatechtion/modules/registration/take_photo_screen.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../controllers/provider/prediction.dart';

class CameraOrDermascopy extends StatelessWidget {
  const CameraOrDermascopy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: kBackgroundColor,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myButton(function: (){
                MyPredictionProvider.modelData = "camera";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePhoto(),
                  ),
                );
              },title: "Camera"),
              SizedBox(height: 50,),
              myButton(function: (){
                MyPredictionProvider.modelData = "dermascopy";
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePhoto(),
                ),
              );},title: "Dermascopy"),
            ],
          ),
        ),
      ),


    );
  }
}
