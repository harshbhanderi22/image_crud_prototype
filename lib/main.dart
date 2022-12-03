import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_crud_demo/Screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_crud_demo/Screens/loginpage.dart';
import 'package:image_crud_demo/Utilities/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.connectionState==ConnectionState.none){
              Fluttertoast.showToast(msg: "Check Your Internet");
              return Center(child: CircularProgressIndicator());

            }
            else if(snapshot.hasError){
              return Center(child: Text("Something Went Wrong"),);
            }
            else if(snapshot.hasData){
              return HomePage();
            }
            else{
              return LoginPage();
            }
          },
        ),
      )
    );
  }
}
