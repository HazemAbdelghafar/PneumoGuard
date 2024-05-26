import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../model/model.dart';
import 'bnb.dart';

class Detection extends StatefulWidget {
  const Detection({super.key});

  @override
  State<Detection> createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? result;
  bool isLoading = false;

  final pneumoniaText = '''
Pneumonia has been detected. Here's a guide to help you recover: 
 
Feeling rough? Pneumonia can be a drag, but you're on the mend! Here's the quick guide:

Follow doctor's orders: Meds, rest, fluids - key to recovery.
Hydrate: Water, broths, teas - loosen mucus and fight dehydration.
Rest Up: Your body is battling! Get plenty of sleep and take it easy.
Lean on Loved Ones: Don't be shy to ask for help with chores or errands.
Nourish Yourself: Healthy meals with fruits, veggies, and whole grains are your allies.
Positive Vibes: Laughter, music, good books - boost your mood and healing.
Remember: Take it slow, listen to your body, and call your doctor if symptoms worsen.

We believe in you! 🌟 ''';

  final normalText = '''
No pneumonia detected. Here's a guide to help you stay healthy:
  
Stay healthy and steer clear of pneumonia with these simple tips:

Vaccinate: Get your flu shot and consider the pneumococcal vaccine if recommended.
Fuel Your Body: Eat healthy, get enough sleep, and exercise for a strong immune system.
Fresh Air, Please: Limit air pollution exposure and manage chronic lung conditions.
Hygiene Matters: Cover coughs and sneezes, and dispose of tissues properly.
Know the Signs: Be aware of fever, cough, shortness of breath, and chest pain.
By following these tips, you can significantly reduce your risk of pneumonia.

Stay informed: Check out resources from the CDC and American Lung Association!

Healthy lungs, happy you! 🌬️
  ''';

  @override
  void initState() {
    super.initState();
    initModel();
  }

  Future<void> initModel() async {
    await ModelClass.loadModel();
  }

  selectImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      isLoading = true;
      result = null;
    });
    ModelClass.classifyImage(_image!.path).then((value) {
      setState(() {
        result = value;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    ModelClass.closeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6E3),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF97E7E1),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F6E3),
        title: Text('Pneumonia Detection',
            style: GoogleFonts.raleway(
                color: const Color(0xFF7AA2E3),
                fontWeight: FontWeight.w700,
                fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 10, top: 5, bottom: 20, end: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    if (isLoading)
                      const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF7AA2E3))),
                    if (result == 'Normal')
                      Text(normalText,
                          style: GoogleFonts.raleway(
                              color: Colors.black, fontSize: 16)),
                    if (result == 'Pneumonia detected')
                      Text(pneumoniaText,
                          style: GoogleFonts.raleway(
                              color: Colors.black, fontSize: 16)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, '/hospitals');
                        },
                        child: Text('\nTo find nearby hospitals, click here.',
                            style: GoogleFonts.raleway(
                                color: const Color(0xFF7AA2E3),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/chat');
                        },
                        child: Text('And to talk to an AI doctor, click here.',
                            style: GoogleFonts.raleway(
                                color: const Color(0xFF7AA2E3),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    selectImage();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      fixedSize: const Size(225, 50),
                      backgroundColor: const Color(0x9997E7E1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Align(
                    // alignment: Alignment.centerLeft,
                    child: Text('Upload X-Ray image',
                        style: GoogleFonts.raleway(
                            color: Colors.black, fontSize: 20)),
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const myBottomBar(currentIndex: 1),
    );
  }
}
