import 'package:humble_sand/core/config/model/app_config.dart';
import 'package:humble_sand/generated/l10n.dart';
import 'package:humble_sand/src/domain/services/navigation_service.dart';
import 'package:humble_sand/src/locator_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:humble_sand/src/presentation/screens/root_view.dart';

import 'core/config/services/app_config_service.dart';

Future<Widget> initializeApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(appConfig);
  return App();
}

class _Constants {
  static const splashScreenMinimumTime = 1500;
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<void> _preConfiguration() async {
    await Future.delayed(
        const Duration(milliseconds: _Constants.splashScreenMinimumTime));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: locator<AppConfigService>().isDebug(),
        onGenerateRoute: locator<NavigationService>().onGenerateRoute,
        home: FutureBuilder(
          future: _preConfiguration(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return RootView();
            }
            //TODO: - ADD SPLASH SCREEN
            return Container();
          },
        ));
  }
}
