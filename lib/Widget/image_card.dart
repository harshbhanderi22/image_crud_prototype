
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/commentsPages.dart';


class ImageCard extends StatefulWidget {

  ImageCard({required this.url, required this.image_doc, required this.like_list , required this.ownerId});
  final String url;
  final String image_doc;
  final List<dynamic> like_list;
  final String ownerId;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  var userid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLiked = false;
  int likes = 0;
  @override
  Widget build(BuildContext context) {
    if(widget.like_list.contains(userid)){
      isLiked = true;
      setState(() {

      });
    }
    return Container(

        child: Column(
         children: [
           Image.network(widget.url,
             height: 140,
             width: MediaQuery.of(context).size.width,
             fit: BoxFit.fitWidth,
             loadingBuilder: (context,child, loading){
               if(loading==null){
                 return child;
               }
               else return Center(child: CircularProgressIndicator(),);
             },
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Row(
                 children: [
                   isLiked ?
                   GestureDetector(
                     onTap: (){
                         firestore.runTransaction((transaction) async {
                           final doc = await FirebaseFirestore.instance
                               .collection("images")
                               .doc(widget.image_doc);
                           transaction.update(doc, {
                             'likes': FieldValue.arrayRemove([FirebaseAuth
                                 .instance.currentUser!.uid])
                           });
                         }).then((value) => isLiked=false);

                     },
                       child: Icon(Icons.thumb_up))  :
                   GestureDetector(
                     onTap: (){
                       firestore.runTransaction((transaction) async {
                         final doc = await FirebaseFirestore.instance
                             .collection("images")
                             .doc(widget.image_doc);
                         transaction.update(doc, {
                           'likes': FieldValue.arrayUnion([FirebaseAuth
                           .instance.currentUser!.uid])
                         });
                       }).then((value) => isLiked=true);
                       },

                       child: Icon(Icons.thumb_up_alt_outlined)
                   ),
                   Text("${widget.like_list.length}")
                 ],
               ),
               Row(
                 children: [
                   InkWell(
                       onTap: () {
                         showComments(context , postId: widget.image_doc , ownerId: widget.ownerId , mediaUrl: widget.url);

                   },child: Icon(Icons.comment)),
                 ],
               ),
             ],
           )
         ],
       ),
    );
  }
}

showComments(BuildContext context , {required String postId,required String ownerId , required String mediaUrl}){


  Navigator.push(context, MaterialPageRoute(builder:  (context) {
    return CommentsPages(
      postId: postId,
      postOwnerId: ownerId,
      postMediaUrl: mediaUrl,
    );
  }));
}

