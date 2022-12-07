import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_crud_demo/Helper/auth_helper.dart';
import 'package:image_crud_demo/Screens/all_image.dart';
import 'package:image_crud_demo/Screens/user_images.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _repaintkey = GlobalKey();


  //Save Image in Device
  void convertWidgetToImage() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      final RenderRepaintBoundary boundary = _repaintkey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 20);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = await byteData!.buffer.asUint8List();
      if (pngBytes != null) {
        final result = await ImageGallerySaver.saveImage(
          byteData.buffer.asUint8List(),
        );
        print(result);
        Fluttertoast.showToast(msg: "Image Saved Successfully in Device");
      }
    } else {
      Permission.storage.request();
    }
  }

  String imagepath = '';
  XFile? image;
  String DownloadUrl = '';
  List image_list = [];
  var userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.black),
              child: imagepath == ''
                  ? Image.asset('assests/image/photo.png')
                  : Image.file(
                      File(imagepath),
                      height: 300,
                      width: MediaQuery.of(context).size.width - 50,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                //Pick Image from storage
                final ImagePicker _picker = ImagePicker();
                image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imagepath = image!.path;
                  print(imagepath);
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                child: Center(child: Text("Pick Image")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                color: Colors.lightBlue,
                child: Center(child: Text("Save Image")),
              ),
              onTap: () async {
                var UniqueName = DateTime.now().microsecondsSinceEpoch.toString();

                //Upload in Firebase Storage
                //1. Create Reference to Root Directory
                Reference referenceroot = FirebaseStorage.instance.ref();
                //2. Create a reference to Directory in root directory
                Reference referenceToDir = referenceroot.child('images');
                //3. Create reference for image that is going to stored in base
                //Here we will provide name that we want to store in firebase
                Reference referenceToImage = referenceToDir.child(UniqueName);
                //Uploading Image
                try {

                  //To Store Image in Firebase Storage
                  await referenceToImage.putFile(File(image!.path));
                  DownloadUrl = await referenceToImage.getDownloadURL();
                  print(DownloadUrl);
                   setState(() {});
                  Fluttertoast.showToast(msg: "Image Uploaded Successfully");
                  Fluttertoast.showToast(msg: "${DownloadUrl.toString()}");

                  //To Store image URL in firebase Firestore
                  Map<String, dynamic> imageinfo = {
                    "img_url":DownloadUrl.toString(),
                    "user_id": userid
                  };
                  firestore.collection('images').add(imageinfo).then((value) =>
                  print("Data Added Successfully"));
                } catch (err) {
                  print(err);
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {

                 //Retrive All images in List
                 // CollectionReference collectionreference = firestore.collection('images');
                 // collectionreference.get().then((value) => {
                 //    value.docs.forEach((element) {
                 //      image_list.add(element.data);
                 //    })
                 // });
                 // Fluttertoast.showToast(msg: image_list.toString());
                 // print(image_list);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayUserImages()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlueAccent,
                child: Center(child: Text("Show My Images")),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () async{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllImages()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlue,
                child: Center(child: Text("Show All Images")),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () async{
                await Authentiacation().SignOut();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlueAccent,
                child: Center(child: Text("Sign Out")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
