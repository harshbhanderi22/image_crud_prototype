import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _repaintkey = GlobalKey();

  void convertWidgetToImage( ) async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      final RenderRepaintBoundary boundary = _repaintkey.currentContext!.findRenderObject
        ()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 20);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes =await byteData!.buffer.asUint8List();
       if (pngBytes != null) {
        final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List(),);
        print(result);
        Fluttertoast.showToast(msg: "Image Saved Successfully");
      }
    }
    else{
      Permission.storage.request();
    }
  }

   

  String imagepath='';
  XFile? image;
  String DownloadUrl='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: imagepath=='' ?
            Image.asset('assests/image/photo.png') :
            Image.file(
              File(imagepath),
              height: 300,
              width: MediaQuery.of(context).size.width-50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () async{

              //Pick Image from storage
              final ImagePicker _picker = ImagePicker();
              image = await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                imagepath = image!.path.toString();
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
          SizedBox(height: 20,),
          GestureDetector(
            onTap:() async {
              var UniqueName = DateTime.now().microsecondsSinceEpoch.toString();

              //Upload in Firebase

              //1. Create Reference to Root Directory
              Reference referenceroot = FirebaseStorage.instance.ref();
              //2. Create a reference to Directory in root directory
              Reference referenceToDir = referenceroot.child('images');
              //3. Create reference for image that is going to stored in base
              //Here we will provide name that we want to store in firebase
              Reference referenceToImage = referenceToDir.child(UniqueName);

              //Uploading Image
              try{
                await referenceToImage.putFile(File(image!.path));
                DownloadUrl = await referenceToImage.getDownloadURL();
                print(DownloadUrl);
                setState(() {});
                Fluttertoast.showToast(msg: "Image Uploaded Successfully");
                Fluttertoast.showToast(msg: "${DownloadUrl.toString()}");
              }
              catch(err){
                print(err);
              }
             },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlue,
              child: Center(child: Text("Save Image")),
            ),
          ),
          SizedBox(height: 20,),
          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.black
          //   ),
          //   child: DownloadUrl=='' ? CircularProgressIndicator() : Image
          //       .network(DownloadUrl)
          // ),
        ],
      ),
    );
  }
}
