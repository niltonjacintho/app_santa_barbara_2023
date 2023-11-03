import 'package:adm/model/artigo.model.dart';
import 'package:adm/modules/avisos/avisos.service.dart';
import 'package:flutter/material.dart';

class AvisoScreen extends StatefulWidget {
  const AvisoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AvisoScreenState createState() => _AvisoScreenState();
}

class _AvisoScreenState extends State<AvisoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aviso = ArtigosModel();
  final AvisoService avisoService = AvisoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Entrada'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Título'),
              onSaved: (value) => _aviso.titulo = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'O título é obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Subtítulo'),
              onSaved: (value) => _aviso.subtitulo = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Texto'),
              onSaved: (value) => _aviso.texto = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'O texto é obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Autor'),
              onSaved: (value) => _aviso.autorAutor = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'URL da imagem'),
              onSaved: (value) => _aviso.image = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  avisoService
                      .gravarEntrada(_aviso); // Salva os dados no Firestore
                  Navigator.pop(context);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
