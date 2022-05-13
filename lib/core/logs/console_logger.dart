import 'package:humble_sand/core/config/services/app_config_service.dart';
import 'package:humble_sand/src/locator_manager.dart';
import 'package:humble_sand/core/config/services/app_config_service.dart';
import 'package:humble_sand/src/locator_manager.dart';
import 'logger.dart';

class ConsoleLogger extends Logger {
  @override
  void log(String msg) {
    if (locator.get<AppConfigService>().isDev()) {
      print('${DateTime.now()} : $msg');
    }
  }
}
