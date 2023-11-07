import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../components/profile_data.dart';

class ImageUploads extends StatefulWidget {
  final ProfileData profileData;
  const ImageUploads(
      {Key? key, required BuildContext context, required this.profileData})
      : super(key: key);

  @override
  ImageUploadsState createState() => ImageUploadsState();
}

class ImageUploadsState extends State<ImageUploads> {
  String? uploadedImageURL;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth userCredential = FirebaseAuth.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;

    final user = userCredential.currentUser;
    if (user == null) {
      print('User not authenticated.');
      return;
    }

    final userUid = user.uid;
    final fileName = basename(_photo!.path);
    final destination = 'users/$userUid/profile_images/$fileName';

    try {
      final ref = storage.ref(destination);
      await ref.putFile(_photo!);
      final downloadURL = await ref.getDownloadURL();
      downloadURL.toString().trim();
      _updateUserProfile(downloadURL);
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void _updateUserProfile(String downloadURL) {
    final user = userCredential.currentUser;
    if (user == null) {
      print('User not authenticated.');
      return;
    }

    final userUid = user.uid;

    final userRef = FirebaseFirestore.instance.collection('profiles');
    final Query query = userRef.where('user_id', isEqualTo: userUid);

    query.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot doc = querySnapshot.docs.first;
        final docId = doc.id;

        userRef.doc(docId).update({
          'profileImageUrl': downloadURL,
        }).then((_) {
          print('User profile updated with image URL');
          widget.profileData.setProfileImageUrl(downloadURL);
        }).catchError((error) {
          print('Error updating user profile: $error');
        });
      } else {
        print('User not found with UID: $userUid the user is $user');
      }
    }).catchError((error) {
      print('Error searching for user: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileData>(
        builder: (BuildContext context, profileData, Widget? child) {
      return GestureDetector(
          onTap: imgFromGallery,
          child: Text(
            "Change Profile Photo",
            
          ));
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
