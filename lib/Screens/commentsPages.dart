import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widget/comment_card.dart';

class CommentsPages extends StatefulWidget {

  final String postId;
  final String postOwnerId;
  final String postMediaUrl;
  CommentsPages({
    required this.postId,
    required this.postMediaUrl,
    required this.postOwnerId
});

  @override
  _CommentsPagesState createState() => _CommentsPagesState();
}

class _CommentsPagesState extends State<CommentsPages> {
  TextEditingController commentController = TextEditingController();
  var commentRef = FirebaseFirestore.instance.collection('comments');
  var currentUsername = FirebaseAuth.instance.currentUser!.email;
  var currentUserid= FirebaseAuth.instance.currentUser!.uid;
  buildComments() {
    return StreamBuilder(
        stream: commentRef.doc(widget.postId).collection("Comments").orderBy("timestamp",descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          List<CommentCard> commentList = [];
          for(int i =  0 ; i < snapshot.data.docs.length ; i++){
            commentList.add(CommentCard(
                timestamp: snapshot.data.docs[i]["timestamp"],
                username: snapshot.data.docs[i]["userName"],
                comment: snapshot.data.docs[i]["comment"],
                userId: snapshot.data.docs[i]["userId"]));
          }
          return ListView(
            children: commentList,
          );

        });
  }
  addComment() {
    commentRef.doc(widget.postId).collection("Comments").add({
      "userName" : currentUsername,
      "comment" : commentController.text,
      "timestamp": DateTime.now(),
      "userId": currentUserid,

    });
    commentController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: buildComments(),
          ),
          Divider(),
          ListTile(
            title: TextField(
              controller: commentController,
              decoration: const InputDecoration(
                labelText: "Write a Comment..."
              ),
            ),
            trailing: InkWell(
              onTap: addComment,
              child: const Text("Post"),
            ),
          )
        ],
      ),
    );
  }
}
