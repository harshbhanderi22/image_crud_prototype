import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_crud_demo/Widget/image_card.dart';

class AllImages extends StatefulWidget {
  const AllImages({Key? key}) : super(key: key);

  @override
  State<AllImages> createState() => _AllImagesState();
}

class _AllImagesState extends State<AllImages> {

  var image_data=  FirebaseFirestore.instance.collection('images')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
          stream: image_data,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData==false) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24.0,
                    mainAxisSpacing: 40,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  String url = snapshot.data.docs[index]['img_url'];
                  String docid = snapshot.data.docs[index].id;
                  List<dynamic> like = snapshot.data.docs[index]['likes'];
                  return Card(
                    color: Colors.amber,
                    child: Center(child: ImageCard(url: url, image_doc:
                    docid, like_list: like, )),
                  );
                }
            );
          }
      )
    );
  }
}
