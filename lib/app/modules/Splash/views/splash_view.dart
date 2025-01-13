import 'package:blogapp/app/modules/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    //Accéder à une méthode du conrroleur
    controller.checkLoginStatus();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [        
          LogoApp(),
          Text('Blog app\'S', 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          CircularProgressIndicator(),
        ],
        ));
  }
}
