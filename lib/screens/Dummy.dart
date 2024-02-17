// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:alzheimer_app/DB%20service/DB_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({super.key});

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  TextEditingController personnameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DatabaseHelper UserDataInsert = Get.put(DatabaseHelper());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserInput(
            labeltxt: 'Person Name',
            UserController: personnameController,
            Tap: () {},
            type: TextInputType.name,
          ),
          UserInput(
            labeltxt: 'Relation',
            UserController: relationController,
            Tap: () {},
            type: TextInputType.name,
          ),
          UserInput(
            labeltxt: 'Address',
            UserController: addressController,
            Tap: () {},
            type: TextInputType.streetAddress,
          ),
          UserInput(
            labeltxt: 'Place',
            UserController: placeController,
            type: TextInputType.streetAddress,
            Tap: () {},
          ),
          UserInput(
            labeltxt: 'Phone Number',
            UserController: phoneController,
            type: TextInputType.phone,
            Tap: () {},
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> userData = {
                'name': personnameController.text,
                'relation': relationController.text,
                'place': placeController.text,
                'phonenumber': phoneController.text,
                'address': addressController.text,
              };

              int additingData = await UserDataInsert.insertdetail(userData);
            },
            child: const Text(
              "Add Details",
            ),
          ),
        ],
      ),
    );
  }
}

class UserInput extends StatelessWidget {
  const UserInput({
    super.key,
    required this.labeltxt,
    required this.UserController,
    required this.Tap,
    required this.type,
  });

  final String labeltxt;
  final TextEditingController UserController;
  final VoidCallback Tap;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: Tap,
      controller: UserController,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labeltxt,
        labelStyle: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
