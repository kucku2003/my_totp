import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main-page.dart';
import 'models/app-model.dart';
import 'models/setup-model.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<AppModel>(create: (context) => AppModel()),
      ChangeNotifierProvider<SetupModel>(create: (context) => SetupModel()),
    ],
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My TOTP App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainPage(title: 'TOTP - Application'),
      }
    );
  }
}


