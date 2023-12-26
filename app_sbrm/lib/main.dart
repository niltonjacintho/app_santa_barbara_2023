// ignore_for_file: avoid_print

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_sbrm/app/modules/paroquias/controllers/paroquias.repository.dart';
import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'modules/home/home.view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Passou ${Firebase.apps}');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AvisoRepository()),
    ChangeNotifierProvider(create: (context) => ParoquiasRepository()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Code',
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: SizedBox(
            //height: 400,
            child: Image.network(
              'https://cruzterrasanta.com.br/_global/_ssf/ssf.aspx?d=/_upload/significados_de_santos/&arquivo=santa-barbarajpg5282012141946.jpg',
              fit: BoxFit.fill,
              height: (MediaQuery.of(context).size.height * 4),
              width: (MediaQuery.of(context).size.width / 1),
              alignment: Alignment.center,
            ),
          ),
          nextScreen: const HomeView(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: (MediaQuery.of(context).size.height - 50),
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: const Color.fromARGB(255, 84, 3, 3)),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 1, 0, 10),
    );
  }
}
