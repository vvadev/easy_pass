import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerua_transport/app.dart';
import 'package:lerua_transport/color_schemes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lerua_transport/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Пропуск',
      theme: ThemeData(
        colorScheme: Get.isDarkMode ? darkColorScheme : lightColorScheme,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (p0) => const App(),
        '/settings': (p0) => const SettingsScreen(),
      },
    );
  }
}
