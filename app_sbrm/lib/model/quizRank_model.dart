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
      {String this.id='',
      this.data,
      String this.email='',
      String this.nome='',
      int this.acertos = 0,
      int this.erros = 0,
      double this.pontos = 0,
      String this.topico=''});

  QuizRankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topico = json['topico'];
    data = json['data'];
    email = json['email'];
    nome = json['nome'];
    acertos = json['acertos'];
    erros = json['erros'];
    pontos = json['pontos'];
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
}
