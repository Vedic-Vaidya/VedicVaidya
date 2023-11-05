import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/controller/auth_controller.dart';
import 'package:herbal_veda_copy/utils/show_snack_bar.dart';
import 'package:herbal_veda_copy/views/auth/login_user.dart';
import 'package:herbal_veda_copy/views/main_screen.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthControllers _authControllers = AuthControllers();

  late String email;

  late String fullName;

  late String phoneNum;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = await _authControllers
          .signUpUsers(email, fullName, phoneNum, password, _image!)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      if (res == "Success") {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }));
      } else {
        return showSnackBar(context, "There some error, Please try again!");
      }
      // return showSnackBar(context, "Congratulation! Account has been created");
    } else {
      setState(() {
        _isLoading = false;
      });
      print("Fields are not properly filled");
      return showSnackBar(context, "Fields must not be empty");
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authControllers.pickProfilImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 245,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      new Positioned(
                        top: 70,
                        right: MediaQuery.of(context).size.width / 2 - 62,
                        child: GestureDetector(
                          onTap: () {
                            selectGalleryImage();
                          },
                          child: _image != null ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            
                            backgroundImage: MemoryImage(
                              _image!,
                            ),
                          ) : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: Image.asset(
                              "assets/images/cam.png",
                              fit: BoxFit.cover,
                              width: 60,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 245,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 10, 35, 15),
                        child: SizedBox(
                          height: 37,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              fullName = value;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Name',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromRGBO(102, 128, 52, 1),
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                                prefixIcon: Icon(
                                  Icons.sort_by_alpha_sharp,
                                  color: Color.fromRGBO(102, 128, 52, 1),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                        child: SizedBox(
                          height: 37,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Email Address',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          const Color.fromRGBO(102, 128, 52, 1),
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color.fromRGBO(102, 128, 52, 1),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 15, 35, 10),
                        child: SizedBox(
                          height: 37,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Mobile no. must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              phoneNum = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'Mobile No.',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(102, 128, 52, 1),
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                                prefixIcon: Icon(
                                  Icons.mobile_screen_share_sharp,
                                  color: Color.fromRGBO(102, 128, 52, 1),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 15, 35, 40),
                        child: SizedBox(
                          height: 37,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(102, 128, 52, 1),
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Color.fromRGBO(102, 128, 52, 1),
                                )),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _signUpUsers();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(102, 128, 52, 1),
                            shadowColor: Color.fromRGBO(102, 128, 52, 1),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            minimumSize: Size(200, 40),
                            maximumSize: Size(200, 40),
                          ),
                          child: Center(
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Register",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginUser();
                                }));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Color.fromRGBO(102, 128, 52, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
