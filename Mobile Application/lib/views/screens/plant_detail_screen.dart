import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/controller/auth_controller.dart';

class PlantScreen extends StatefulWidget {
  final Uint8List pickedImage;
  final String plantId;

  const PlantScreen(
      {Key? key, required this.pickedImage, required this.plantId})
      : super(key: key);

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  List<Map<String, String>> comments = [];
  final AuthControllers _authControllers = AuthControllers();


  Future<void> fetchComments() async {
    try {
      // Use the plantId passed from the constructor
      List<Map<String, String>> fetchedComments =
          await _authControllers.fetchCommentsForPlant(widget.plantId);
      setState(() {
        comments = fetchedComments;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

    void initState() {
    super.initState();
    fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.4,
                      0.6,
                      0.9,
                      1,
                    ],
                    colors: [
                      Color.fromRGBO(158, 187, 104, 1),
                      Color.fromRGBO(190, 216, 142, 1),
                      Color.fromRGBO(231, 235, 225, 1),
                      Colors.white,
                    ],
                  ),
                ),
                width: double.infinity,
                height: 250,
                child: Image.memory(widget.pickedImage),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Ageratum",
                style: TextStyle(
                  fontSize: 32,
                  color: Color.fromRGBO(102, 128, 52, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate.",
                style: TextStyle(
                  color: Color.fromRGBO(102, 128, 52, 1),
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 110,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 70,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "COMMENTS",
                      style: TextStyle(
                          color: Color.fromRGBO(102, 128, 52, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  for (var commentData in comments)
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor:
                          Color.fromRGBO(158, 200, 79, 1).withOpacity(0.6),
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.green,
                        size: 35,
                      ),
                      dense: true,
                      visualDensity: VisualDensity(vertical: -3),
                      horizontalTitleGap: 5,
                      subtitle: Text(
                        'Comment: ${commentData['comment']}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      title: Text(
                        '${commentData['uid']}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      trailing: Icon(CupertinoIcons.heart),
                    ),
                ],
              ),
            ),
          ],
        )),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(102, 128, 52, 1),
        ),
        padding: EdgeInsets.fromLTRB(35, 8, 35, 8),
        child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Comment',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                      color: const Color.fromRGBO(102, 128, 52, 1),
                    )),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                suffixIcon: Icon(Icons.send),
                )),
      ),
    );
  }
}
