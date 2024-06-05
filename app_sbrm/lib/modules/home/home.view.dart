// ignore_for_file: unnecessary_null_comparison, avoid_print

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
        // floatingActionButton: buildBoomMenu(),
      ),
    );
  }
}
