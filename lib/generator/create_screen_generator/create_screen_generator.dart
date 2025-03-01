class CreateScreenGenerator {
  static const String repositoryFileContent = """class <repository_name> {}""";

  static const String bindingFileContent = """import 'package:statekit/statekit.dart';

abstract interface class <screen_binding_name> implements StateBinding {
  void doSomething();
}""";

  static const String blankScreenControllerFileContent = """import 'package:statekit/statekit.dart';
import '../repository/<screen_name>_repository.dart';
import '../binding/<screen_name>_binding.dart';

class <screen_controller_name> extends StateController<<screen_binding_name>> {
  final <repository_name> _repository = <repository_name>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}""";

  static const String gridListItemFileContent = """import 'package:flutter/material.dart';

class GridListItem extends StatelessWidget {
  const GridListItem({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: const Placeholder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Lorem ipsum",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            const Text(
              "Lorem ipsum is placeholder text",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}""";

  static const String gridLoadingViewFileContent = """import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 15,
                    width: 100,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 15,
                    width: double.infinity,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 15,
                    width: double.infinity,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}""";

  static const String gridScreenControllerFileContent = """import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';
import 'package:<app_name>/App/core/enums/enums.dart';
import '../repository/<screen_name>_repository.dart';
import '../binding/<screen_name>_binding.dart';

class <screen_controller_name> extends StateController<<screen_binding_name>> {
  final <repository_name> _repository = <repository_name>();
  ActivityState currentState = ActivityState.loading;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    currentState = ActivityState.loaded;
    update();
  }

  void onSearch() {
    currentState = ActivityState.loading;
    update();
    fetchData();
  }
}""";

  static const String listItemViewFileContent = """import 'package:flutter/material.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: const Placeholder(),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem ipsum",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Lorem ipsum is placeholder text",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}""";

  static const String listLoadingViewFileContent = """import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                        width: 160,
                        child: ColoredBox(color: Colors.grey.shade300),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 15,
                        width: double.infinity,
                        child: ColoredBox(color: Colors.grey.shade300),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}""";

  static const String listScreenControllerFileContent = """import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';
import 'package:<app_name>/App/core/enums/enums.dart';
import '../repository/<screen_name>_repository.dart';
import '../binding/<screen_name>_binding.dart';

class <screen_controller_name> extends StateController<<screen_binding_name>> {
  final <repository_name> _repository = <repository_name>();
  ActivityState currentState = ActivityState.loading;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    currentState = ActivityState.loaded;
    update();
  }

  void onSearch() {
    currentState = ActivityState.loading;
    update();
    fetchData();
  }
}""";
}
