class VelaModel {
  String? id;
  DateTime? data;
  String? intencao;
  int? minutosrestantes;
  String? destinatario;
  String? solicitanteemail;
  String? solicitantenome;
  String? texto;
  DateTime? dataInclusao;
  DateTime? dataAlteracao;

  VelaModel(
      {this.id,
      this.data,
      this.intencao,
      this.minutosrestantes,
      this.destinatario,
      this.solicitanteemail,
      this.solicitantenome,
      this.texto,
      this.dataInclusao,
      this.dataAlteracao});

  VelaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    data = json['data'];
    intencao = json['intencao'];
    minutosrestantes = json['minutosrestantes'];
    destinatario = json['destinatario'];
    solicitanteemail = json['solicitanteemail'];
    solicitantenome = json['solicitantenome'];
    texto = json['texto'];
    dataInclusao = json['dataInclusao'];
    dataInclusao = json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['data'] = this.data;
    data['intencao'] = intencao;
    data['minutosrestantes'] = minutosrestantes;
    data['destinatario'] = destinatario;
    data['solicitanteemail'] = solicitanteemail;
    data['solicitantenome'] = solicitantenome;
    data['texto'] = texto;
    data['dataInclusao'] = dataInclusao;
    data['dataAlteracao'] = dataAlteracao;
    return data;
  }
}
