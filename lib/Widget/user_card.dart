import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserCard extends StatefulWidget {
  UserCard(
      {required this.name,
      required this.email,
      required this.followers,
      required this.uid});

  final String name;
  final String email;
  final List<dynamic> followers;
  final String uid;

  @override
  State<UserCard> createState() => _UserCardState();
}

var user_data=  FirebaseFirestore.instance.collection('users').snapshots();
var stream1;
List follower = [] ;

Future<void> forList() async {
  stream1 = await FirebaseFirestore.instance.collection('users').doc(
      FirebaseAuth.instance.currentUser!.uid).get();
  Map<String, dynamic> data = stream1.data() as Map<String, dynamic>;
  follower = (data['followers']);
  print(follower);
  print(follower.length);
}



class _UserCardState extends State<UserCard> {
  bool follow = false;
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
    forList();
    for(int i = 0 ; i < follower.length; i++ ){
      if(widget.uid == follower[i]){
        setState(() {
          follow = true;
        });
        break;
      }else {
        setState(() {
          follow = false;
        });
      }
    }
    return Container(
      color: Colors.yellow,
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("${widget.name}"), Text("${widget.email}")],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("${widget.followers.length}"), Text("Following")],
          ),
          GestureDetector(
            onTap: () async {

              if (follow == false) {
                firebase.runTransaction((transaction) async {
                  final doc = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid);
                  transaction.update(doc, {
                    'followers': FieldValue.arrayUnion([widget.uid])
                  });
                }).then((value) {
                  forList().whenComplete(() {
                    setState(() {

                    });
                  });
                  Fluttertoast.showToast(
                      msg: "You Have "
                          "UnFollowed ${widget.name}");
                });
                print(follow);
              } else {
                firebase.runTransaction((transaction) async {
                  final doc = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid);
                  transaction.update(doc, {
                    'followers': FieldValue.arrayRemove([widget.uid])
                  });
                }).then((value) {
                  forList().whenComplete(() {
                    setState(() {

                    });
                  });
                  Fluttertoast.showToast(
                      msg: "You Have "
                          "UnFollowed ${widget.name}");
                });
                print(follow);
              }
            },
            child: Container(
              width: 100,
              color: follow ? Colors.red : Colors.blue,
              child: Center(
                child: follow ? Text("Unfollow") : Text('Follow'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
