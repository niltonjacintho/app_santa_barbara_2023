import 'package:app_sbrm/app/modules/game/game.perguntas.view.dart';
import 'package:app_sbrm/app/modules/game/game.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  late GameRepository gameRepository;
  CarouselSliderController sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    gameRepository = Provider.of<GameRepository>(context);
    // gameRepository.getTopicos();

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
              image: AssetImage("assets/images/fundoQuiz.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ChangeNotifierProvider<GameRepository>(
            create: (_) => GameRepository(),
            child: Consumer<GameRepository>(
              builder: (context, model, child) => Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 400,
                      child: CarouselSlider.builder(
                        unlimitedMode: true,
                        controller: sliderController,
                        slideBuilder: (index) {
                          return GestureDetector(
                            onTap: () => {
                              gameRepository.setTopico(index),
                              gameRepository.getQuiz(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GamePerguntas()),
                              ),
                            },
                            child: Container(
                              width: 200,
                              alignment: Alignment.center,
                              color: gameRepository.colors[index],
                              child: Text(
                                gameRepository.letters[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 60, color: Colors.white),
                              ),
                            ),
                          );
                        },
                        slideTransform: const CubeTransform(),
                        slideIndicator: CircularSlideIndicator(
                          padding: const EdgeInsets.only(bottom: 32),
                          indicatorBorderColor: Colors.black,
                        ),
                        itemCount: gameRepository.colors.length,
                        initialPage: 0,
                        enableAutoSlider: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
