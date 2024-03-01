import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'locator.dart';
import 'core/core.dart';

void main() {
  setupLocator();

  initializeDateFormatting('tr_TR', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConst.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        colorScheme: AppColorScheme.light.colorScheme,
        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        useMaterial3: true,
      ),
    );
  }
}
