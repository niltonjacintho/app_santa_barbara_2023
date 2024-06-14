import 'package:get/get.dart';

import '../../modules/home/home.view.dart';
import '../modules/agenda/bindings/agenda_binding.dart';
import '../modules/agenda/views/agenda_view.dart';
import '../modules/pastorais/bindings/pastorais_binding.dart';
import '../modules/pastorais/views/pastorais_view.dart';
import '../modules/photo/bindings/photo_binding.dart';
import '../modules/photo/views/photo_view.dart';
import '../modules/photoShow/bindings/photo_show_binding.dart';
import '../modules/photoShow/views/photo_show_view.dart';
import '../modules/velario/bindings/velario_binding.dart';
import '../modules/velario/views/velario_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;

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
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VELARIO,
      page: () => const VelarioView(),
      // binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.VELARIO,
          page: () => const VelarioView(),
          binding: VelarioBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PHOTO,
      page: () => const PhotoView(),
      binding: PhotoBinding(),
    ),
    GetPage(
      name: _Paths.PHOTO_SHOW,
      page: () => const PhotoShowView(),
      binding: PhotoShowBinding(),
    ),
  ];
}
