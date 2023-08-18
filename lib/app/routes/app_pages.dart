// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';
import 'package:shield/app/bindings/login_bindings.dart';
import 'package:shield/app/bindings/volunteers_binding.dart';
import 'package:shield/app/views/pages/login_page.dart';
import 'package:shield/app/views/pages/volunteers_page.dart';

import '../bindings/guides_bindings.dart';
import '../bindings/guides_cover_bindings.dart';
import '../bindings/profile_bindings.dart';
import '../bindings/resources_bindings.dart';
import '../bindings/splash_bindings.dart';
import '../views/pages/guides_cover_page.dart';
import '../views/pages/guides_page.dart';
import '../views/pages/profile_page.dart';
import '../views/pages/resources_page.dart';
import '../views/pages/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.volunteers,
      page: () => const VolunteersPage(),
      binding: VolunteersBinding(),
    ),
    GetPage(
        name: Routes.guidesCover,
        page: () => const GuidesCoverPage(),
        binding: GuidesCoverBinding(),
        children: [
          GetPage(
            name: Routes.guides,
            page: () => const GuidesPage(),
            binding: GuidesBinding(),
          ),
        ]),
    GetPage(
      name: Routes.resources,
      page: () => const ResourcesPage(),
      binding: ResourcesBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
