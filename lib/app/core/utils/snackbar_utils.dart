import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showSuccess({
    required String message,
    String? title,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.snackbar(
      title ?? 'Succès',
      message,
      snackPosition: position ?? SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showError({
    required String message,
    String? title,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.snackbar(
      title ?? 'Erreur',
      message,
      snackPosition: position ?? SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 4),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showInfo({
    required String message,
    String? title,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.snackbar(
      title ?? 'Information',
      message,
      snackPosition: position ?? SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
