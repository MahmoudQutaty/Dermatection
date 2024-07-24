
import 'package:flutter/material.dart';

import '../../../../../../models/predection.dart';
import '../../../../../../shared/styles/colors.dart';

import 'body.dart';

class DetailsScreen extends StatelessWidget {

   const DetailsScreen({Key? key, required this.predection}) : super(key: key);
   final PredictionCard predection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon (Icons.arrow_back,color: Colors.black,),
          padding: const EdgeInsets.only(left: kDefaultPadding),
        ),
        title: Text('BACK',style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: Body(predection: predection,),
    );
  }
}
