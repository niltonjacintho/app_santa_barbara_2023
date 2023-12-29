import 'package:app_sbrm/app/modules/game/game.repository.dart';
import 'package:app_sbrm/model/quiz_model.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GamePerguntas extends StatefulWidget {
  const GamePerguntas({super.key});

  @override
  State<GamePerguntas> createState() => _GamePerguntasState();
}

class _GamePerguntasState extends State<GamePerguntas> {
  late GameRepository gameRepository;
  @override
  Widget build(BuildContext context) {
    gameRepository = Provider.of<GameRepository>(context);
    // gameRepository.getQuiz();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fundoQuiz_vazio.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ChangeNotifierProvider<GameRepository>(
            create: (_) => GameRepository(),
            child: Consumer<GameRepository>(
              builder: (context, model, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: UnconstrainedBox(
                      child: Container(
                        width: 600,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 8, 4),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 143, 97, 96)
                                    .withOpacity(0.5),
                                offset: const Offset(0, 25),
                                blurRadius: 3,
                                spreadRadius: -10)
                          ],
                        ),
                        child: Center(
                          child: Text(
                            gameRepository
                                .letters[gameRepository.topicoEscolhido],
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.amber,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Center(
                  //   child: Text(
                  //     gameRepository.perguntaAtual.pergunta != null
                  //         ? gameRepository.perguntaAtual.pergunta!
                  //         : '',
                  //     style: GoogleFonts.sevillana(
                  //         textStyle: const TextStyle(
                  //             fontSize: 40,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.amber)),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  montar_perguntas(context),
                  // montarConfirmacao(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget montar_perguntas(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: Text(
              gameRepository.perguntaAtual.pergunta != null
                  ? "${gameRepository.idPerguntaAtual} )${gameRepository.perguntaAtual.pergunta!}"
                  : '',
              style: GoogleFonts.pangolin(
                  textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, right: 60, bottom: 8),
          child: CustomRadioButton(
            height: 80,
            elevation: 5,
            defaultSelected: '',
            absoluteZeroSpacing: false,
            unSelectedColor: Theme.of(context).canvasColor,
            buttonLables: gameRepository.getButtonLabels(),
            buttonValues: gameRepository.getButtonValues(),
            buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.black,
                textStyle: TextStyle(
                  fontSize: 25,
                )),
            radioButtonValue: (value) {
              EmojiAlert(
                alertTitle: Text(
                  gameRepository.acertou(value) ? "PARABÉNS!!" : "Xii.. errou",
                  style: GoogleFonts.yatraOne(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                description: Column(
                  children: [
                    Text(
                      gameRepository.acertou(value)
                          ? "Nota-se que você lê a Biblia e estuda hein!! Vamos em frente"
                          : "Desanima não!! A próxima pergunta você acerta! Vamos em frente",
                      style: GoogleFonts.handlee(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 145, 2, 2),
                            fontSize: 25),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                enableMainButton: true,
                cornerRadiusType: CORNER_RADIUS_TYPES.TOP_ONLY,
                mainButtonColor: Colors.green,
                mainButtonText: const Text("Save"),
                onMainButtonPressed: () {
                  if (gameRepository.proximaPergunta()) {
                    montar_perguntas(context);
                  }
                  value = '';
                  Navigator.of(context, rootNavigator: true).pop();
                },
                cancelable: false,
                emojiType: gameRepository.acertou(value)
                    ? EMOJI_TYPE.SMILE
                    : EMOJI_TYPE.SCARED,
                width: 400,
                height: gameRepository.acertou(value) ? 400 : 400,
              ).displayAlert(context);
            },
            horizontal: true,
            padding: 5,
            selectedColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
