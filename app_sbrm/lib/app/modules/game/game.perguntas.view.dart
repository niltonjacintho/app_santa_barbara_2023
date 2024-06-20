import 'package:go_router/go_router.dart';
import 'package:santa_barbara/app/modules/game/game.repository.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';

class GamePerguntas extends StatefulWidget {
  const GamePerguntas({super.key});

  @override
  State<GamePerguntas> createState() => _GamePerguntasState();
}

class _GamePerguntasState extends State<GamePerguntas> {
  late GameRepository gameRepository;
  late UserRepository userRepository;
  final CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    gameRepository = Provider.of<GameRepository>(context);
    userRepository = Provider.of<UserRepository>(context);
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
                      child: Center(
                        child: Text(
                          'Tema: ${gameRepository.letters[gameRepository.topicoEscolhido]}',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  //   ),
                  const SizedBox(
                    height: 10,
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
                      fontSize: 25,
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
                        gameRepository.gravarPontos(
                            int.parse(_controller.getTime()!), index);
                        if (gameRepository.proximaPergunta()) {
                          montar_perguntas(context);
                          Navigator.of(context, rootNavigator: true).pop();
                        } else {
                          gameRepository.salvarRank(userRepository.usuario);
                          GoRouter.of(context).go('/gamepodio');
                          // Navigator.of(context, rootNavigator: true).pop();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const GamePodio()));
                        }
                        //gameRepository.perguntaAtual.perguntasRespostas= PerguntasRespostas();
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
                      height: 80,
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: FittedBox(
                            child: Text(
                              gameRepository.perguntaAtual
                                  .perguntasRespostas![index].respostatexto!,
                              style: GoogleFonts.oswald(
                                  textStyle: const TextStyle(
                                fontSize: 20,
                              )),
                            ),
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
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 4,
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
        // if (gameRepository.proximaPergunta()) {
        //   montar_perguntas(context);
        // }
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "Vamos";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
