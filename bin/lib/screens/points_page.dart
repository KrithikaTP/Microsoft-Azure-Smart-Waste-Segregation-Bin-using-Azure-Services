import 'package:bin/widgets/points_display_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Points extends StatefulWidget {
  final String points;
  Points({@required this.points});
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PointsDisplayCard(
                color: Color(0xFF9B98F1),
                icon: Icons.widgets,
                iconColor: Color(0xFF7E79D4),
                wasteType: 'Plastic',
                points: kPlasicWeightPoints.toString(),
                textColor: Color(0xFFD1D0FA),
              ),
            ),
            Expanded(
              child: PointsDisplayCard(
                color: Color(0xFF7E9BF5),
                icon: Icons.print,
                iconColor: Color(0xFF5B76D8),
                wasteType: 'Paper',
                points: kPaperWeightPoints.toString(),
                textColor: Color(0xFFD1D0FA),
              ),
            ),
            Expanded(
              child: PointsDisplayCard(
                color: Color(0xFFF89A7E),
                icon: Icons.album,
                iconColor: Color(0xFFFA8A7C),
                wasteType: 'Plastic',
                points: kMetalWeightPoints.toString(),
                textColor: Colors.white60,
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  'Your Points : ${widget.points}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFF78380), Color(0xFFF56261)]),
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 5.0),
              child: GestureDetector(
                child: Container(
                 color: Colors.lightBlueAccent,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Redeem',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            decoration: (TextDecoration.none),
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.attach_money_rounded,
                          size: 30.0,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.attach_money_rounded,
                          size: 30.0,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.attach_money_rounded,
                          size: 30.0,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),

                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 50.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
