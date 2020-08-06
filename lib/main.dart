import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/model/blood_pressure.dart';
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
      theme: ThemeData.light().copyWith(accentColor: Colors.grey),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
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
