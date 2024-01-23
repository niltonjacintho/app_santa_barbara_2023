
class QuizRankModel {
  String? id;
  DateTime? data;
  String? email;
  String? nome;
  int? acertos = 0;
  int? erros;
  double? pontos;
  String? topico;

  QuizRankModel(
      {String this.id = '',
      this.data,
      String this.email = '',
      String this.nome = '',
      int this.acertos = 0,
      int this.erros = 0,
      double this.pontos = 0,
      String this.topico = ''});

  QuizRankModel fromJson(Map<String, dynamic> json) {
    DateTime d = DateTime.fromMillisecondsSinceEpoch(
        json['data'].millisecondsSinceEpoch);
    QuizRankModel base = QuizRankModel();
    base.id = json['id'];
    base.topico = json['topico'];
    base.data = d;
    base.email = json['email'];
    base.nome = json['nome'];
    base.acertos = json['acertos'];
    base.erros = json['erros'];
    base.pontos = json['pontos'];
    return base;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topico'] = topico;
    data['data'] = this.data;
    data['email'] = email;
    data['nome'] = nome;
    data['acertos'] = acertos;
    data['erros'] = erros;
    data['pontos'] = pontos;
    return data;
  }

  int pontosTotais() {return acertos! - erros!;}
}
