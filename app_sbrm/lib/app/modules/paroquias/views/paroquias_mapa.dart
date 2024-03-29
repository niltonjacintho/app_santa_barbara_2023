import 'package:santa_barbara/app/modules/paroquias/controllers/paroquias.repository.dart';
import 'package:santa_barbara/model/paroquias.model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class ParoquiasMap extends StatefulWidget {
  const ParoquiasMap({super.key});

  @override
  State<ParoquiasMap> createState() => _ParoquiasMapState();
}

class _ParoquiasMapState extends State<ParoquiasMap> {
  late GoogleMapController mapController;
  Set<Marker> markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    for (var element in markers) {
      print(' MAKER IF ========================== ${element.markerId}');
      mapController.showMarkerInfoWindow(element.markerId);
    }
  }

  late ParoquiasRepository paroquiaRepository;
  @override
  Widget build(BuildContext context) {
    paroquiaRepository = Provider.of<ParoquiasRepository>(context);
    for (var i = 1; i < paroquiaRepository.paroquiaAtual.capelas!.length; i++) {
      CapelasInterface element = paroquiaRepository.paroquiaAtual.capelas![i];
      if (element.lat != null && element.long != null) {
        LatLng position = LatLng(element.lat!, element.long!);
        String prefixo = i > 2 ? 'Capela: ' : 'Matriz: ';
        String nome =
            element.nome!.isNotEmpty ? element.nome! : 'Nome não informasdo';
        final Marker m = Marker(
          markerId: MarkerId(element.long.toString()),
          position: position,
          infoWindow: InfoWindow(
              title: prefixo + nome,
              snippet: element.telefone!.isNotEmpty
                  ? element.telefone
                  : 'sem telefone'),
        );
        setState(() {
          markers.add(m);
        });
      }
    }
    final LatLng center = LatLng(paroquiaRepository.paroquiaAtual.lat!,
        paroquiaRepository.paroquiaAtual.long!);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Mapa da paróquia e capelas"),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 16.0,
          ),
        ),
      ),
    );
  }
}
