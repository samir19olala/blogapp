import 'package:blogapp/app/data/models/post_model.dart';
import 'package:blogapp/app/data/services/api_service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  //TODO: Implement HomePageController
  final ApiService apiService = ApiService();
  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = true.obs;
  final RxString selectedCategory = 'all'.obs;
  final RxList<String> categories = <String>['all'].obs;

  @override
  void onInit() async {
    super.onInit();
    loadCategories();
    fetchPosts();
  }

  Future<void> loadCategories() async {
    try {
      isLoading.value = true;
      final fetchedCategories = await apiService.getCategories();
      categories.value = ['All', ...fetchedCategories];
    } catch (err) {
      // ignore: avoid_print
      print(err);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final fetchedPosts = await apiService.getPosts();
      posts.value = fetchedPosts;
    } catch (err) {
      // ignore: avoid_print
      print(err);
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    selectedCategory(category);
  }
  
  List<Post> get getFilteredPosts {
    if (selectedCategory.value == "All") {
      return posts;
    }
    return posts
        .where((post) => post.category == selectedCategory.value)
        .toList();
  }
}
