import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bnb.dart';

class Hospital {
  final String name;
  final String distance;
  final Uri directions;

  Hospital(
      {required this.name, required this.distance, required this.directions});
}

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  _HospitalsScreenState createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  final List<Hospital> hospitals = [
    Hospital(
        name: 'Al Safwa Royal Hospital',
        distance: '90 M',
        directions: Uri.parse('https://maps.app.goo.gl/D1uJ12J3mnbthKgr8')),
    Hospital(
        name: 'The Elite Hospital',
        distance: '200 M',
        directions: Uri.parse('https://maps.app.goo.gl/tDZgJ2bDjEgYH5i3A')),
    Hospital(
        name: 'Mar Morcos Hospital',
        distance: '850 M',
        directions: Uri.parse('https://maps.app.goo.gl/CZgdYX7scXcZnNLK8')),
    Hospital(
        name: 'Dar Al Atebaa Hospital',
        distance: '950 M',
        directions: Uri.parse('https://maps.app.goo.gl/NMxVAPieCKTWRuGy9')),
    Hospital(
        name: 'Sharq El Madina Hospital',
        distance: '1.1 KM',
        directions: Uri.parse('https://maps.app.goo.gl/gkQxHdMBYzP66LuGA')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6E3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF97E7E1),
        ),
        centerTitle: true,
        title: Text(
          'Nearby Hospitals',
          style: GoogleFonts.raleway(
              color: const Color(0xFF7AA2E3),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return Column(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(340, 115),
                    backgroundColor: const Color(0x9997E7E1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  launchUrl(hospital.directions);
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(hospital.name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            )),
                      ),
                      Text(hospital.distance,
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                                color: Color(0xFF7AA2E3),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const myBottomBar(currentIndex: 0),
    );
  }
}
