import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/api_config.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_pages.dart';

class CategoryController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  // États observables
  final RxList<Category> categories = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxString error = ''.obs;

  // État du formulaire
  final RxBool isEditing = false.obs;
  final RxString editingId = ''.obs;

  // Contrôleurs de formulaire
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  final formKey = GlobalKey<FormState>();

  // Validation des champs
  final RxBool isNameValid = true.obs;
  final RxBool isDescriptionValid = true.obs;

  @override
  void onInit() {
    super.onInit();
    initFormControllers();
    fetchCategories();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // Initialisation des contrôleurs
  void initFormControllers() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  // Réinitialiser le formulaire
  void resetForm() {
    nameController.clear();
    descriptionController.clear();
    isNameValid(true);
    isDescriptionValid(true);
    isEditing(false);
    editingId('');
  }

  // Validation du nom
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      isNameValid(false);
      return 'Le nom est requis';
    }
    if (value.length < 2) {
      isNameValid(false);
      return 'Le nom doit contenir au moins 2 caractères';
    }
    if (value.length > 50) {
      isNameValid(false);
      return 'Le nom ne doit pas dépasser 50 caractères';
    }
    isNameValid(true);
    return null;
  }

  // Validation de la description
  String? validateDescription(String? value) {
    if (value != null && value.length > 500) {
      isDescriptionValid(false);
      return 'La description ne doit pas dépasser 500 caractères';
    }
    isDescriptionValid(true);
    return null;
  }

  // Soumettre le formulaire
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting(true);

    final category = Category(
      id: isEditing.value ? editingId.value : null,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
    );

    try {
      if (isEditing.value) {
        await updateCategory(category);
      } else {
        await createCategory(category);
      }
      Get.back();
    } catch (e) {
      SnackbarUtils.showError(
        message: 'Une erreur est survenue lors de la sauvegarde',
        title: 'Erreur',
      );
    } finally {
      isSubmitting(false);
    }
  }

  // Préparer l'édition d'une catégorie
  void startEditing(Category category) {
    isEditing(true);
    editingId(category.id ?? '');
    nameController.text = category.name;
    descriptionController.text = category.description ?? '';
    SnackbarUtils.showInfo(
      message: 'Vous modifiez la catégorie "${category.name}"',
      duration: const Duration(seconds: 2),
    );
    Get.toNamed(Routes.CATEGORY_FORM);
  }

  // Démarrer la création d'une nouvelle catégorie
  void startCreating() {
    resetForm();
    Get.toNamed(Routes.CATEGORY_FORM);
  }

  // Annuler l'édition
  void cancelEditing() {
    resetForm();
    Get.back();
    SnackbarUtils.showInfo(
      message: 'Modification annulée',
      duration: const Duration(seconds: 2),
    );
  }

  // Récupérer toutes les catégories
  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      error('');
      final response = await _apiService.get<List<Category>>(
        ApiConfig.categories,
        (data) =>
            (data as List).map((json) => Category.fromJson(json)).toList(),
      );
      categories.assignAll(response);
      SnackbarUtils.showInfo(
        message: 'Les catégories ont été chargées',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      error(e.toString());
      SnackbarUtils.showError(
        message: 'Impossible de charger les catégories',
        title: 'Erreur de chargement',
      );
    } finally {
      isLoading(false);
    }
  }

  // Créer une nouvelle catégorie
  Future<void> createCategory(Category category) async {
    try {
      isLoading(true);
      error('');
      final response = await _apiService.post<Category>(
        ApiConfig.categories,
        category.toJson(),
        (data) => Category.fromJson(data),
      );
      categories.add(response);
      Get.back(); // Fermer le formulaire
      SnackbarUtils.showSuccess(
        message: 'La catégorie "${category.name}" a été créée avec succès',
        title: 'Création réussie',
      );
    } catch (e) {
      error(e.toString());
      SnackbarUtils.showError(
        message: 'Impossible de créer la catégorie "${category.name}"',
        title: 'Erreur de création',
      );
    } finally {
      isLoading(false);
    }
  }

  // Mettre à jour une catégorie
  Future<void> updateCategory(Category category) async {
    try {
      isLoading(true);
      error('');
      final response = await _apiService.put<Category>(
        '${ApiConfig.categories}/${category.id}',
        category.toJson(),
        (data) => Category.fromJson(data),
      );
      final index = categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        categories[index] = response;
      }
      isEditing(false);
      editingId('');
      Get.back(); // Fermer le formulaire
      SnackbarUtils.showSuccess(
        message:
            'La catégorie "${category.name}" a été mise à jour avec succès',
        title: 'Modification réussie',
      );
    } catch (e) {
      error(e.toString());
      SnackbarUtils.showError(
        message: 'Impossible de mettre à jour la catégorie "${category.name}"',
        title: 'Erreur de modification',
      );
    } finally {
      isLoading(false);
    }
  }

  // Supprimer une catégorie
  Future<void> deleteCategory(String id) async {
    try {
      isLoading(true);
      error('');
      final categoryName = categories.firstWhere((c) => c.id == id).name;
      await _apiService.delete('${ApiConfig.categories}/$id');
      categories.removeWhere((c) => c.id == id);
      SnackbarUtils.showSuccess(
        message: 'La catégorie "$categoryName" a été supprimée avec succès',
        title: 'Suppression réussie',
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      error(e.toString());
      SnackbarUtils.showError(
        message: 'Impossible de supprimer la catégorie',
        title: 'Erreur de suppression',
      );
    } finally {
      isLoading(false);
    }
  }
}
