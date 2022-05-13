import 'package:flutter/material.dart';
import 'package:humble_sand/main.dart';

import 'core/config/model/app_config.dart';
import 'core/config/model/enviornment.dart';

void main() async {
  Widget app = await initializeApp(AppConfig(
    appName: 'DEV',
    environment: Environment.dev,
    baseUrl: '',
  ));
  runApp(app);
}
