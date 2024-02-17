import 'package:alzheimer_app/screens/homepage.dart';
import 'package:alzheimer_app/screens/permissionpage.dart';
import 'package:alzheimer_app/service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    PermissionsHandler permissionsHandler = Get.put(PermissionsHandler());
    return GetMaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
