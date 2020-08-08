import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'ui/page/chart_page.dart';
import 'ui/page/list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialHive();
  runApp(MyApp());
}

Future initialHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BloodPressureAdapter());
  await Hive.openBox<BloodPressure>(bloodPressureBoxName);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDartThemeData(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant',
          countryCode: 'TW',
        ),
      ],
      initialRoute: '/list',
      routes: {
        '/list': (context) => ListPage(),
        '/chart': (context) => ChartPage(),
      },
    );
  }
}

ThemeData getDartThemeData() {
  return ThemeData.dark().copyWith(
    textSelectionColor: const Color(0x7fff3311),
    accentColor: Colors.grey,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        color: Color(0xff98a8b9),
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: 20,
        color: Color(0xffb0b0b0),
      ),
      headline6: TextStyle(
        fontSize: 12,
        color: Color(0xffb0b0b0),
      ),
    ),
  );
}