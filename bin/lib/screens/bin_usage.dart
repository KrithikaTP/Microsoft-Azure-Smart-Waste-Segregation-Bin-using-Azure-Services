import 'package:bin/services/azure_cosmos.dart';

import '../constants.dart';
import 'package:bin/screens/points_page.dart';
import 'package:bin/widgets/bin_usage_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BinUsage extends StatefulWidget {
  static const String id = 'bin_usage';
  final String plasticNumbers;
  final String paperNumbers;
  final String metalNumbers;
  final String plasticWeight;
  final String paperWeight;
  final String metalWeight;
  final String userId;
  BinUsage(
      {@required this.userId,
        @required this.plasticNumbers,
      @required this.paperNumbers,
      @required this.metalNumbers,
      @required this.plasticWeight,
      @required this.paperWeight,
      @required this.metalWeight});
  @override
  _BinUsageState createState() => _BinUsageState();
}

const color = const Color(0xFFf12711);

class _BinUsageState extends State<BinUsage> {
  AzureCosmosDB cosmosDB = AzureCosmosDB();
  String points;
  String plasticNumbers;
  String paperNumbers;
  String metalNumbers;
  String plasticWeight;
  String paperWeight;
  String metalWeight;
  @override
  void initState() {
    plasticNumbers = widget.plasticNumbers;
    paperNumbers = widget.paperNumbers;
    metalNumbers = widget.metalNumbers;
    plasticWeight = widget.plasticWeight;
    paperWeight = widget.paperWeight;
    metalWeight = widget.metalWeight;
    var calculatedPoints = (kPlasicWeightPoints * double.parse(plasticWeight)) + (kPaperWeightPoints * double.parse(paperWeight)) +(kMetalWeightPoints * double.parse(metalWeight));
    points =calculatedPoints.toStringAsFixed(3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFF121212),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Opacity(
                opacity: 0.9,
                child: BinUsageCard(
                  weight: plasticWeight,
                  objectsNumber: plasticNumbers,
                  wasteType: 'PLASTIC',
                ),
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: 0.9,
                child: BinUsageCard(
                  weight: paperWeight,
                  objectsNumber: paperNumbers,
                  wasteType: 'PAPER',
                ),
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: 0.9,
                child: BinUsageCard(
                  weight: metalWeight,
                  objectsNumber: metalNumbers,
                  wasteType: 'METAL',
                ),
              ),
            ),

            //button to get check for points
            GestureDetector(

              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Points(points: points,),
                );
              },
              child: Container(
                child: Center(
                  child: Text(
                    'CHECK POINTS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      decoration: (TextDecoration.none),
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 60.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
