// import 'dart:convert';
import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/controller/auth_controller.dart';
import 'package:herbal_veda_copy/views/screens/plant_detail_screen.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:async/async.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthControllers _authControllers = AuthControllers();

  Uint8List? _clickimage;

  captureImage() async {
    Uint8List im = await _authControllers.pickProfilImage(ImageSource.camera);
    setState(() {
      _clickimage = im;
    });

    if (_clickimage != null) {
      try {
        Map<String, dynamic> apiResponse =
            await _authControllers.sendImageToAPI(_clickimage!);
        // Handle the API response as needed
        String plantId = apiResponse['plantId'];
        print('Plant ID: $plantId');
        // You can also access other details from apiResponse['apiResponse']

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlantScreen(
              pickedImage: _clickimage!,
              plantId: plantId); // Pass the plant ID to PlantScreen
        }));
        print('API Response: $apiResponse');
      } catch (e) {
        // Handle any errors that occur during the API request
        print('Error sending image to API: $e');
      }
    }
  }

  UploadImage() async {
    Uint8List im = await _authControllers.pickProfilImage(ImageSource.gallery);
    setState(() {
      _clickimage = im;
    });
    if (_clickimage != null) {
      try {
        Map<String, dynamic> apiResponse =
            await _authControllers.sendImageToAPI(_clickimage!);
        // Handle the API response as needed
        String plantId = apiResponse['plantId'];
        print('Plant ID: $plantId');
        // You can also access other details from apiResponse['apiResponse']

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlantScreen(
              pickedImage: _clickimage!,
              plantId: plantId); // Pass the plant ID to PlantScreen
        }));
      } catch (e) {
        // Handle any errors that occur during the API request
        print('Error sending image to API: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 220,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 276,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.07,
                      0.2,
                      0.4,
                      0.6,
                    ],
                    colors: [
                      Color.fromRGBO(158, 187, 104, 1),
                      Color.fromRGBO(190, 216, 142, 1),
                      Color.fromRGBO(231, 235, 225, 1),
                      Colors.white,
                    ],
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Image.asset("assets/images/cam.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        captureImage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(102, 128, 52, 1),
                        shadowColor: Color.fromARGB(255, 58, 91, 59),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(200, 40),
                        maximumSize: Size(400, 40),
                      ),
                      child: Text("Take Picture"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        UploadImage();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(200, 40),
                        maximumSize: Size(400, 40),
                        side: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(102, 128, 52, 1),
                        ),
                      ),
                      child: Text(
                        "Upload Picture",
                        style: TextStyle(
                          color: Color.fromRGBO(102, 128, 52, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "MODEL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(102, 128, 52, 1),
                        fontSize: 19,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
