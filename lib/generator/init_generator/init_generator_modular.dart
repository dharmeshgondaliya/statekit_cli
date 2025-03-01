import 'package:statekit_cli/generator/init_generator/init_generator.dart';

abstract class InitGeneratorModular extends InitGenerator {
  static const String routeNavigatorFileContent = """import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';
import '../modules/dashboard/home_screen/controller/home_screen_controller.dart';
import '../modules/dashboard/home_screen/view/home_screen.dart';
import '../modules/splash/splash_screen/view/splash_screen.dart';
import './app_routes.dart';

abstract class RouteNavigator {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.splash: (BuildContext context) => const SplashScreen(),
    Routes.homeScreen: (BuildContext context) => StateProvider(
          stateProvider: StatekitProvider(create: () => HomeScreenController()),
          child: HomeScreen(),
        ),
  };
}""";

  static const baseScreenFileContent = """import 'package:<app_name>/App/core/constants/color_constants.dart';
import 'package:<app_name>/App/core/utils/common.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    this.appBar,
    this.drawer,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.padding,
  });
  final PreferredSizeWidget? appBar;
  final Drawer? drawer;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onTap: removeFocus,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 18),
          child: body,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.backgroundColor,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}""";

  static const String homeScreenFileContent = """import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import '../../../shared/base_screen/view/base_screen.dart';
import '../../../shared/base_screen/view/custom_appbar.dart';
import '../binding/home_screen_binding.dart';
import '../controller/home_screen_controller.dart';

class HomeScreen extends StatekitView<HomeScreenController> implements HomeScreenBinding {
  HomeScreen({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: CustomAppbar(title: Text("Home Screen")),
      body: StateBuilder<HomeScreenController>(
        controller: controller,
        builder: (context, controller, child) {
          return Center(
            child: Text("Home Screen"),
          );
        },
      ),
    );
  }

  @override
  void doSomething() {
    // TODO: implement doSomething
  }
}""";
}
