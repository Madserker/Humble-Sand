import 'package:flutter/material.dart';

import 'core/config/model/app_config.dart';
import 'core/config/model/enviornment.dart';
import 'main.dart';

void main() async {
  Widget app = await initializeApp(AppConfig(
    appName: 'Flutter Base Template',
    environment: Environment.pro,
    baseUrl: '',
  ));
  runApp(app);
}
