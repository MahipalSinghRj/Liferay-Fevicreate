import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:test_web_app/views/splash_screen.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

// build on Flutter 2.5.3

Future<void> main() async {
  if (Platform.isAndroid) {
    FloatingActionButton(onPressed: () {
      Get.off;
    });
    print("Android");
  } else if (Platform.isIOS) {
    print("iOS");
  }
  WidgetsFlutterBinding.ensureInitialized();
  FacebookAuth instance = FacebookAuth.instance;
  await instance.isAutoLogAppEventsEnabled;
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FeviCreate",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen1(),
    );
  }
}
