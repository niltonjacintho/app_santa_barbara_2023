// ignore_for_file: avoid_print

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:santa_barbara/app/modules/agenda/views/agenda_view.dart';
import 'package:santa_barbara/app/modules/game/game.perguntas.view.dart';
import 'package:santa_barbara/app/modules/game/game.repository.dart';
import 'package:santa_barbara/app/modules/game/game.view.dart';
import 'package:santa_barbara/app/modules/game/gamePodio.view.dart';
import 'package:santa_barbara/app/modules/mensagem_paroco/views/mensagem_paroco_view.dart';
import 'package:santa_barbara/app/modules/paroquias/controllers/paroquias.repository.dart';
import 'package:santa_barbara/app/modules/paroquias/views/paroquias_view.dart';
import 'package:santa_barbara/app/modules/photo/views/photo_view.dart';
import 'package:santa_barbara/app/modules/velario/views/velario_view.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';
import 'package:santa_barbara/modules/auth/auth.view.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/avisos/avisos.view.dart';
import 'package:santa_barbara/modules/avisos/avisoview.details.dart';
import 'package:santa_barbara/modules/home/home.view.dart';
import 'firebase_options.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyApp();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: '/agenda',
      builder: (BuildContext context, GoRouterState state) {
        return const AgendaView();
      },
    ),
    GoRoute(
      path: '/paroquias',
      builder: (BuildContext context, GoRouterState state) {
        return const ParoquiasView();
      },
    ),
    GoRoute(
      path: '/avisos',
      builder: (BuildContext context, GoRouterState state) {
        return const AvisosView();
      },
    ),
    GoRoute(
      path: '/games',
      builder: (BuildContext context, GoRouterState state) {
        return const GamesView();
      },
    ),
    GoRoute(
      path: '/gamepodio',
      builder: (BuildContext context, GoRouterState state) {
        return const GamePodio();
      },
    ),
    GoRoute(
      path: '/gamePerguntas',
      builder: (BuildContext context, GoRouterState state) {
        return const GamePerguntas();
      },
    ),
    GoRoute(
        path: '/mensagemparoco',
        builder: (BuildContext context, GoRouterState state) {
          return const MensagemParocoView();
        }),
    GoRoute(
        path: '/avisodetails',
        builder: (BuildContext context, GoRouterState state) {
          return const AvisoviewDetails();
        }),
    GoRoute(
        path: '/velario',
        builder: (BuildContext context, GoRouterState state) {
          return const VelarioView();
        }),
    GoRoute(
        path: '/photos',
        builder: (BuildContext context, GoRouterState state) {
          return const PhotoView();
        })        
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Passou ${Firebase.apps}');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AvisoRepository()),
    ChangeNotifierProvider(create: (context) => ParoquiasRepository()),
    ChangeNotifierProvider(create: (context) => GameRepository()),
    ChangeNotifierProvider(create: (context) => UserRepository()),
  ], child: const BaseApp())); //const MyApp()));
}

class BaseApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
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
            child: Image.asset(
              'assets/images/SantaBarbaraOficial.png',
              fit: BoxFit.fitHeight,
              height: (MediaQuery.of(context).size.height * 4),
              width: (MediaQuery.of(context).size.width / 1),
              alignment: Alignment.center,
            ),
          ),
          nextScreen: const LoginScreen(),
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
      color: const Color.fromARGB(255, 1, 0, 10),
    );
  }
}
