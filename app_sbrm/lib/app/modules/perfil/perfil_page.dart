import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/app/modules/perfil/perfil.repository.dart';
import './perfil_controller.dart';

class PerfilPage extends GetView<PerfilController> {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late PerfilRepository perfilRepository;
    perfilRepository = Provider.of<PerfilRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PerfilPage'),
      ),
      body: Column(
        children: [
          // Campos de nome, data, email e telefone
          TextField(
            decoration: const InputDecoration(labelText: 'Nome'),
            onChanged: (value) => perfilRepository.perfilAtivo.nome = value,
          ),
          // ... (outros campos)
          ElevatedButton(
            onPressed: () {
              Provider.of<PerfilRepository>(context).createPerfil();
              // ... (outras ações após salvar)
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
