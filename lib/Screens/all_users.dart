import 'package:flutter/material.dart';
import 'package:image_crud_demo/Widget/user_card.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
          return UserCard(
            name: "harsh",
            email: "harsh@gmail.com",
            followers: 100000,
          );
        }),
      ),
    );
  }
}
