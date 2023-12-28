import 'package:app_sbrm/app/modules/game/game.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
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
    gameRepository.getTopicos();

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
              builder: (context, model, child) => Container(
                color: Colors.black,
                child: UnconstrainedBox(
                  child: Container(
                    width: 600,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10)
                      ],
                    ),
                    child: Center(
                      child: Text(
                        gameRepository.letters[gameRepository.topicoEscolhido],
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.amber,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                //    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
