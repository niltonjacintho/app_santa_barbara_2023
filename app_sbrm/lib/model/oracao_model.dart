class OracoesModel {
  List<Grupo>? grupo;

  OracoesModel({this.grupo});

  OracoesModel.fromJson(Map<String, dynamic> json) {
    if (json['grupo'] != null) {
      grupo = [];
      
      json['grupo'].forEach((v) {
        grupo!.add(Grupo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (grupo != null) {
      data['grupo'] = grupo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grupo {
  String? id;
  String? nome;
  String? url;
  List<Oracoes>? oracoes;

  Grupo({this.id, this.nome, this.url, this.oracoes});

  Grupo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    url = json['url'];
    if (json['oracoes'] != null) {
      oracoes =[];
      json['oracoes'].forEach((v) {
        oracoes!.add(Oracoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['url'] = url;
    if (oracoes != null) {
      data['oracoes'] = oracoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Oracoes {
  String? id;
  String? titulo;
  String? texto;

  Oracoes({this.id, this.titulo, this.texto});

  Oracoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['texto'] = texto;
    return data;
  }
}
