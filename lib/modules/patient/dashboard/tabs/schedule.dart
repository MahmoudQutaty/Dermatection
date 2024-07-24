import 'package:carousel_slider/carousel_slider.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.only(top: 65, bottom: 30),
          //   child: Text(
          //     "Schedule",
          //     style: TextStyle(
          //         fontSize: 21.0,
          //         color: kBackgroundColor,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          DrugCard(width: width),
          const SizedBox(
            height: 20.0,
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
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      MeetWithDoctorCard(width: width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MeetWithDoctorCard extends StatelessWidget {
  MeetWithDoctorCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      child: Container(
        //color: kPrimaryColor,
        height: 100,
        width: width,
        decoration: BoxDecoration(
            boxShadow: const [kDefaultShadow],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
              'You Have a meeting with Dr. Mohammed',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),

                 ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrugCard extends StatelessWidget {
  const DrugCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 150,
      child: Stack(
        children: [
          Positioned(
            top: 35,
            left: 20,
            right: 20,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 115.0,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 4.0,
                      blurRadius: 20.0,
                      offset: const Offset(
                          -10.0, 10.0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 30.0,
            child: Card(
              color: const Color(0xDD000839),
              elevation: 10.0,
              shadowColor: Colors.blueAccent.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                //color: kPrimaryColor,
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('lib/assets/images/medicine-drug.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 175,
            right: 25,
            child: Container(
              height: 115,
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Drug Name',
                    style: TextStyle(
                        fontSize: 17,
                        color: kTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Drug\'s type',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Text(
                    'Time to get the treatment',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
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
