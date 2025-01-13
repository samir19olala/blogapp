import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          switchInCurve: Curves.bounceIn,
          switchOutCurve: Curves.bounceInOut,
          child: LayoutBuilder(builder: (context, constraints) {
            return Obx(() {
              return Row(
                children: [
                  ...[
                    (constraints.maxWidth > 600)
                        ? NavigationRail(
                            backgroundColor:
                                Get.theme.colorScheme.primary.withOpacity(0.6),
                            elevation: 1,
                            leading: IconButton(
                                icon: Icon(Icons.menu), onPressed: () {}),
                            destinations: [
                              NavigationRailDestination(
                                icon: Icon(Icons.home),
                                label: const Text('Home'),
                                selectedIcon: Icon(Icons.home_filled),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.search),
                                label: const Text('Search'),
                                selectedIcon: Icon(Icons.search_outlined),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.person),
                                label: const Text('Profile'),
                                selectedIcon:
                                    Icon(Icons.person_outline_outlined),
                              ),
                            ],
                            selectedIndex: controller.currentIndex.value,
                            onDestinationSelected: controller.updateIndex,
                          )
                        : const SizedBox.shrink()
                  ],
                  Expanded(
                      child: controller.pages()[controller.currentIndex.value]),
                ],
              );
            });
          })),
      bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Obx(() {
            return NavigationBar(
                selectedIndex: controller.currentIndex.value,
                onDestinationSelected: controller.updateIndex,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    selectedIcon: Icon(Icons.home_filled),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search),
                    label: 'Search',
                    selectedIcon: Icon(Icons.search_outlined),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                    selectedIcon: Icon(Icons.person_outline_outlined),
                  ),
                ]);
          });
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
