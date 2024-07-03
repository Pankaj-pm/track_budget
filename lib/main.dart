import 'package:budget_tracker_app/home/home_page.dart';
import 'package:budget_tracker_app/splace_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DbHelper helper=DbHelper.instance;
  helper.createDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
          name: "/homePage",
          page: () => HomePage(),
          transition: Transition.circularReveal,
        ),
      ],
    );
  }
}
