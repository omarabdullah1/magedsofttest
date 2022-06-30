import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magedsofttest/presentation/styles/colors.dart';
import '../../../data/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var id = CacheHelper.getDataFromSharedPreference(key: 'id');
    timer = Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, id == null ? '/login' : '/profile', (route) => false));
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Image.asset('assets/images/logo2.png'),
      ),
    );
  }
}
