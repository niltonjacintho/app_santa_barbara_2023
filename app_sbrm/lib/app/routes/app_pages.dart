import 'package:get/get.dart';

import '../modules/agenda/bindings/agenda_binding.dart';
import '../modules/agenda/views/agenda_view.dart';
import '../modules/pastorais/bindings/pastorais_binding.dart';
import '../modules/pastorais/views/pastorais_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.PASTORAIS,
      page: () => const PastoraisView(),
      binding: PastoraisBinding(),
    ),
    GetPage(
      name: _Paths.AGENDA,
      page: () => const AgendaView(),
      binding: AgendaBinding(),
    ),
  ];
}
