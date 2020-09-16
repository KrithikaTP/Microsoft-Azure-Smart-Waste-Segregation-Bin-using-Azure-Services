import 'package:flutter/material.dart';

class PointsDisplayCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final String wasteType;
  final String points;
  final Color textColor;
  PointsDisplayCard(
      {@required this.icon,
        @required this.wasteType,
        @required this.points,
        @required this.iconColor,
        @required this.color,
        @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 40.0,
          ),
          Text(
            '$wasteType (/kG)',
            style: TextStyle(color: textColor, fontSize: 20.0),
          ),
          Text(
            '$points Points',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFEFEFF),
            ),
          ),

        ],
      ),
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color]),
          borderRadius: BorderRadius.circular(12.0)),
    );
  }
}


