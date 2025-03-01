import 'package:statekit_cli/generator/create_screen_generator/create_screen_generator.dart';

abstract class CreateScreenGeneratorModular extends CreateScreenGenerator {
  static const String blankScreenFileContent = """import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import '../../../shared/base_screen/view/base_screen.dart';
import '../../../shared/base_screen/view/custom_appbar.dart';
import '../binding/<screen_name>_binding.dart';
import '../controller/<screen_name>_controller.dart';

class <screen_class_name> extends StatekitView<<screen_controller_name>> implements <screen_binding_name> {
  <screen_class_name>({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: CustomAppbar(title: Text("<screen_content>")),
      body: StateBuilder<<screen_controller_name>>(
        controller: controller,
        builder: (context, controller, child) {
          return Center(
            child: Text("<screen_content>"),
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

  static const String gridScreenFileContent = """import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:<app_name>/App/core/enums/enums.dart';
import '../../../shared/base_screen/view/base_screen.dart';
import '../../../shared/base_screen/view/custom_appbar.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/search_field.dart';
import '../binding/<screen_name>_binding.dart';
import '../controller/<screen_name>_controller.dart';
import 'grid_list_item_view.dart';
import 'loading_view.dart';

class <screen_class_name> extends StatekitView<<screen_controller_name>> implements <screen_binding_name> {
  <screen_class_name>({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: CustomAppbar(title: Text("<screen_content>")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            SearchField(
              searchController: controller.searchController,
              onTextChange: (text) {
                controller.onSearch();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StateBuilder<<screen_controller_name>>(
                controller: controller,
                builder: (context, controller, child) {
                  if (controller.currentState == ActivityState.loading) {
                    return const LoadingView();
                  }
                  if (controller.currentState == ActivityState.empty) {
                    return const EmptyView();
                  }
                  return GridView.builder(
                    itemCount: 20,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) => GridListItem(onTap: () {}),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void doSomething() {
    // TODO: implement doSomething
  }
}""";

  static const String listScreenFileContent = """import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:<app_name>/App/core/enums/enums.dart';
import '../../../shared/base_screen/view/base_screen.dart';
import '../../../shared/base_screen/view/custom_appbar.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/search_field.dart';
import '../binding/<screen_name>_binding.dart';
import '../controller/<screen_name>_controller.dart';
import 'list_item_view.dart';
import 'loading_view.dart';

class <screen_class_name> extends StatekitView<<screen_controller_name>> implements <screen_binding_name> {
  <screen_class_name>({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: CustomAppbar(title: Text("<screen_content>")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            SearchField(
              searchController: controller.searchController,
              onTextChange: (text) {
                controller.onSearch();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StateBuilder<<screen_controller_name>>(
                controller: controller,
                builder: (context, controller, child) {
                  if (controller.currentState == ActivityState.loading) {
                    return const LoadingView();
                  }
                  if (controller.currentState == ActivityState.empty) {
                    return const EmptyView();
                  }
                  return ListView.separated(
                    itemCount: 25,
                    itemBuilder: (context, index) => ListItemView(onTap: () {}),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void doSomething() {
    // TODO: implement doSomething
  }
}""";
}
