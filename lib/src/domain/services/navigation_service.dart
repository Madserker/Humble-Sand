import 'package:humble_sand/core/base/base_provider.dart';
import 'package:humble_sand/core/base/model/screen_model.dart';
import 'package:humble_sand/src/presentation/screens/settings_screen.dart';
import 'package:humble_sand/src/presentation/screens/root_view.dart';
import 'package:flutter/material.dart';

import '../../presentation/screens/home_screen.dart';

class RoutesIndex {
  static const firstScreen = 0;
  static const secondScreen = 1;
  static const thirdScreen = 2;
  static const fourScreen = 3;
}

class Routes {
  static const root = '/main';
  static const login = "/login";
  static const settings = '/main/settings';
  static const home = "/main/home";
  static const test = "main/test";
}

class NavigationService extends BaseProvider {
  int _currentScreenIndex = RoutesIndex.firstScreen;
  int get currentTabIndex => _currentScreenIndex;
  List<ScreenModel> get screens => _screens.values.toList();
  ScreenModel get currentScreen => _screens[_currentScreenIndex]!;

  List<BottomNavigationBarItem> getBottomBarItem() {
    return screens
        .map((screen) => BottomNavigationBarItem(
            icon: screen.icon, label: screen.title, activeIcon: screen.icon))
        .toList();
  }

  List<Navigator> getScreens() {
    return screens
        .map(
          (screen) => Navigator(
            key: screen.navigatorState,
            onGenerateRoute: screen.onGenerateRoute,
          ),
        )
        .toList();
  }

  final Map<int, ScreenModel> _screens = {
    RoutesIndex.firstScreen: ScreenModel(
        title: 'First',
        child: Container(),
        initialRoute: Routes.home,
        navigatorState: GlobalKey<NavigatorState>(),
        icon: const Icon(Icons.home),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.test:
              return MaterialPageRoute(
                  builder: (_) => SafeArea(
                          child: Column(children: const [
                        Text("Test Screen"),
                      ])));
            default:
              return MaterialPageRoute(
                  builder: (_) => HomeScreen(userId: "userId"));
          }
        },
        scrollController: ScrollController(),
        alwaysInitialState: false),
    RoutesIndex.secondScreen: ScreenModel(
        title: 'Settings',
        child: const SettingsScreen(),
        initialRoute: Routes.settings,
        navigatorState: GlobalKey<NavigatorState>(),
        icon: const Icon(Icons.settings),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            default:
              return MaterialPageRoute(builder: (_) => const SettingsScreen());
          }
        },
        scrollController: ScrollController(),
        alwaysInitialState: false),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (_) => RootView());
    }
  }

  void navigateTo(BuildContext context, String routeName,
      {bool isRoot = false, Object? args}) {
    Navigator.of(
      context,
      rootNavigator: isRoot,
    ).pushNamed(routeName, arguments: args);
  }

  void pop(BuildContext context, {bool isRoot = false}) {
    var nav = Navigator.of(
      context,
      rootNavigator: isRoot,
    );
    if (nav.canPop()) {
      nav.pop();
    }
  }

  /// Set currently visible tab.
  void setTab(int tab) {
    if (currentScreen.alwaysInitialState) {
      final currentNavigatorState = currentScreen.navigatorState.currentState!;
      if (currentNavigatorState.canPop()) {
        currentNavigatorState.pop();
      }
    }
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen.scrollController != null &&
        currentScreen.scrollController!.hasClients) {
      currentScreen.scrollController!.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState!;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != RoutesIndex.firstScreen) {
        setTab(RoutesIndex.firstScreen);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => Container(),
        );
      }
    }
  }
}
