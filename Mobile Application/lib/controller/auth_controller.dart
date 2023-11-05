import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthControllers {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List? _image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(_image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<Map<String, dynamic>> sendImageToAPI(Uint8List _image) async {
    try {
      Uri apiUrl = Uri.parse('https://vedicvaidya.onrender.com/getPredictions');
      var request = http.MultipartRequest('POST', apiUrl);
      request.files.add(
        http.MultipartFile(
          'image',
          http.ByteStream.fromBytes(_image),
          _image.length,
          filename: 'image.jpg',
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // Image sent to the API successfully
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> apiResponse = json.decode(responseBody);
        final int plantId = apiResponse["prediction"];
        print(plantId);
        final String PlantDetails = apiResponse[
            'message'];
        print(PlantDetails);
        return {
          'plantId' : plantId.toString(),
          'PlantDetails':
              PlantDetails, // You can return other details from the API as needed
        };
      } else {
        // Handle API error here
        print('API Error: ${response.reasonPhrase}');
        throw Exception('API Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error sending image to API: $e');
      throw e;
    }
  }

  Future<List<Map<String, String>>> fetchCommentsForPlant(String plantId) async {
  try {
    Uri apiUrl = Uri.parse('https://vedicvaidya-backendapi.onrender.com/comments/plant1');
    var response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('comments')) {
        List<dynamic> commentsJson = data['comments'];
        List<Map<String, String>> comments = commentsJson
            .map((comment) {
              return {
                'comment': comment['comment'].toString(),
                'uid': comment['uid'].toString(),
              };
            })
            .toList();
        return comments;
      }
    }

    throw Exception('Failed to load comments');
  } catch (e) {
    throw e;
  }
}

  Future<Uint8List> pickProfilImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if(_file != null){
      return await _file.readAsBytes();
    } else{
      throw Exception("No Image selected");
    }
  }

  Future<String> signUpUsers(
    String email,
    String fullName,
    String phoneNum,
    String password,
    Uint8List image,
  ) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNum.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageUrl = await _uploadProfileImageToStorage(image);

        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNum': phoneNum,
          'buyerId': cred.user!.uid,
          'profileImage': profileImageUrl,
        });

        res = "Success";
      } else {
        res = "Fields must not be empty";
      }
    } catch (e) {
      print("There is some error");
      throw e;
    }
    return res;
  }

  loginUsers(String email, String password) async {
    String res = "Something went wrong";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = "Success";
      } else {
        res = "Fields must nnot be empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
