import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_crud_demo/Widget/user_card.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {

  var user_data=  FirebaseFirestore.instance.collection('users').snapshots();
  var stream1;
  List follower = [] ;

Future<void> forList() async {
    stream1=  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
   Map<String, dynamic> data = stream1.data() as Map<String, dynamic>;
   follower = (data['followers']);
   print(follower);
   print(follower.length);
}
  late bool followornot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // forList();
    forList().whenComplete((){
      setState(() {
       });
    });
    // print(follower.length);
  }



  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;

    return Scaffold(
      body: Container(
        child: StreamBuilder<Object>(
          stream: user_data,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData==false){
              return CircularProgressIndicator();
            }
             return ListView.builder(
                itemCount:  snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var uID = snapshot.data.docs[index]['uid'];
                  for(int i = 0 ; i < follower.length; i++ ){
                    if(uID == follower[i]){
                      followornot = true;
                      break;
                    }else {
                        followornot = false;
                    }
                  }
                return UserCard(
                name: snapshot.data.docs[index]['name'],
                email: snapshot.data.docs[index]['email'],
                followers: (snapshot.data.docs[index]['followers']),
                uid: snapshot.data.docs[index]['uid'],
                 );
            });
          }
        ),
      ),
    );
  }
}
