import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:i_logistics/screens/home_screen/home_screen.dart';
import 'package:i_logistics/screens/pending_jobs_screen/job_screen.dart';
import 'package:i_logistics/screens/login_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  ///testing
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color =
    {
      50:Color.fromRGBO(136,14,79, .1),
      100:Color.fromRGBO(136,14,79, .2),
      200:Color.fromRGBO(136,14,79, .3),
      300:Color.fromRGBO(136,14,79, .4),
      400:Color.fromRGBO(136,14,79, .5),
      500:Color.fromRGBO(136,14,79, .6),
      600:Color.fromRGBO(136,14,79, .7),
      700:Color.fromRGBO(136,14,79, .8),
      800:Color.fromRGBO(136,14,79, .9),
      900:Color.fromRGBO(136,14,79, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xff2A4D69, color);
    return GetMaterialApp(
      title: 'Email and Password Login ',
      theme: ThemeData(
        primarySwatch:colorCustom,
      ),
      home: const LoginScreen(),
    );
  }
}
