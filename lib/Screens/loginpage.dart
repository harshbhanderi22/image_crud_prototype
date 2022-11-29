import 'package:flutter/material.dart';
import 'package:image_crud_demo/Helper/auth_helper.dart';
import 'package:image_crud_demo/Screens/homepage.dart';
import 'package:image_crud_demo/Utilities/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  String name="";
  bool changed =false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void moveToHome(BuildContext context) async
  {
    if(_formkey.currentState!.validate()) {
      setState(() {
        changed = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.Home);
      setState(() {
        changed = false;
      });
    }
  }
  @override
  void initState() {

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Welcome $name",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailcontroller,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return "Username cannot be Empty";
                              }
                            else
                              {
                                return null;
                              }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Username",
                            label: Text(
                              "Username",
                              style: TextStyle(color: Colors.black),
                            ),

                          ),
                          onChanged: (value){
                            setState((){
                              name=value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return "Password cannot be empty";
                              }
                            if(value.length<8)
                              {
                                return "Password length should be atleast 8";
                              }
                            else
                              {
                                return null;
                              }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            label: Text(
                              "Password",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        InkWell(
                          onTap: () async{

                            //For Login
                            Authentiacation().login(
                              _emailcontroller.text,
                              _passwordcontroller.text
                            ).then((value) =>  Navigator.pushReplacement
                              (context, MaterialPageRoute(builder: (context)
                            => HomePage())));

                            //For Registration
                            // LoginAuthentiacation().Signup(
                            //   _emailcontroller.text,
                            //   _passwordcontroller.text
                            // ).then((value) =>  Navigator.pushReplacement
                            //   (context, MaterialPageRoute(builder: (context)
                            // => HomePage())));
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height:   35 ,
                            width: changed? 35 :120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(changed ? 50
                                  :10)
                            ),
                            child: changed ? Icon(Icons.check, color: Colors.white,)
                                :Text("Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                            ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
