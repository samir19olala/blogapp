import 'package:blogapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
//Fonction asynchrone qui permet de vérifier le statut de connexion et de lancer la page de connexionn après 3 secondes
Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 10));
    Get.offAllNamed(Routes.ONBOARDING);
  }
}
