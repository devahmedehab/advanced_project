import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app1/presentation/resources/assets_manager.dart';
import 'package:app1/presentation/resources/color_manager.dart';
import 'package:app1/presentation/resources/constants_manager.dart';
import 'package:app1/presentation/resources/routs_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay(){
    _timer=Timer(
        const Duration(seconds: AppConstant.splashDelay),
        _goNext
    );
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: Image(
        image: AssetImage(ImageAssets.splashLogo),
      )),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
