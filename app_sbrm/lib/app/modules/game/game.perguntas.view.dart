import 'package:app_sbrm/app/modules/game/game.repository.dart';
import 'package:app_sbrm/app/modules/game/gamePodio.view.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GamePerguntas extends StatefulWidget {
  const GamePerguntas({super.key});

  @override
  State<GamePerguntas> createState() => _GamePerguntasState();
}

class _GamePerguntasState extends State<GamePerguntas> {
  late GameRepository gameRepository;
  final CountDownController _controller = CountDownController();
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
    _controller.reset();
    _controller.restart();
    
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 251, 250))),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, right: 60, bottom: 8),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: gameRepository.perguntaAtual.perguntasRespostas!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () => {
                    EmojiAlert(
                      alertTitle: Text(
                        gameRepository.acertou(index)
                            ? "PARABÉNS!!"
                            : "Xii.. errou",
                        style: GoogleFonts.yatraOne(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                      ),
                      description: Column(
                        children: [
                          Text(
                            gameRepository.acertou(index)
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
                          gameRepository
                              .gravarPontos(int.parse(_controller.getTime()!));
                          montar_perguntas(context);
                        } else {
                          gameRepository.salvarRank();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GamePodio()));
                        }
                        //gameRepository.perguntaAtual.perguntasRespostas= PerguntasRespostas();
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      cancelable: false,
                      emojiType: gameRepository.acertou(index)
                          ? EMOJI_TYPE.SMILE
                          : EMOJI_TYPE.SCARED,
                      width: 400,
                      height: gameRepository.acertou(index) ? 400 : 400,
                    ).displayAlert(context)
                  },
                  child: Card(
                    elevation: 8,
                    child: SizedBox(
                      height: 120,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            gameRepository.perguntaAtual
                                .perguntasRespostas![index].respostatexto!,
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 30,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        timer(context),
      ],
    );
  }

  Widget timer(BuildContext context) {
    return CircularCountDownTimer(
      duration: 30,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 5,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 23.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        if (gameRepository.proximaPergunta()) {
          montar_perguntas(context);
        }
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "Próxima!!";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
