import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riv_fs_app/firebase_options.dart';
import 'package:todo_riv_fs_app/notifications/notifications.dart';
import 'package:todo_riv_fs_app/screens/home_page.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.light,
        // themeMode: ThemeMode.light,
        darkTheme: MyTheme.dark,
        home: const HomePage()),
  ));
}
