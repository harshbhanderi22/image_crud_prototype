import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_crud_demo/Utilities/constant.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple,
        child: ListView(
          children: [
            const DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.purple),
                  margin: EdgeInsets.zero,
                  accountName: Text("Harsh Bhanderi"),
                  accountEmail: Text("harshbhanderi188@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("images/self2.jpg"),
                  )),
            ),
            DrawerEntry(CupertinoIcons.home, "Home"),
            DrawerEntry(CupertinoIcons.profile_circled, "Profile"),
            DrawerEntry(CupertinoIcons.phone, "Contact Us"),
          ],
        ),
      ),
    );
  }
}

class DrawerEntry extends StatelessWidget {
  DrawerEntry(this.tiltIcon, this.title);

  final IconData tiltIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        tiltIcon,
        color: Colors.white,
      ),
      title: Text("$title", style: Kdrawettextstyle),
    );
  }
}
