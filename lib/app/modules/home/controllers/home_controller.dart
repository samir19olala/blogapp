import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../homePage/views/home_page_view.dart';
import '../../discover/views/discover_view.dart';
import '../../profile/views/profile_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxInt currentIndex = 0.obs;
  RxInt previousIndex = 0.obs;
  RxBool isWildScreen = false.obs;

  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  List<Widget> pages() => [
        const HomePageView(),
        const DiscoverView(),
        const ProfileView(),
      ];
}
