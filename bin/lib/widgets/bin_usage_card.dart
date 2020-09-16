import 'package:flutter/material.dart';


class BinUsageCard extends StatelessWidget {
  BinUsageCard({@required this.weight,@required this.objectsNumber,@required this.wasteType});
  final String weight,objectsNumber,wasteType;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                objectsNumber,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 70.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'OBJECTS',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  wasteType,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      weight,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'kG',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)]),
          borderRadius: BorderRadius.circular(12.0)),
    );
  }
}

