import 'package:adm/model/comentarios.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtigosModel {
  String? documentID = '';
  bool? ativo = false;
  String? categoria = '';
  String? titulo = '';
  String? subtitulo = '';
  String? texto = '';
  DateTime? dataCriacao = DateTime.now();
  String? autorAutor = '';
  String? evento = '';
  String? image = '';
  String? video = '';
  String? audio = '';
  DateTime? dataValidade = DateTime.now();
  int? visualizacoes = 0;
  List<ComentariosModel>? comentarios;

  ArtigosModel(
      {this.documentID,
      this.ativo,
      this.categoria,
      this.titulo,
      this.subtitulo,
      this.texto,
      this.dataCriacao,
      this.autorAutor,
      this.evento,
      this.image,
      this.video,
      this.audio,
      this.dataValidade,
      this.visualizacoes,
      this.comentarios});

  ArtigosModel.fromJson(Map<String, dynamic> json) {
    documentID = json['documentID'];
    ativo = json['ativo'];
    categoria = json['categoria'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    texto = json['texto'];
    dataCriacao = json['data_criacao'];
    autorAutor = json['autor_autor'];
    evento = json['evento'];
    image = json['image'];
    video = json['video'];
    audio = json['audio'];
    dataValidade = json['data_validade'];
    visualizacoes = json['visualizacoes'];
    if (json['comentarios'] != null) {
      comentarios = [];
      json['comentarios'].forEach((v) {
        comentarios!.add(ComentariosModel.fromJson(v));
      });
    }
  }

  ArtigosModel.fromfirestoresnapshot(DocumentSnapshot snap)
      : documentID = snap.id,
        ativo = snap.get('ativo'),
        titulo = snap.get('titulo'),
        subtitulo = snap.get('subtitulo'),
        texto = snap.get('conteudo'),
        dataCriacao = snap.get('dtInclusao') == null
            ? DateTime.now()
            : snap.get('dtInclusao').toDate(),
        autorAutor = snap.get('autor') ?? '',
        image = snap.get('imagem') ?? '',
        video = snap.get('video') ?? '',
        dataValidade = snap.get('dtLimiteExibicao') == null
            ? DateTime.now()
            : snap.get('dtLimiteExibicao').toDate();
  toJson() {
    return {
      'documentID': documentID,
      'ativo': ativo,
      'categoria': categoria,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'texto': texto,
      'dataCriacao': dataCriacao,
      'autorAutor': autorAutor,
      'evento': evento,
      'image': image,
      'video': video,
      'audio': audio,
      'dataValidade': dataValidade,
      'visualizacoes': visualizacoes,
      'comentarios': comentarios
    };
  }

  Map<String, dynamic> toJson2() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ativo'] = ativo;
    data['categoria'] = categoria;
    data['titulo'] = titulo;
    data['subtitulo'] = subtitulo;
    data['texto'] = texto;
    data['data_criacao'] = dataCriacao;
    data['autor_autor'] = autorAutor;
    data['evento'] = evento;
    data['image'] = image;
    data['video'] = video;
    data['audio'] = audio;
    data['data_validade'] = dataValidade;
    data['visualizacoes'] = visualizacoes;
    if (comentarios != null) {
      data['comentarios'] = comentarios!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'documentID': documentID,
      'ativo': ativo,
      'categoria': categoria,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'texto': texto,
      'dataCriacao': dataCriacao,
      'autorAutor': autorAutor,
      'evento': evento,
      'image': image,
      'video': video,
      'audio': audio,
      'dataValidade': dataValidade,
      'visualizacoes': visualizacoes,
      'comentarios': comentarios != null
          ? comentarios!.map((comentario) => comentario.toMap()).toList()
          : null, // Mapeia os comentários se houver
    };
  }

  factory ArtigosModel.fromMap(Map<String, dynamic> data) {
    return ArtigosModel(
      documentID: data['documentID'],
      ativo: data['ativo'],
      categoria: data['categoria'],
      titulo: data['titulo'],
      subtitulo: data['subtitulo'],
      texto: data['texto'],
      dataCriacao: data['dataCriacao']?.toDate(),
      autorAutor: data['autorAutor'],
      evento: data['evento'],
      image: data['image'],
      video: data['video'],
      audio: data['audio'],
      dataValidade: data['dataValidade']?.toDate(),
      visualizacoes: data['visualizacoes'],
      comentarios: (data['comentarios'] as List<Map<String, dynamic>>?)
          ?.map((comentarioData) {
        return ComentariosModel.fromMap(comentarioData);
      }).toList(),
    );
  }

  ArtigosModel init() {
    ArtigosModel retorno = ArtigosModel();
    retorno.documentID = '';
    retorno.ativo = false;
    retorno.categoria = '';
    retorno.titulo = '';
    retorno.subtitulo = '';
    retorno.texto = '';
    retorno.dataCriacao = DateTime.now();
    retorno.autorAutor = '';
    retorno.evento = '';
    retorno.image = '';
    retorno.video = '';
    retorno.audio = '';
    retorno.dataValidade = DateTime.now();
    retorno.visualizacoes = 0;
    return retorno;
  }
}
