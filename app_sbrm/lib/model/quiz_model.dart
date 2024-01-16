import 'package:flutter/material.dart';

class QuizDB {
  QuizDb? quizDb;

  QuizDB({required this.quizDb});

  QuizDB.fromJson(Map<String, dynamic> json) {
    quizDb =
        json['quizDb'] != null ? QuizDb.fromJson(json['quizDb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quizDb != null) {
      data['quizDb'] = quizDb!.toJson();
    }
    return data;
  }
}

class QuizDb {
  List<BaseTopicos>? baseTopicos;
  List<Quiz>? quiz;
  List<Desafios>? desafios;
  BasePerguntas? basePerguntas;

  QuizDb(
      {required this.baseTopicos,
      required this.quiz,
      required this.desafios,
      required this.basePerguntas});

  QuizDb.fromJson(Map<String, dynamic> json) {
    BasePerguntas p = BasePerguntas();
    BaseTopicos b = BaseTopicos();
    if (json['baseTopicos'] != null) {
      baseTopicos = [];
      json['baseTopicos'].forEach((v) {
        baseTopicos!.add(b.fromJson(v));
      });
    }
    if (json['quiz'] != null) {
      quiz = [];
      json['quiz'].forEach((v) {
        quiz!.add(Quiz.fromJson(v));
      });
    }
    if (json['desafios'] != null) {
      desafios = [];
      json['desafios'].forEach((v) {
        desafios!.add(Desafios.fromJson(v));
      });
    }
    basePerguntas = json['basePerguntas'] != null
        ? p.fromJson(json['basePerguntas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (baseTopicos != null) {
      data['baseTopicos'] = baseTopicos!.map((v) => v.toJson()).toList();
    }
    if (quiz != null) {
      data['quiz'] = quiz!.map((v) => v.toJson()).toList();
    }
    if (desafios != null) {
      data['desafios'] = desafios!.map((v) => v.toJson()).toList();
    }
    if (basePerguntas != null) {
      data['basePerguntas'] = basePerguntas!.toJson();
    }
    return data;
  }
}

class BaseTopicos {
  String? id = '';
  String? nome = '';
  Color? cor;

  get getIdBase => nome!.trim().replaceAll(' ', '').toLowerCase();

  BaseTopicos({this.id, this.nome, this.cor});

  fromJson(Map<String, dynamic> data) {
    BaseTopicos base = BaseTopicos();
    base.id = data['id'];
    base.nome = data['nome'];
    base.cor = data['cor'];
    return base;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['cor'] = cor;
    return data;
  }
}

class Quiz {
  String id = '';
  String titulo = '';
  List<QuizTopico>? quizTopicos = [];
  String recomendacoes = '';
  String qtdperguntas = '';
  List<QuizPerguntas>? quizPerguntas = [];

  Quiz(
      {this.id = '',
      this.titulo = '',
      this.quizTopicos,
      this.recomendacoes = '',
      this.qtdperguntas = '',
      this.quizPerguntas});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    if (json['quizTopico'] != null) {
      quizTopicos = [];
      json['quizTopico'].forEach((v) {
        quizTopicos!.add(QuizTopico.fromJson(v));
      });
    }
    recomendacoes = json['recomendacoes'];
    qtdperguntas = json['qtdperguntas'];
    if (json['quizPerguntas'] != null) {
      quizPerguntas = [];
      json['quizPerguntas'].forEach((v) {
        quizPerguntas!.add(QuizPerguntas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    if (quizTopicos != null) {
      data['quizTopico'] = quizTopicos!.map((v) => v.toJson()).toList();
    }
    data['recomendacoes'] = recomendacoes;
    data['qtdperguntas'] = qtdperguntas;
    if (quizPerguntas != null) {
      data['quizPerguntas'] =
          quizPerguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizTopico {
  String? idTopico;

  QuizTopico({this.idTopico});

  QuizTopico.fromJson(Map<String, dynamic> json) {
    idTopico = json['idTopico'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTopico'] = idTopico;
    return data;
  }
}

class QuizPerguntas {
  String? id;

  QuizPerguntas({this.id});

  QuizPerguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Desafios {
  String? id;
  String? idQuiz;
  bool? finalizado;
  DateTime? data;
  String? email;
  int? acertos;
  int? tempo;
  List<DesafioPerguntas>? desafioPerguntas;

  Desafios(
      {this.id,
      this.idQuiz,
      this.finalizado,
      this.data,
      this.email,
      this.acertos,
      this.tempo,
      this.desafioPerguntas});

  Desafios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idQuiz = json['idQuiz'];
    finalizado = json['finalizado'];
    data = json['data'];
    email = json['email'];
    acertos = json['acertos'];
    tempo = json['tempo'];
    if (json['desafioPerguntas'] != null) {
      desafioPerguntas = [];
      json['desafioPerguntas'].forEach((v) {
        desafioPerguntas!.add(DesafioPerguntas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idQuiz'] = idQuiz;
    data['finalizado'] = finalizado;
    data['data'] = this.data;
    data['email'] = email;
    data['acertos'] = acertos;
    data['tempo'] = tempo;
    if (desafioPerguntas != null) {
      data['desafioPerguntas'] =
          desafioPerguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DesafioPerguntas {
  String? id;
  bool? acertou;

  DesafioPerguntas({this.id, this.acertou});

  DesafioPerguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acertou = json['acertou'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['acertou'] = acertou;
    return data;
  }
}

class BasePerguntas {
  String? id;
  String? idTopico;
  String? pergunta;
  List<PerguntasRespostas>? perguntasRespostas;

  BasePerguntas(
      {this.id, this.idTopico, this.pergunta, this.perguntasRespostas});

  BasePerguntas fromJson(Map<String, dynamic> json) {
    BasePerguntas p = BasePerguntas();
    p.id = json['id'];
    p.idTopico = json['idTopico'];
    p.pergunta = json['pergunta'];
    if (json['perguntasRespostas'] != null) {
      p.perguntasRespostas = [];
      json['perguntasRespostas'].forEach((v) {
        PerguntasRespostas r = PerguntasRespostas();
        p.perguntasRespostas!.add(r.fromJson(v));
      });
    }
    return p;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTopico'] = idTopico;
    data['pergunta'] = pergunta;
    if (perguntasRespostas != null) {
      data['perguntasRespostas'] =
          perguntasRespostas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PerguntasRespostas {
  String? id;
  int? sequencia;
  bool? respostacerta;
  String? respostatexto;

  PerguntasRespostas(
      {this.id, this.sequencia, this.respostacerta, this.respostatexto});

  PerguntasRespostas fromJson(Map<String, dynamic> json) {
    PerguntasRespostas r = PerguntasRespostas();
    r.id = json['id'];
    r.sequencia = json['sequencia'];
    r.respostacerta = json['respostacerta'];
    r.respostatexto = json['respostatexto'];
    return r;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sequencia'] = sequencia;
    data['respostacerta'] = respostacerta;
    data['respostatexto'] = respostatexto;
    return data;
  }
}
