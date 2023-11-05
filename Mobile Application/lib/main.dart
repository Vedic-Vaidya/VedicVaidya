import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/views/auth/login_user.dart';
import 'package:herbal_veda_copy/views/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
      ),
      home: LoginUser(),
    );
  }
}
