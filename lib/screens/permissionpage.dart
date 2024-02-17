import 'package:alzheimer_app/constants/theme.dart';
import 'package:alzheimer_app/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class permissionpage extends StatefulWidget {
  const permissionpage({super.key});

  @override
  State<permissionpage> createState() => _permissionpageState();
}

class _permissionpageState extends State<permissionpage> {
  PermissionsHandler permissionsHandler = Get.put(PermissionsHandler());
  String url =
      'https://static.vecteezy.com/system/resources/previews/005/073/066/original/enable-location-services-pop-up-permission-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg';

  bool first = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: White,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * 0.25,
              width: screenSize.width * 0.75,
              decoration: BoxDecoration(
                color: darkBlue.withOpacity(0.1),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Remindify",
                  style: GoogleFonts.poppins(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Red,
                  ),
                ),
                Text(
                  "Specially for Alzheimer's",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: darkBlue.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              height: screenSize.height * 0.055,
              width: screenSize.width * 0.4,
              decoration: BoxDecoration(
                color: darkBlue.withOpacity(0.09),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "All you set!",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (!first) {
                        permissionsHandler.requestpermission();
                        setState(() {
                          first = true;
                        });
                      } else {
                        permissionsHandler.permissiondenied();
                      }
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      color: darkBlue.withOpacity(0.5),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenSize.height * 0.045,
              width: screenSize.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location Permission",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: darkBlue,
                    ),
                  ),
                  (permissionsHandler.locationperssion == true)
                      ? const Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          color: Colors.green,
                          size: 24,
                        )
                      : const Icon(
                          Icons.error_outline_rounded,
                          color: Red,
                          size: 24,
                        ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.045,
              width: screenSize.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Call Permission",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: darkBlue,
                    ),
                  ),
                  (permissionsHandler.callpermission == true)
                      ? const Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          color: Colors.green,
                          size: 24,
                        )
                      : const Icon(
                          Icons.error_outline_rounded,
                          color: Red,
                          size: 24,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
