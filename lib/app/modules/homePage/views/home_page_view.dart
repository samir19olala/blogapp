import 'package:blogapp/app/modules/widgets/post_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});
  Widget _buildPostList() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (controller.posts.isEmpty) {
      return const Center(
        child: Text('No posts found'),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.fetchPosts,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 400,
            maxCrossAxisExtent: 450,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return PostCard(post: post);
          }),
    );
  }

  Widget _buildCategoryList() {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Obx(() {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              final isSelected = controller.selectedCategory.value == category;
              return GestureDetector(
                onTap: () => controller.changeCategory(category),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Get.theme.colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Get.theme.colorScheme.primary),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? Get.theme.colorScheme.onPrimary
                          : Get.theme.colorScheme.primary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      _buildCategoryList(),
      Expanded(
        child: _buildPostList(),
      ),
    ]));
  }
}


// GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 0,
//                         mainAxisSpacing: 0,
//                       ),                        crossAxisCount: 3,
//                         crossAxisSpacing: 0,
//                         mainAxisSpacing: 0,
//                       ),
//                       padding: const EdgeInsets.all(2),
//                       itemCount: controller.userAccounts.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index < controller.userAccounts.length) {
//                           return AccountWidget(
//                             user: controller.userAccounts[index],
//                           );
//                         } else {
//                           // Dernier élément pour ajouter un compte
//                           return AddUserAccount();
//                         }
//                       },
//                     ),
//                   ),
// LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth < 600) {
//         return RefreshIndicator(
//           onRefresh: controller.fetchPosts,
//           child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.posts.length,
//               itemBuilder: (context, index) {
//                 final post = controller.posts[index];
//                 return PostCard(post: post);
//               }),
//         );
//       }

//       return GridView.builder(
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             mainAxisExtent: 400,
//             maxCrossAxisExtent: 450,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemCount: controller.posts.length,
//           itemBuilder: (context, index) {
//             final post = controller.posts[index];
//             return PostCard(post: post);
//           });
//     });