import 'package:flutter/widgets.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      'assets/images/logo_blogapps.png',
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    ));
  }
}
