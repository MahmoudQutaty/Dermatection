import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class MailCard extends StatelessWidget {
  const MailCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        bottom: 15,
      ),
      child: InkWell(
        onTap: () => openBottomSheet(context),
        child: Container(
          height: 110.0,
          width: 330,
          decoration: BoxDecoration(
              boxShadow: const [kDefaultShadow],
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
                      'lib/assets/images/cs.png',
                      height: 60.0,
                      width: 60.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: <Widget>[
                            const Text(
                              'Customer Service',
                              style: TextStyle(
                                  color: kTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            const Spacer(),
                            Text(
                              "${DateTime.now().hour}:${DateTime.now().minute}",
                              style: const TextStyle(
                                  color: kTextColor, fontSize: 14.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Hello this is your message, Click on the card to read the content.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
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
    );
  }

  void openBottomSheet(ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset('lib/assets/images/cs.png',height: 60.0,width: 60.0,),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Customer service is the assistance and advice provided by a company to those people who buy or use its products or services. Each industry requires different levels of customer service, but towards the end, the idea of a well-performed service is that of increasing revenues.',
                        overflow: TextOverflow.ellipsis ,
                      maxLines: 15,style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87
                        ),),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
