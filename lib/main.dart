import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minecraft_server_ping/generated/l10n.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minecraft Server Ping',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(bodyText1: TextStyle()),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ],
      supportedLocales: S.delegate.supportedLocales,
      
      home: Home(),
    );
  }
}
