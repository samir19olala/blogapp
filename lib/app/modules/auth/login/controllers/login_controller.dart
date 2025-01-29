import 'package:blogapp/app/core/config/api_config.dart';
import 'package:blogapp/app/core/utils/snackbar_utils.dart';
import 'package:blogapp/app/data/models/user_model.dart';
import 'package:blogapp/app/data/services/api_service.dart';
import 'package:blogapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //todo: Implement LoginController
  final ApiService _apiService = Get.find<ApiService>();

  // Observables
  final _currentUser = Rx<User?>(null);
  final isSubmitting = Rx<bool>(false);

  // getters
  User? get currentUser => _currentUser.value;
  bool get isLoading => isSubmitting.value;
  bool get isAuthenticated =>_apiService.isAuthenticated;

  // gestion formulaire
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void onInit(){
    super.onInit();
    if(_apiService.isAuthenticated){
      _loadUserProfile();
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter your email";
    }
    if (!GetUtils.isEmail(value)) {
      return "invalid email format";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 8) {
      return "password must be at least 8 characters long";
    }
    return null;
  }

  bool validateForm() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    loginFormKey.currentState!.save();
    return true;
  }

  Future<void> login() async {
    if (validateForm()) {
      try {
        if(isSubmitting.value) return;
        isSubmitting.value = true;
        await _apiService.login(emailcontroller.text.trim(),passwordController.text);
        await _loadUserProfile();
        SnackbarUtils.showSuccess(message:"connexion reussite ");
        Get.offAllNamed(Routes.HOME);
      }catch (e){
        printError(info:e.toString());
        SnackbarUtils.showError(message: e.toString(),position: SnackPosition.BOTTOM);
      }finally{
        isSubmitting.value = false;
      }
    }
  }

  Future<void> _loadUserProfile() async {
    try{
    final userData = await _apiService.get<User>(
      ApiConfig.currentUser,(data)=>User.fromJson(data));

    _currentUser.value = userData;
    _currentUser.refresh();
    
    }catch(e){
      printError(info:e.toString());
      SnackbarUtils.showError(message: "impossible de charger le profil utilisateur : ${e.toString()}",title:'Error',position: SnackPosition.BOTTOM,duration: Duration(seconds: 10));
    }
  }
}
