import 'package:flutter/material.dart';
import 'package:humble_sand/core/base/base_view.dart';
import 'package:humble_sand/src/presentation/providers/home_provider.dart';

class _Constants {
  static const double bodyPadding = 25;
  static const double buttonHeight = 45;
  static const double playIconSize = 120;
  static const double logoutIconSize = 20;
  static const double userInfoSpaceBetween = 8;
  static const double userInfoTopSpace = 15;
  static const double userInfoRightSpace = 10;
  static const double bodySpaceBetween = 30;
  static const double userInfoFontSize = 18;
}

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeProvider>(
        onModelReady: (model) {},
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(),
              body: Container(),
            ));
  }
}
