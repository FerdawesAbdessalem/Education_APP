import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wirdi_app/data/wird_repository.dart';
import 'package:wirdi_app/state/app_state.dart';
import 'package:wirdi_app/ui/auth/welcome_page.dart';
import 'package:wirdi_app/ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(LocalWirdRepository())..init(),
      child: const WirdiApp(),
    ),
  );
}

class WirdiApp extends StatelessWidget {
  const WirdiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loaded = context.select<AppState, bool>((s) => s.loaded);
    return MaterialApp(
      title: 'وِردي',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      // Arabic, right-to-left interface.
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('fr'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: loaded ? const WelcomePage() : const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
