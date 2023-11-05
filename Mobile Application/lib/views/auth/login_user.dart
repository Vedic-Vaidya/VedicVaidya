import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/controller/auth_controller.dart';
import 'package:herbal_veda_copy/utils/show_snack_bar.dart';
import 'package:herbal_veda_copy/views/auth/register_screen.dart';
import 'package:herbal_veda_copy/views/main_screen.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthControllers _authControllers = AuthControllers();
  late String email;
  late String password;
  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = await _authControllers.loginUsers(
        email,
        password,
      );
      if (res == 'Success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }));
      } else {
        setState(() {
          _isLoading = false;
        });
        return showSnackBar(context, "Invalid Credintial");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnackBar(context, "Fields must not be empty");
    }
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
          child: Column(
            children: [
              Container(
                height: 295,
                width: double.infinity,
                child: Stack(
                  children: [
                    new Positioned(
                      bottom: 1,
                      left: 20,
                      child: Text(
                        "Welcome...",
                        style: TextStyle(
                          fontSize: 51,
                          color: Colors.white,
                          fontFamily: "GoodVibrations",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 295,
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
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                        child: SizedBox(
                          height: 37,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is mandatory";
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
                        padding: EdgeInsets.fromLTRB(35, 15, 35, 5),
                        child: SizedBox(
                          height: 37,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is mandatory";
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
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 35, 10),
                        child: InkWell(
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _loginUsers();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(102, 128, 52, 1),
                            shadowColor: Color.fromRGBO(102, 128, 52, 1),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            minimumSize: Size(100, 40),
                            maximumSize: Size(200, 40),
                          ),
                          child: Center(
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Log in",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "⎯⎯⎯⎯⎯⎯⎯⎯⎯   or  ⎯⎯⎯⎯⎯⎯⎯⎯⎯",
                          style: TextStyle(
                            color: Color.fromARGB(255, 58, 91, 59),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton.icon(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.g_mobiledata,
                                  color: Color.fromARGB(255, 235, 101, 48),
                                ),
                                label: Text(
                                  "Google   ",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )),
                            OutlinedButton.icon(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.facebook,
                                  color: Color.fromARGB(255, 29, 62, 249),
                                ),
                                label: Text(
                                  "Facebook",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterScreen();
                                }));
                              },
                              child: Text(
                                "Register",
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
