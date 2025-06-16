import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/app_router.dart';
import 'features/product_validation/presentation/pages/validator_page.dart';

void main() {
  runApp(const HPValidatorApp());
}

class HPValidatorApp extends StatelessWidget {
  const HPValidatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validador HP',
      theme: ThemeData(
        primaryColor: const Color(0xFF004F9F),
        textTheme: GoogleFonts.robotoTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: ValidatorPage.routeName,
    );
  }
}
