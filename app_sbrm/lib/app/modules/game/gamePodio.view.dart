import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/app/modules/game/game.repository.dart';
import 'package:santa_barbara/model/quizRank_model.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';

class GamePodio extends StatefulWidget {
  const GamePodio({super.key});

  @override
  State<GamePodio> createState() => _GamePodioState();
}

class _GamePodioState extends State<GamePodio> {
  late GameRepository gameRepository;
  late UserRepository userRepository;
  //late CrossFadeState
  bool crossFadeState = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gameRepository = Provider.of<GameRepository>(context);
    userRepository = Provider.of<UserRepository>(context);
    gameRepository.getWinners();
    return FutureBuilder(
      future: gameRepository.getWinners(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var winners = snapshot.data as List<QuizRankModel>;
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fundoQuiz_vazio.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  StatefulBuilder(builder: (ctx, setState) {
                    Future.delayed(
                        const Duration(seconds: 5),
                        () => setState(() => gameRepository.crossState =
                            !gameRepository.crossState));
                    return AnimatedCrossFade(
                      duration: const Duration(milliseconds: 500),
                      firstChild: parabens(context),
                      secondChild: pontos(context),
                      crossFadeState: gameRepository.crossState
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    );

                    // gameRepository.crossState
                    //     ? parabens(context)
                    //     : pontos(context), crossFadeState: null,;
                  }),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 40, right: 40, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white24,
                        ),
                        child: const Text(
                          'Estes são nossos irmãos que mais pontuaram',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            decoration: TextDecoration.none,
                          ),
                        )),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: winners.length,
                        itemBuilder: (context, index) {
                          var winner = winners[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 50, right: 50),
                            child: Card(
                                elevation: 5,
                                child: ListTile(
                                    leading: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(fontSize: 40),
                                    ),
                                    trailing: Text('${winner.pontos}',
                                        style: const TextStyle(fontSize: 30)),
                                    title: Text('${winner.nome}',
                                        style: const TextStyle(fontSize: 30)))),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        elevation: 10,
                        shadowColor: const Color(0x00000018),
                        fixedSize: const Size(200, 60),
                        backgroundColor:
                            Colors.black, // background (button) color
                        foregroundColor:
                            Colors.white, // foreground (text) color
                      ),
                      onPressed: () {
                        GoRouter.of(context).go('/home');
                      },
                      child: const Text('Voltar'),
                    ),
                  )
                ],
              ),
            );
          }
        }

        // Loading indicator
        return const CircularProgressIndicator();
      },
    );
  }

  Widget parabens(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Text(
              'PARABÉNS ${userRepository.usuario.nome!.toUpperCase()} ',
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              '${gameRepository.basePontos.pontos} pontos',
              style: const TextStyle(fontSize: 50),
            ),
            const Text(
              'MUITO BEM!!!',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget pontos(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Text(
              '${gameRepository.basePontos.pontos} pontos',
              style: const TextStyle(fontSize: 80),
            ),
          ],
        ),
      ),
    );
  }
}
