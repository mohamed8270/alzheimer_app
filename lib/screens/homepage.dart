// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:io';

import 'package:alzheimer_app/DB%20service/DB_helper.dart';
import 'package:alzheimer_app/DB%20service/DB_medicine.dart';
import 'package:alzheimer_app/components/location_card.dart';
import 'package:alzheimer_app/components/textfield_input.dart';
import 'package:alzheimer_app/constants/theme.dart';
import 'package:alzheimer_app/controller/geocoding.dart';
import 'package:alzheimer_app/controller/service.dart';
import 'package:alzheimer_app/service/notify_service.dart';
import 'package:alzheimer_app/service/service.dart';
import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:latlong2/latlong.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:whatsapp_share/whatsapp_share.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper databaseHelper = Get.put(DatabaseHelper());

  DatabaseHelper2 databaseHelper2 = Get.put(DatabaseHelper2());

  Service service = Get.put(Service());
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());
  PermissionsHandler permissionsController = Get.put(PermissionsHandler());

  // final databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> carePerson = [];

  List<Map<String, dynamic>> medicine = [];

  Future<void> _allpersons() async {
    final allpersons = await databaseHelper.getalldetails();
    setState(() {
      carePerson = allpersons;
    });
  }

  Future<void> _allmedicine() async {
    final allmedicine = await databaseHelper2.getallmedicine();
    setState(() {
      medicine = allmedicine;
    });
  }

  Future<void> _addcareperson(BuildContext context) async {
    TextEditingController controllername = TextEditingController();
    TextEditingController controllerrelation = TextEditingController();
    TextEditingController controllerplace = TextEditingController();
    TextEditingController controllerphone = TextEditingController();
    TextEditingController controlleraddress = TextEditingController();

    final screenSize = MediaQuery.of(context).size;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add Care Person",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkBlue,
            ),
          ),
          content: SizedBox(
            height: screenSize.height * 0.33,
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllername,
                    labeltxt: 'Person name',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllerrelation,
                    labeltxt: 'Relation',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllerplace,
                    labeltxt: 'Place',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllerphone,
                    labeltxt: 'Phone',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controlleraddress,
                    labeltxt: 'Address',
                    tap: () {},
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                navigator!.pop(context);
                Map<String, dynamic> newrow = {
                  'name': controllername.text,
                  'relation': controllerrelation.text,
                  'place': controllerplace.text,
                  'phonenumber': controllerphone.text,
                  'address': controlleraddress.text,
                };

                int newpersonid = await databaseHelper.insertdetail(newrow);
                _allpersons();
              },
              child: Text(
                "Add Detail",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addmedicine(BuildContext context) async {
    TextEditingController controllermedicinename = TextEditingController();
    TextEditingController controllermedicinetype = TextEditingController();
    TextEditingController controllerdose = TextEditingController();
    TextEditingController controllerdatetime = TextEditingController();

    final screenSize = MediaQuery.of(context).size;

    DateTime scheduleTime = DateTime.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add Care Person",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkBlue,
            ),
          ),
          content: SizedBox(
            height: screenSize.height * 0.33,
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllermedicinename,
                    labeltxt: 'Medicine Name',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllermedicinetype,
                    labeltxt: 'Medicine Type',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllerdose,
                    labeltxt: 'Dosage',
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                  child: Inputfield(
                    Controller: controllerdatetime,
                    labeltxt: 'Date & Time',
                    tap: () async {
                      DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        onChanged: (controllerdatetime) =>
                            scheduleTime = controllerdatetime,
                        onConfirm: (controllerdatetime) {
                          print(scheduleTime);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                navigator!.pop(context);
                Map<String, dynamic> newmedicine = {
                  'medicinename': controllermedicinename.text,
                  'medicinetype': controllermedicinetype.text,
                  'medicinedose': controllerdose.text,
                  'medicinedatetime': scheduleTime.toString(),
                };

                int newmedicineid =
                    await databaseHelper2.insertmedicine(newmedicine);
                _allmedicine();

                debugPrint('Notification Scheduled for $scheduleTime');
                NotificationService().scheduleNotification(
                  title: 'Health is our priority 🤞',
                  body:
                      '${controllermedicinename.text} is recommended for your daily health 😉',
                  scheduledNotificationDateTime: scheduleTime,
                );
              },
              child: Text(
                "Add Medicine Info",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteperson(int id) async {
    await databaseHelper.deletedetails(id);
    _allpersons();
  }

  Future<void> deletemed(int id) async {
    await databaseHelper2.deletemedicine(id);
    _allmedicine();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(
      toNumber: '+916369718561',
      messageBody:
          'Hurry Up!, I am over here 👇👇 \n https://www.google.com/maps/search/?api=1&query=${service.latitude},${service.longitude}',
    );
  }

  // Future<void> share() async {
  //   await WhatsappShare.share(
  //     text: 'I am up here! Grab me now,',
  //     linkUrl:
  //         'https://www.google.com/maps/search/?api=1&query=${service.latitude},${service.longitude}',
  //     phone: '916369718561',
  //   );
  // }

  openwhatsapp() async {
    var whatsapp = "+916369718561";
    var whatsappurlAndroid =
        "whatsapp://send?phone=$whatsapp&text=${service.latitude},${service.longitude}";
    var whatappurlIos =
        "https://wa.me/$whatsapp?text=${Uri.parse('${service.latitude},${service.longitude}')}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappurlIos)) {
        await launch(whatappurlIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Black.withOpacity(0.02),
            content: Text(
              "whatsapp no installed",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
    } else {
      // android , web
      if (await canLaunch(whatsappurlAndroid)) {
        await launch(whatsappurlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Black.withOpacity(0.02),
            content: Text(
              "whatsapp no installed",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
    }
  }

  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    super.initState();
    _allpersons();
    _allmedicine();
    // share();
    // myController = MapController();
    twilioFlutter = TwilioFlutter(
      accountSid: 'ACb51a1b083d308a1439ec5ee198a56504',
      authToken: 'a7f46abb505dd8848c15600411f42a68',
      twilioNumber: '+18146662514',
    );
  }

  MapController myController = MapController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: White,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Red,
            elevation: 0,
            onPressed: () => _addcareperson(context),
            child: const Icon(
              Icons.add_rounded,
              size: 24,
              color: White,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Red,
            elevation: 0,
            onPressed: () async {
              await service.makePhonecall('+916369718561');
            },
            child: const Icon(
              Icons.call,
              size: 24,
              color: White,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Red,
            elevation: 0,
            onPressed: () async {
              await service.getLocation();
              myController.move(
                LatLng(service.latitude, service.longitude),
                18.0,
              );
              // geocodingLocation.getPlacemark(
              //   service.latitude,
              //   service.longitude,
              // );
              // myController.latLngToScreenPoint(
              //   LatLng(service.latitude, service.longitude),
              // );
            },
            child: const Icon(
              Icons.my_location_rounded,
              size: 24,
              color: White,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AvatarGlow(
            animate: true,
            endRadius: 30,
            glowColor: Black,
            duration: const Duration(microseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            showTwoGlows: true,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Red,
              elevation: 0,
              onPressed: () {
                sendSms();
              },
              child: const Icon(
                Icons.share_location_rounded,
                size: 24,
                color: White,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Red,
        automaticallyImplyLeading: false,
        title: Text(
          "Remindify",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: White,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _addmedicine(context),
            icon: CircleAvatar(
              backgroundColor: White.withOpacity(0.3),
              child: const Icon(
                Icons.medication_liquid_rounded,
                size: 20,
                color: White,
              ),
            ),
          ),
          IconButton(
            onPressed: () => openwhatsapp(),
            icon: const Icon(
              Icons.share_rounded,
              size: 20,
              color: White,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Greetings!",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Black.withOpacity(0.3),
                ),
              ),
              Text(
                "Heartful Relations ❤",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: screenSize.width * 1,
                height: screenSize.height * 0.14,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: carePerson.length,
                  itemBuilder: (context, index) {
                    final person = carePerson[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onLongPress: () {
                          deleteperson(person['id']);
                        },
                        child: Container(
                          height: screenSize.height * 0.09,
                          width: screenSize.width * 0.5,
                          constraints: const BoxConstraints(
                            maxHeight: double.infinity,
                            maxWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            color: Black.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person['relation'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: darkBlue.withOpacity(0.4),
                                  ),
                                ),
                                Text(
                                  person['name'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Red,
                                  ),
                                ),
                                Text(
                                  person['phonenumber'].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: darkBlue,
                                  ),
                                ),
                                Text(
                                  person['place'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: darkBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Stay On!",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Red,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LocationCard(
                screenSize: screenSize,
                myController: myController,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Medications",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Red,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenSize.width * 1,
                height: screenSize.height * 0.17,
                child: ListView.builder(
                  itemCount: medicine.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final med = medicine[index];
                    return InkWell(
                      onLongPress: () {
                        deletemed(med['id']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: screenSize.width * 0.4,
                          decoration: BoxDecoration(
                            color: Black.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  med['medicinetype'].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Black.withOpacity(0.3),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.3,
                                  child: Text(
                                    med['medicinename'],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Divider(
                                  thickness: 1.5,
                                  height: 0.4,
                                  color: Black.withOpacity(0.04),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenSize.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: Black.withOpacity(0.09),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          med['medicinedatetime'].toString(),
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Black.withOpacity(0.6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      med['medicinedose'].toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Black.withOpacity(0.3),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
