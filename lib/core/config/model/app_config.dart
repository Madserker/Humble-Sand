import 'package:humble_sand/core/config/model/enviornment.dart';

class AppConfig {
  final String appName;
  final Environment environment;
  final String baseUrl;
  static AppConfig? _instance;

  AppConfig({
    required this.appName,
    required this.environment,
    required this.baseUrl,
  });
}
