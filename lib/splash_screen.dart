import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:souq_alderai/web_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkPermission(context);
    return Scaffold(
      body: SvgPicture.asset(
        'assets/splash_screen.svg',
        fit: BoxFit.fill,
      ),
    );
  }

  void _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    bool isGranted = statusCamera == PermissionStatus.granted;
    if (isGranted) {
      Timer(const Duration(seconds: 3), () => Get.to(const WebViewScreen()));
    }
    bool isPermanentlyDenied = statusCamera == PermissionStatus.denied;
    if (isPermanentlyDenied) {
      exit(0);
    }
  }
}
