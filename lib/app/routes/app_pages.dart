import 'package:get/get.dart';
import 'package:shield/app/bindings/guides_cover_bindings.dart';
import 'package:shield/app/bindings/login_bindings.dart';
import 'package:shield/app/bindings/navigation_bindings.dart';
import 'package:shield/app/bindings/volunteers_binding.dart';
import 'package:shield/app/views/pages/guides_cover_page.dart';
import 'package:shield/app/views/pages/login_page.dart';
import 'package:shield/app/views/pages/navigation_bar.dart';
import 'package:shield/app/views/pages/signup_page.dart';
import 'package:shield/app/views/pages/volunteers_page.dart';

import '../bindings/guides_bindings.dart';
import '../bindings/maps_bindings.dart';
import '../bindings/signup_bindigs.dart';
import '../bindings/splash_bindings.dart';
import '../views/pages/guides_page.dart';
import '../views/pages/map_screen.dart';
import '../views/pages/splash_screen.dart';

// Import other bindings and page classes here...

part 'app_routes.dart';

class AppPages {
  // Define the initial route for your app
  static const initial = Routes.splash;

  // Define the routes for your app's pages
  static final routes = [
    // Example route with a Fade In transition animation
    GetPage(
      name: Routes.navigation, // Route name
      page: () => NavigationBar(), // Page widget
      binding: NavigationBinding(), // Binding for this route
      transition: Transition.fadeIn, // Animation: Fade In
    ),
    // Add comments and transitions for other routes below
    GetPage(
      name: Routes.splash, // Route name
      page: () => const SplashScreen(), // Page widget
      binding: SplashBinding(), // Binding for this route
      transition: Transition.fadeIn, // Animation: Fade In
    ),
    GetPage(
      name: Routes.signup, // Route name
      page: () => const SignUpScreen(), // Page widget
      binding: SignUpBinding(), // Binding for this route
      transition: Transition.fadeIn, // Animation: Fade In
    ),
    GetPage(
      name: Routes.login, // Route name
      page: () => const LoginPage(), // Page widget
      binding: LoginBinding(), // Binding for this route
      transition: Transition.fadeIn, // Animation: Fade In
    ),
    GetPage(
      name: Routes.volunteers, // Route name
      page: () => const VolunteersPage(), // Page widget
      binding: VolunteersBinding(), // Binding for this route
      transition: Transition.fadeIn, // Animation: Fade In
    ),
    GetPage(
      name: Routes.maps, // Route name
      page: () => const MapScreen(), // Page widget
      binding: MapsBinding(), // Binding for this route
      transition: Transition.fadeIn, // Animation: Fade In
    ),
    GetPage(
        name: Routes.guidesCover,
        page: (() => GuidesCoverPage()),
        binding: GuidesCoverBinding(),
        transition: Transition.cupertinoDialog),

    GetPage(
        name: Routes.guides,
        page: (() => GuidesPage()),
        binding: GuidesBinding(),
        transition: Transition.cupertinoDialog),
    // Add more routes with comments and transitions here...
  ];
}
