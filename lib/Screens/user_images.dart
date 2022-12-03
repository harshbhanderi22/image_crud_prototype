import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DisplayUserImages extends StatefulWidget {
  @override
  State<DisplayUserImages> createState() => _DisplayUserImagesState();
}

class _DisplayUserImagesState extends State<DisplayUserImages> {

  var userid = FirebaseAuth.instance.currentUser!.uid;
  var image_data;


  @override
  void initState() {
    super.initState();
    //To load image at init time else red screen will be displayed
    image_data=  FirebaseFirestore.instance.collection('images')
        .snapshots();

   }

  @override
  Widget build(BuildContext context){
    //============
    //Declared in Build method so that it can become empty everytime else
    // same photos will be added in list everytime screen restarted
    //===========
    List user_images=[];
    return Scaffold(
      body: StreamBuilder(
        stream: image_data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData==false){
            return Center(child: CircularProgressIndicator());
          }
          for(int i=0;i<snapshot.data.docs.length;i++){
            if(snapshot.data.docs[i]['user_id']==userid){
              user_images.add(snapshot.data.docs[i]['img_url']);
            }
          }

          // =======Listview For given images=========
          // ListView.builder(
          //   itemCount: user_images.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Image.network(user_images[index]),
          //     );
          //   },
          // );
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                  crossAxisSpacing: 24.0,
                  mainAxisSpacing: 40,
                  childAspectRatio: 0.80
              ),
              itemCount: user_images.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.amber,
                  child: Center(child: Image.network(user_images[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context,child, loading){
                    if(loading==null){
                      return child;
                    }
                    else return Center(child: CircularProgressIndicator(),);
                  },
                  )),
                );
              }
          );
        }
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
          child: Image.network(url),
        );
      },
    );
  }
}


//Single Gridview to return all images

// StreamBuilder(
// stream: user_images,
// builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
// if (!snapshot.hasData) return CircularProgressIndicator();
// return GridView.builder(
// itemCount: snapshot.data.docs.length,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// crossAxisSpacing: 4.0,
// mainAxisSpacing: 4.0),
// itemBuilder: (BuildContext context, int index) {
// String url = snapshot.data.docs[index]['img_url'];
// String uid = snapshot.data.docs[index]['user_id'];
// if (uid == userid) {
// return GestureDetector(
// onTap: () {
// _showMyDialog(url);
// },
// child: Image.network(url, fit: BoxFit.cover,)
// );
// } else {
// return Center(child: Text("You have not uploaded anything"),
// );
// }
// },
// );
// },
//
// );