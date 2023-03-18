import 'package:app1/app/d_i.dart';
import 'package:app1/presentation/forgetPassword/forget_password_view.dart';
import 'package:app1/presentation/login/view/login_view.dart';
import 'package:app1/presentation/main/main_view.dart';
import 'package:app1/presentation/onBoarding/view/onboarding_view.dart';
import 'package:app1/presentation/register/register_view.dart';
import 'package:app1/presentation/resources/strings_manager.dart';
import 'package:app1/presentation/splash/splash_view.dart';
import 'package:app1/presentation/store_details/store_details_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRouts = "/main";
  static const String storeDetailsRouts = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.mainRouts:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRouts:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
