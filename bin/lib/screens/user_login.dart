import 'dart:convert';


import 'package:bin/screens/bin_usage.dart';
import 'package:bin/services/azure_cosmos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  static String id = 'user_login';

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  AzureCosmosDB cosmosDB = AzureCosmosDB();

  String data;

  String userId;

  String validity = ' ';

  Color borderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter your RFID',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      )),
                  onChanged: (value) {
                    userId = value;
                    print(value);
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        data = await cosmosDB.readData(userId: userId);
                        if (data != null) {

                          var decodeData = jsonDecode(data);
                          int plasticNumbers = decodeData['plastic_Numbers'];
                          int paperNumbers = decodeData['paper_Numbers'];
                          int metalNumbers = decodeData['metal_Numbers'];
                          double plasticWeight = decodeData['plastic_Weight'];
                          double paperWeight = decodeData['paper_Weight'];
                          double metalWeight = decodeData['metal_Weight'];
                          print('$plasticNumbers $paperNumbers $metalNumbers');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BinUsage(
                              userId: userId,
                              paperNumbers: paperNumbers.toString(),
                              plasticNumbers: plasticNumbers.toString(),
                              metalNumbers: metalNumbers.toString(),
                              paperWeight: paperWeight.toString(),
                              plasticWeight: plasticWeight.toString(),
                              metalWeight: metalWeight.toString(),
                            );
                          }));
                        } else {
                          setState(() {
                            borderColor = Colors.red;
                            validity = 'User RFID not issued';
                          });
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Get In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Text('$validity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ))
              ],
            ),
          ),
        ));
  }
}
