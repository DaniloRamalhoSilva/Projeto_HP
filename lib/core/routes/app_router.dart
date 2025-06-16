import 'package:flutter/material.dart';

import '../../features/product_validation/presentation/pages/validator_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ValidatorPage.routeName:
      default:
        return MaterialPageRoute(
          builder: (_) => const ValidatorPage(),
          settings: settings,
        );
    }
  }
}
