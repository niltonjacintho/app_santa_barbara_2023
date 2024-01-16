// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:santabarbara/app/models/comentarios_model.dart';

class Grupos {
  String? id;
  String? titulo;
  int? value;
  String? cor;

  Grupos({this.id, this.titulo, this.value, this.cor});

  Grupos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    value = json['value'];
    cor = json['cor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['value'] = value;
    data['cor'] = cor;
    return data;
  }
}
