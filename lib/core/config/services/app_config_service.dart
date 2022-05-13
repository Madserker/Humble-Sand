import 'package:humble_sand/core/config/model/app_config.dart';
import 'package:humble_sand/core/config/model/enviornment.dart';
import 'package:flutter/foundation.dart';

class AppConfigService {
  late AppConfig? instance;

  initialize(AppConfig appConfig) => instance = appConfig;

  bool isDev() => instance?.environment == Environment.dev;
  bool isProd() => instance?.environment == Environment.pro;
  bool isRelease() => kReleaseMode;
  bool isDebug() => kDebugMode;
}
