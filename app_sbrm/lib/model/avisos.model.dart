import 'package:cloud_firestore/cloud_firestore.dart';

class AvisosModel {
  String? ativo;
  String? autor;
  String? conteudo;
  String? dtInclusao;
  String? dtLimiteExibicao;
  String? grupo;
  String? imagem;
  String? likes;
  String? subtitulo;
  String? titulo;
  String? video;
  String? visualizacoes;

  AvisosModel(
      {this.ativo,
      this.autor,
      this.conteudo,
      this.dtInclusao,
      this.dtLimiteExibicao,
      this.grupo,
      this.imagem,
      this.likes,
      this.subtitulo,
      this.titulo,
      this.video,
      this.visualizacoes});

  AvisosModel.fromJson(Map<String, dynamic> json) {
    ativo = json['ativo'];
    autor = json['autor'];
    conteudo = json['conteudo'];
    dtInclusao = json['dtInclusao'];
    dtLimiteExibicao = json['dtLimiteExibicao'];
    grupo = json['grupo'];
    imagem = json['imagem'];
    likes = json['likes'];
    subtitulo = json['subtitulo'];
    titulo = json['titulo'];
    video = json['video'];
    visualizacoes = json['visualizacoes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ativo'] = ativo;
    data['autor'] = autor;
    data['conteudo'] = conteudo;
    data['dtInclusao'] = dtInclusao;
    data['dtLimiteExibicao'] = dtLimiteExibicao;
    data['grupo'] = grupo;
    data['imagem'] = imagem;
    data['likes'] = likes;
    data['subtitulo'] = subtitulo;
    data['titulo'] = titulo;
    data['video'] = video;
    data['visualizacoes'] = visualizacoes;
    return data;
  }


  Future<List<AvisosModel>> recuperarAvisos() async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Cria uma consulta para recuperar todos os avisos
    final query = firestore.collection('avisos').get();

    // Executa a consulta e recupera os resultados
    final snapshot = await query.then((value) => value.docs);

    // Converte os resultados da consulta em uma lista de avisos
    final avisos = snapshot.map((doc) => AvisosModel.fromJson(doc.data())).toList();

    return avisos;
  }

  Future<void> incluirAviso(AvisosModel aviso) async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Cria um documento para o aviso
    final doc = firestore.collection('avisos').doc();

    // Inclui o aviso no Firestore
    await doc.set(aviso.toJson());
  }

  Future<void> excluirAviso(String id) async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Exclui o documento do aviso
    await firestore.collection('avisos').doc(id).delete();
  }

  Future<void> atualizarAviso(AvisosModel aviso) async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Cria um documento para o aviso
    final doc = firestore.collection('avisos').doc(aviso.dtInclusao);

    // Atualiza o aviso no Firestore
    await doc.update(aviso.toJson());
  }

}
