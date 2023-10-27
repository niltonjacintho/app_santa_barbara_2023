// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_boom_menu_new/flutter_boom_menu_new.dart';

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
            onTap: () => print('THIRD CHILD'),
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
          child: null,
        ),
        floatingActionButton: buildBoomMenu(),
      ),
    );
  }
}
