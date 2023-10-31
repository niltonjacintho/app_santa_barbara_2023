// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:app_sbrm/modules/auth/auth.service.dart';
import 'package:app_sbrm/modules/avisos/avisos.view.dart';
import 'package:app_sbrm/modules/home/homemenu.card.dart';
import 'package:app_sbrm/modules/home/homemenu.data.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_boom_menu_new/flutter_boom_menu_new.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  @override
  ScrollController? scrollController;
  bool scrollVisible = true;

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

  BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        elevation: 10,
        overlayOpacity: 0.7,
        children: [
          MenuItemModel(
//          child: Icon(Icons.accessibility, color: Colors.black, size: 40,),
            child: Image.asset('assets/images/avisos.png',
                color: Colors.grey[850]),
            title: "Avisos Paroquiais",
            titleColor: Colors.grey[850]!,
            subtitle: "O dia a dia da sua paróquia!!",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () async => {
              await AuthService()
                  .login(email: 'teste@123.com', password: '123456'),
              print('THIRD CHILD'),
            },
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/avisos.png',
                color: Colors.grey[850]),
            title: "Avisos Paroquiais",
            titleColor: Colors.grey[850]!,
            subtitle: "O dia a dia da sua paróquia!!",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => {
              log(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AvisosView()),
              ),
              print('THIRD CHILD'),
            },
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/images/padres.png', color: Colors.white),
            title: "Mensagem do Pároco",
            titleColor: Colors.white,
            subtitle: "Mensagem semanal dos nossos padres!",
            subTitleColor: Colors.white,
            backgroundColor: Colors.pinkAccent,
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          ),
        ]);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('Boom Menu Example')),
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
        floatingActionButton: buildBoomMenu(),
      ),
    );
  }
}
