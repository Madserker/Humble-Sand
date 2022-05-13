import 'package:get_it/get_it.dart';
import 'package:humble_sand/core/config/model/app_config.dart';
import 'package:humble_sand/core/config/services/app_config_service.dart';
import 'package:humble_sand/core/logs/console_logger.dart';
import 'package:humble_sand/core/logs/logger.dart';
import 'package:humble_sand/src/domain/services/navigation_service.dart';
import 'package:humble_sand/src/domain/services/shared_preferences_service.dart';
import 'package:humble_sand/src/domain/services/translations_service.dart';
import 'package:humble_sand/src/presentation/providers/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(AppConfig appConfig) async {
  registerAppConfigService(appConfig);
  registerSharedPreferencesService();
  registerTranslationsService();

  locator.registerLazySingleton<Logger>(() => ConsoleLogger());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory(() => HomeProvider());
}

void registerAppConfigService(AppConfig appConfig) async {
  locator.registerSingletonAsync<AppConfigService>(
    () async {
      final AppConfigService appConfigservice = AppConfigService();
      appConfigservice.initialize(appConfig);
      return appConfigservice;
    },
  );
}

void registerSharedPreferencesService() async {
  locator.registerSingletonAsync<SharedPreferencesService>(() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return SharedPreferencesService(sharedPref);
  });
}

void registerTranslationsService() async {
  locator.registerSingletonAsync<TranslationsService>(() async {
    final TranslationsService translationsService = TranslationsService();
    await translationsService.loadLanguage();
    return translationsService;
  }, dependsOn: [SharedPreferencesService]);
}
