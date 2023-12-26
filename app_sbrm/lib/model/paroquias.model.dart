import 'package:grock/grock.dart';

class ParoquiaInterface {
  String? id;
  String? nome;
  String? forania;
  String? nascimento;
  String? paroco;
  String? vigario;
  String? diacono;
  String? endereco;
  String? endereco2;
  String? telefones;
  double? lat;
  double? long;
  List<CapelasInterface>? capelas;

  ParoquiaInterface(
      {this.id,
      this.nome,
      this.forania,
      this.nascimento,
      this.paroco,
      this.vigario,
      this.diacono,
      this.endereco,
      this.endereco2,
      this.telefones,
      this.lat,
      this.long,
      this.capelas});

  ParoquiaInterface fromJson(Map<String, dynamic> json) {
    CapelasInterface ci = CapelasInterface();
    ParoquiaInterface p = new ParoquiaInterface();
    p.id = json['id'];
    p.nome = json['nome'] ?? '';
    p.forania = json['forania'] ?? '';
    p.nascimento = json['nascimento'];
    p.paroco = json['paroco'] ?? '';
    ;
    p.vigario = json['vigario'] ?? '';
    p.diacono = json['diacono'] ?? '';
    p.endereco = json['endereco'] ?? '';
    p.endereco2 = json['endereco2'] ?? '';
    p.telefones = json['telefones'] ?? '';
    p.lat = json['lat'];
    p.long = json['long'];
    if (json['capelas'] != null) {
      p.capelas = [];
      num c = 0;
      json['capelas'].forEach((v) {
        if (c == 0) {
          p.telefones = v['telefone'] ?? '';
          p.endereco = v['endereco'] ?? '';
          p.endereco2 = v['endereco2'] ?? '';
          p.telefones = p.telefones!.replaceAll('  ', ' ');
          p.endereco = p.endereco!.replaceAll('  ', ' ');
          p.endereco2 = p.endereco2!.replaceAll('   ', ' ');
        }
        c++;
        p.capelas!.add(ci.fromJson(v));
      });
    }
    return p;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['forania'] = forania;
    data['nascimento'] = nascimento;
    data['paroco'] = paroco;
    data['vigario'] = vigario;
    data['diacono'] = diacono;
    data['endereco'] = endereco;
    data['endereco2'] = endereco2;
    data['telefones'] = telefones;
    data['lat'] = lat;
    data['long'] = long;
    if (capelas != null) {
      data['capelas'] = capelas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CapelasInterface {
  String? nome;
  String? endereco;
  String? endereco2;
  String? telefone;
  double? lat;
  double? long;

  CapelasInterface(
      {this.nome,
      this.endereco,
      this.endereco2,
      this.telefone,
      this.lat,
      this.long});

  CapelasInterface fromJson(Map<String, dynamic> json) {
    CapelasInterface c = CapelasInterface();
    c.nome = json['nome'] ?? '';
    c.endereco = json['endereco'] ?? '';
    c.endereco2 = json['endereco2'] ?? '';
    c.telefone = json['telefone'] ?? '';
    c.lat = json['lat'];
    c.long = json['long'];
    return c;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nome'] = nome;
    data['endereco'] = endereco;
    data['endereco2'] = endereco2;
    data['telefone'] = telefone;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
