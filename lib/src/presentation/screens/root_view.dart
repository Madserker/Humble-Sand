import 'package:flutter/material.dart';

import '../../../core/base/base_view.dart';
import '../../domain/services/navigation_service.dart';
import '../styles/custom_colors.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<NavigationService>(
        onModelReady: (model) {},
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () async => model.onWillPop(context),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: IndexedStack(
                children: model.getScreens(),
                index: model.currentTabIndex,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: model.getBottomBarItem(),
                currentIndex: model.currentTabIndex,
                onTap: model.setTab,
                selectedItemColor: CustomColors.selectedColor,
                unselectedItemColor: CustomColors.unselectedColor,
              ),
            ),
          );
        });
  }
}
