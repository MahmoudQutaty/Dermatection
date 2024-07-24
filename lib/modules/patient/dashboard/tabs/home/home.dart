import 'package:flutter/material.dart';

import '../../../../../components/predection_card.dart';
import '../../../../../models/predection.dart';
import '../../../../../shared/styles/colors.dart';
import 'details/details_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //bottom: true,
      child: Column(

        children: [
          // const Padding(
          //   padding: EdgeInsets.only(top: 35.0,bottom: 30),
          //   child: Text("Home",
          //     style: TextStyle(
          //         fontSize: 21.0,
          //         color: kBackgroundColor,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
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
                  itemCount: predictions.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => PredectionCard(
                    itemIndex: index,
                    prediction: predictions[index],
                    Press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            predection: predictions[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
