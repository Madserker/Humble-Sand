import 'package:flutter/material.dart';
import 'package:humble_sand/core/base/base_provider.dart';
import 'package:humble_sand/src/locator_manager.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseProvider> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;

  const BaseView({Key? key, required this.builder, required this.onModelReady})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseProvider> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    widget.onModelReady(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: model, child: Consumer<T>(builder: widget.builder));
  }
}
