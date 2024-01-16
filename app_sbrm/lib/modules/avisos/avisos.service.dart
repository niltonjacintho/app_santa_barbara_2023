import 'package:santa_barbara/model/avisos.interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisoService {
  final AvisoInterface _aviso = AvisoInterface();

  inicializarAviso() {
    _aviso.ativo = '';
    _aviso.autor = '';
    _aviso.conteudo = '';
    _aviso.dtInclusao;
    _aviso.dtLimiteExibicao;
    _aviso.grupo = '';
    _aviso.imagem = '';
    _aviso.likes = 0;
    _aviso.subtitulo = '';
    _aviso.titulo = '';
    _aviso.video = '';
    _aviso.visualizacoes = 0;
  }

  AvisoInterface fromJson(Map<String, dynamic> json) {
    _aviso.ativo = json['ativo'].toString();
    _aviso.id = json['id'];
    _aviso.autor = json['autor'];
    _aviso.conteudo = json['conteudo'];
    // _aviso.dtInclusao = json['dtInclusao'];
    // _aviso.dtLimiteExibicao = json['dtLimiteExibicao'];
    _aviso.grupo = json['grupo'];
    _aviso.imagem = json['imagem'];
    _aviso.likes = json['likes'];
    _aviso.subtitulo = json['subtitulo'];
    _aviso.titulo = json['titulo'];
    _aviso.video = json['video'];
    _aviso.visualizacoes = json['visualizacoes'];
    return _aviso;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ativo'] = _aviso.ativo;
    data['autor'] = _aviso.autor;
    data['conteudo'] = _aviso.conteudo;
    data['dtInclusao'] = _aviso.dtInclusao;
    data['dtLimiteExibicao'] = _aviso.dtLimiteExibicao;
    data['grupo'] = _aviso.grupo;
    data['imagem'] = _aviso.imagem;
    data['likes'] = _aviso.likes;
    data['subtitulo'] = _aviso.subtitulo;
    data['titulo'] = _aviso.titulo;
    data['video'] = _aviso.video;
    data['visualizacoes'] = _aviso.visualizacoes;
    return data;
  }

  Future<List<AvisoInterface>> recuperarAvisos() async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Cria uma consulta para recuperar todos os avisos
    final query = firestore.collection('artigos').get();

    // Executa a consulta e recupera os resultados
    final snapshot = await query.then((value) => value.docs);

    // Converte os resultados da consulta em uma lista de avisos
    final avisos = snapshot.map((doc) => fromJson(doc.data())).toList();
    print('jjjjj ${avisos[0].id}');
    return avisos;
  }

  Future<void> incluirAviso(AvisoInterface aviso) async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Cria um documento para o aviso
    final doc = firestore.collection('avisos').doc();

    // Inclui o aviso no Firestore
    await doc.set(toJson());
  }

  Future<void> excluirAviso(String id) async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Exclui o documento do aviso
    await firestore.collection('avisos').doc(id).delete();
  }

  Future<void> atualizarAviso(AvisoInterface aviso) async {
    // Inicializa o Firestore
    final firestore = FirebaseFirestore.instance;

    // Cria um documento para o aviso
    final doc = firestore.collection('avisos').doc(aviso.id);

    // Atualiza o aviso no Firestore
    await doc.update(toJson());
  }
}
