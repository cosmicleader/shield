// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';
import 'package:shield/app/bindings/volunteers_binding.dart';
import 'package:shield/app/views/pages/volunteers_page.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.volunteers;

  static final routes = [
    GetPage(
      name: Routes.volunteers,
      page: () => const VolunteersPage(),
      binding: VolunteersBinding(),
      // children: [
      //   GetPage(
      //     name: Routes.COUNTRY,
      //     page: () => const CountryView(),
      //     children: [
      //       GetPage(
      //         name: Routes.DETAILS,
      //         page: () => const DetailsView(),
      //       ),
      //     ],
      //   ),
      // ],
    ),
  ];
}
