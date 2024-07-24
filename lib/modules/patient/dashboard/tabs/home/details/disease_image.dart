import 'package:flutter/material.dart';

import '../../../../../../shared/styles/colors.dart';
class DiseaseImage extends StatelessWidget {
  const DiseaseImage({Key? key, required this.size, required this.image}) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      height: size.width*0.7,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: size.width*0.6,
            width: size.width*0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(image,
            height: size.width*0.6,
            width: size.width*0.6,
          ),
        ],
      ),
    );
  }
}
