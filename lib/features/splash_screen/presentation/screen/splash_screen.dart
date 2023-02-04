import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quotes_app/config/routes/app_routes.dart';
import 'package:quotes_app/core/utils/assets_manager/images_manager.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  _goNext() => Navigator.pushReplacementNamed(context, Routes.quoteScreen);

  _startDelay() {
    _timer = Timer(Duration(milliseconds: 2000), () => _goNext());
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImgAssets.quote),
      ),
    );
  }
}
