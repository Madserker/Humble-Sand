import 'package:flutter/material.dart';
import 'package:humble_sand/core/base/model/view_state.dart';
import 'package:humble_sand/core/logs/logger.dart';
import 'package:humble_sand/src/locator_manager.dart';

abstract class BaseProvider extends ChangeNotifier {
  final Logger logger = locator.get<Logger>();

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
