import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryFormView extends GetView<CategoryController> {
  const CategoryFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.isEditing.value
                  ? 'Modifier la catégorie'
                  : 'Nouvelle catégorie',
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.cancelEditing,
        ),
        actions: [
          TextButton.icon(
            onPressed: controller.submitForm,
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text(
              'Enregistrer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // En-tête du formulaire
                Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 48,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Obx(() => Text(
                              controller.isEditing.value
                                  ? 'Modification de la catégorie'
                                  : 'Création d\'une nouvelle catégorie',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(height: 8),
                        const Text(
                          'Remplissez les informations ci-dessous',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                // Champ Nom
                Obx(() => TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        hintText: 'Entrez le nom de la catégorie',
                        prefixIcon: const Icon(Icons.category),
                        border: const OutlineInputBorder(),
                        errorText: controller.isNameValid.value
                            ? null
                            : 'Nom invalide',
                        helperText:
                            'Le nom doit contenir entre 2 et 50 caractères',
                        suffixIcon: controller.nameController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () =>
                                    controller.nameController.clear(),
                              )
                            : null,
                      ),
                      validator: controller.validateName,
                      textInputAction: TextInputAction.next,
                      maxLength: 50,
                      onChanged: (value) => controller.validateName(value),
                    )),

                const SizedBox(height: 24),

                // Champ Description
                Obx(() => TextFormField(
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Entrez une description (optionnelle)',
                        prefixIcon: const Icon(Icons.description),
                        border: const OutlineInputBorder(),
                        errorText: controller.isDescriptionValid.value
                            ? null
                            : 'Description trop longue',
                        helperText: 'Maximum 500 caractères',
                        suffixIcon: controller
                                .descriptionController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () =>
                                    controller.descriptionController.clear(),
                              )
                            : null,
                      ),
                      validator: controller.validateDescription,
                      maxLines: 5,
                      maxLength: 500,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) =>
                          controller.validateDescription(value),
                    )),

                const SizedBox(height: 32),

                // Boutons d'action
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => OutlinedButton.icon(
                            onPressed: controller.isSubmitting.value
                                ? null
                                : controller.cancelEditing,
                            icon: const Icon(Icons.close),
                            label: const Text('Annuler'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => ElevatedButton.icon(
                            onPressed: controller.isSubmitting.value
                                ? null
                                : controller.submitForm,
                            icon: controller.isSubmitting.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.save),
                            label: Text(controller.isSubmitting.value
                                ? 'Enregistrement...'
                                : 'Enregistrer'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
