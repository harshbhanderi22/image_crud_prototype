import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_crud_demo/Widget/user_card.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {

  var user_data=  FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
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
                return UserCard(
                name: snapshot.data.docs[index]['name'],
                email: snapshot.data.docs[index]['email'],
                followers: (snapshot.data.docs[index]['followers']),
                    uid: snapshot.data.docs[index]['uid']
                );
            });
          }
        ),
      ),
    );
  }
}
