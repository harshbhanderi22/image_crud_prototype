import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
class CommentCard extends StatelessWidget {
  final String username;
  final String userId;
  final String comment;
  final Timestamp timestamp;

  CommentCard({
    required this.timestamp,
    required this.username,
    required this.comment,
    required this.userId
});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("${comment}"),
          subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider(),
      ],
    );
  }
}
