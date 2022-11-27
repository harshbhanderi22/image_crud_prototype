import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';

class DisplayImages extends StatefulWidget {

  // DisplayImages(this.image_list);
  // final List image_list;

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {

  var image_data = FirebaseFirestore.instance.collection('images').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: image_data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          return GridView.builder(
            itemCount: snapshot.data.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              String url = snapshot.data.docs[index]['img_url'];
              return GestureDetector(
                   onLongPress: (){
                     _showMyDialog(url);
                   },
                  child: Image.network(url));
            },
          );
        },

      )
    );
  }

  Future<void> _showMyDialog(String url) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width-50,
          child: (url.isEmpty) ? CircularProgressIndicator() : Image.network(url),
        );
      },
    );
  }
}
