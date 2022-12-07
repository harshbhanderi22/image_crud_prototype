import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  UserCard({required this.name,required this.email, required this
      .followers});

  final String name;
   final String email;
  final int followers;

  @override
  Widget build(BuildContext context) {
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
              Text("$followers"),
              Text("Follower")
            ],
          ),
          Container(
            width: 100,
            color: Colors.blue,
            child: Center(
              child: Text("Follow"),
            ),
          )
        ],
      ),
    );
  }


}

