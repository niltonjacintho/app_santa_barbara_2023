class ComentariosModel {
  String? usuario;
  DateTime? data;
  String? texto;

  ComentariosModel({this.usuario, this.data, this.texto});

  ComentariosModel.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    data = json['data'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usuario'] = usuario;
    data['data'] = this.data;
    data['texto'] = texto;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'data': data,
      'texto': texto,
    };
  }

  factory ComentariosModel.fromMap(Map<String, dynamic> data) {
    return ComentariosModel(
      usuario: data['usuario'],
      data: data['data'] != null ? (data['data']).toDate() : null,
      texto: data['texto'],
    );
  }
}
