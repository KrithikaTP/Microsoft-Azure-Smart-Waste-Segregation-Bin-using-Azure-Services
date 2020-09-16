import 'package:bin/screens/bin_usage.dart';
import 'package:bin/screens/user_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: UserLogin.id,
      routes: {
        UserLogin.id : (context) => UserLogin(),
        BinUsage.id : (context) => BinUsage()
      },
    );
  }
}
