// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';
import 'package:santa_barbara/modules/home/homemenu.card.dart';
import 'package:santa_barbara/modules/home/homemenu.data.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  ScrollController? scrollController;
  bool scrollVisible = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    void setDialVisible(bool value) {
      setState(() {
        scrollVisible = value;
      });
    }

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController!.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  Widget buildBody() {
    return const Text('alive');
  }

  log() async {
    await FirebaseAnalytics.instance.logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
        ],
        coupon: '10PERCENTOFF');
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Desejas realmente sair?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: () =>
              SystemNavigator.pop(), // GoRouter.of(context). .pop(true),
          child: const Text('Sim'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Avisos Paroquiais',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          // title: const Text('Boom Menu Example'),
          leading: PopScope(
            canPop: false,
            onPopInvoked: ((didpop) {
              if (didpop) {
                return;
              } else {
                _onWillPop(context);
              }
            }),
            child: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                GoRouter.of(context).go('/home');
              },
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fundo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Somos Santa Barbara',
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                'versão 20 -- ${userRepository.usuario.nome} --  ',
                style: const TextStyle(
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: FlexibleGridView(
                  padding: const EdgeInsets.all(12),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children:
                      demoData.map((e) => CatalogCard(catalogItem: e)).toList(),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: buildBoomMenu(),
      ),
    );
  }
}
