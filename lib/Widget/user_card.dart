import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserCard extends StatelessWidget {
  UserCard({required this.name,required this.email, required this
      .followers, required this.uid});

  final String name;
   final String email;
  final List<dynamic> followers;
  final String uid;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;

    return  Container(
      color: Colors.yellow,
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$name"),
              Text("$email")
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${followers.length}"),
              Text("Follower")
            ],
          ),
          GestureDetector(
            onTap: () async{
              firebase.runTransaction((transaction) async{
                final doc =await FirebaseFirestore.instance.collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid);
                transaction.update(doc, {'followers': FieldValue.arrayUnion
                  ([uid])});
              }).then((value) => Fluttertoast.showToast(msg: "You Have Followed $name"));
            },
            child: Container(
              width: 100,
              color: Colors.blue,
              child: Center(
                child: Text("Follow"),
              ),
            ),
          )
        ],
      ),
    );
  }


}

