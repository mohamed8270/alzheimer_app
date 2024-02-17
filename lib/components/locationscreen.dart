import 'package:alzheimer_app/constants/theme.dart';
import 'package:alzheimer_app/controller/geocoding.dart';
import 'package:alzheimer_app/controller/service.dart';
import 'package:alzheimer_app/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatefulWidget {
  final MapController mapController;
  const LocationScreen({super.key, required this.mapController});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());

  Service service = Get.put(Service());

  @override
  void initState() {
    super.initState();
    service.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: White,
        appBar: AppBar(
          backgroundColor: Red,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Location",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: White,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.to(
                const HomePage(),
              );
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: White,
              size: 24,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: White,
          ),
          child: Column(
            children: [
              Text(
                geocodingLocation.name.value,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Red,
                ),
              ),
              Container(
                height: screenSize.height * 0.77,
                decoration: BoxDecoration(
                  color: Black.withOpacity(0.02),
                ),
                child: FlutterMap(
                  mapController: widget.mapController,
                  options: MapOptions(
                    keepAlive: true,
                    center: LatLng(service.latitude, service.longitude),
                    zoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: "dev.fleaflet.flutter_map.example",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(service.latitude, service.longitude),
                          builder: (ctx) => const Icon(
                            CupertinoIcons.location_solid,
                            color: Red,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
