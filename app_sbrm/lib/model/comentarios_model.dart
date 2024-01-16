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
}
