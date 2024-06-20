import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:intl/intl.dart'; // for date format
// for other locales
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/app/modules/velario/controllers/velario_repository.dart';
import 'package:santa_barbara/app/modules/velario/vela.Interface.dart';
import 'package:animated_button_bar/animated_button_bar.dart';

class VelarioView extends StatefulWidget {
  const VelarioView({super.key});

  @override
  State<VelarioView> createState() => _VelarioViewState();
}

class _VelarioViewState extends State<VelarioView> {
// class VelarioView extends GetView<VelarioController> {
  // const VelarioView({super.key});
  late VelarioRepository velarioRepository;

  @override
  Widget build(BuildContext context) {
    //late VelarioRepository velarioRepository;
    //velarioRepository = Provider.of<VelarioRepository>(context);
    return Provider(
      create: (_) => VelarioRepository,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 51, 4, 4),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 49, 1, 1),
          title: const Text(
            'Bem vindo ao nosso Velário',
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
          centerTitle: true,
        ),
        extendBody: true,
        bottomNavigationBar: Stack(
          children: [
            Positioned(
              // bottom: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                  ),
                  //inverted selection button bar
                  AnimatedButtonBar(
                    radius: 8.0,
                    padding: const EdgeInsets.all(16.0),
                    invertedSelection: true,
                    children: [
                      ButtonBarEntry(
                          onTap: () => GoRouter.of(context).go('/home'),
                          child: const Text('Home')),
                      ButtonBarEntry(
                          onTap: () => _dialogBuilder(context),
                          child: const Text('Acender Vela')),
                      ButtonBarEntry(
                          onTap: () => _mostrarVelasAcesas(context),
                          child: const Text('Velas acesas')),
                    ],
                  ),
                  //You can populate it with different types of widgets like Icon
                ],
              ),
            ),
          ],
        ),

        // FancyBottomNavigation(
        //     initialSelection: 2,
        //     barBackgroundColor: const Color.fromARGB(255, 143, 8, 8),
        //     circleColor: const Color.fromARGB(243, 243, 241, 0),
        //     textColor: const Color.fromARGB(250, 248, 248, 246),
        //     tabs: [
        //       TabData(iconData: Icons.home, title: "Voltar"),
        //       TabData(
        //           iconData: Icons.wb_incandescent_outlined,
        //           title: "Acender Vela"),
        //       TabData(iconData: Icons.list_outlined, title: "Velas acesas"),
        //       TabData(
        //           iconData: Icons.local_fire_department_outlined,
        //           title: "Suas Velas"),
        //     ],
        //     onTabChangedListener: (position) {
        //       switch (position.toString()) {
        //         case '0':
        //           GoRouter.of(context).go('/home');
        //         case '1':
        //           _dialogBuilder(context);
        //         case '2':
        //           //context.watch<VelarioRepository>().getVelas();

        //           _mostrarVelasAcesas(context);
        //         default:
        //           print(position);
        //       }
        //     }),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/gifs/velaAcesa.gif"),
                fit: BoxFit.cover,
              ),
            ),
            child: null),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final intencaoKey = GlobalKey<FormBuilderFieldState>();
    final destinatarioKey = GlobalKey<FormBuilderFieldState>();
    // final textoKey = GlobalKey<FormBuilderFieldState>();
    VelarioRepository velarioRepository = VelarioRepository();
    VelaInterface vela = VelaInterface();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acenda a vela!'),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 223, 218, 205),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    key: destinatarioKey,
                    name: 'destinatario',
                    decoration: const InputDecoration(
                        labelText: 'Para quem será esta vela?'),
                    onSaved: (value) => vela.destinatario = value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    key: intencaoKey,
                    name: 'intencao',
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: 'Qual a intenção desta vela'),
                    onSaved: (value) => vela.intencao = value,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Acender'),
              onPressed: () async {
                formKey.currentState?.save();
                await velarioRepository.acenderVela(vela, context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _mostrarVelasAcesas(BuildContext context) async {

    CarouselSliderController sliderController = CarouselSliderController();

    // final textoKey = GlobalKey<FormBuilderFieldState>();
    // VelarioRepository velarioRepository = VelarioRepository();

    VelarioRepository velarioRepository = VelarioRepository();
    await velarioRepository.getVelas();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // title: const Text(
          //   'Velas acesas!',
          //   style: TextStyle(color: Colors.green),
          // ),
          // insetPadding:
          //     const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //elevation: 10,
          // backgroundColor: Color.fromARGB(255, 41, 30, 1),
          child: ChangeNotifierProvider<VelarioRepository>(
            create: (_) => VelarioRepository(),
            child: Consumer<VelarioRepository>(
              builder: (context, model, child) => Column(
                children: [
                  // const SizedBox(
                  //   height: 250,
                  // ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: MediaQuery.of(context).size.height - 150,
                      child: CarouselSlider.builder(
                        enableAutoSlider: true,
                        unlimitedMode: true,
                        controller: sliderController,
                        slideBuilder: (index) {
                          return GestureDetector(
                            onTap: () => {null},
                            child: Container(
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellow),
                                image: const DecorationImage(
                                  image: AssetImage("assets/gifs/vela2.gif"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: [
                                    const Positioned(
                                      top: 10,
                                      child: Text(
                                        'Vela acesa para:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      child: Text(
                                        velarioRepository
                                            .slideItens[index].destinatario!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            decoration: TextDecoration.none,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 80,
                                      child: Text(
                                        (DateFormat("dd/MM 'as' hh:mm").format(
                                            velarioRepository.slideItens[index]
                                                .dataInclusao!)),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 50,
                                      child: Text(
                                        'Acesa por mais: ${velarioRepository.slideItens[index].tempoRestante()}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        slideTransform: const CubeTransform(),
                        slideIndicator: CircularSlideIndicator(
                          padding: const EdgeInsets.only(bottom: 32),
                          indicatorBorderColor: Colors.black,
                        ),
                        itemCount: velarioRepository.slideItens.length,
                        initialPage: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       textStyle: Theme.of(context).textTheme.labelLarge,
          //     ),
          //     child: const Text('Sair'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
