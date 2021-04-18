import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main-page.dart';
import 'setup-page.dart';
import 'app-model.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My OTP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainPage(title: 'TOTP Demo App'),
      }
    );
  }
}


