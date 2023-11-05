import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/views/auth/login_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.05,
                      0.15,
                      0.3,
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
                    height: 60, 
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Color.fromRGBO(102, 128, 52, 1),
                      backgroundImage: NetworkImage(data['profileImage']),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data['fullName'].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Veronica-Script',
                        color: Color.fromRGBO(102, 128, 52, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      data['phoneNum'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(102, 128, 52, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      data['email'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(102, 128, 52, 1),
                      ),
                    ),
                  ),
            
                  ElevatedButton(
                    onPressed: (){}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(102, 128, 52, 1),
                      shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Edit  profile",
                        style: TextStyle(
                          fontSize: 17
                        ),
                      ),
                    )
                  ),
            
                  SizedBox(
                    height: 30,
                  ),
            
                  ListTile(
                    leading: Icon(
                      Icons.headset_mic_outlined,
                      color: Color.fromRGBO(102, 128, 52, 1),
                    ),
                    title: Text("Customer Care"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Color.fromRGBO(102, 128, 52, 1),
                    ),
                    title: Text("History"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Color.fromRGBO(102, 128, 52, 1),
                    ),
                    title: Text("About"),
                  ),
                  ListTile(
                    onTap: () async{
                      await _auth.signOut().whenComplete(() {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context){
                          return LoginUser();
                        })
                        );
                      });
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Color.fromRGBO(102, 128, 52, 1),
                    ),
                    title: Text("Logout"),
                  ),
                ],
              ),
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}