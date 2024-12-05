class PerfilModel {
  PerfilModel({
    required this.nome,
    required this.nascimento,
    required this.telefone,
    required this.createDate,
    required this.updateDate,
  });

  late final dynamic nome;
  final dynamic nascimento;
  final dynamic telefone;
  final dynamic createDate;
  final dynamic updateDate;

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      nome: json["nome"],
      nascimento: json["nascimento"],
      telefone: json["telefone"],
      createDate: json["createDate"],
      updateDate: json["updateDate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "nascimento": nascimento,
        "telefone": telefone,
        "createDate": createDate,
        "updateDate": updateDate,
      };
}
