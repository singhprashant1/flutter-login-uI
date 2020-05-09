import 'package:jmd3/Bgimage.dart';
import 'package:jmd3/secondscreen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Bgimage.dart';
import 'constent.dart';



class  LoginPage extends StatefulWidget {


  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void  initState(){
    super.initState();

  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
// If all data are correct then save data to out variables
      _formKey.currentState.save();
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.greenAccent,
      resizeToAvoidBottomPadding: false,
      body: Stack(

        fit: StackFit.expand,
        children: <Widget>[
          BgImage(),
          Padding(
            padding: const EdgeInsets.only(bottom: 400.0),
            child: Center(child: Text("Sign In",style: TextStyle(fontSize: 60,color: Colors.white,fontWeight: FontWeight.bold),)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: new Column(
                            children: <Widget>[
                              new TextFormField(
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter Email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                                onSaved: (String val){
                                  _email = val;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter Password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (input){
                                  if(input.length < 8)
                                    return 'Empty or less then 8 cher';
                                  return null;
                                },
                                onSaved: (input){
                                  _password = input;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    MaterialButton(
                                      height: 40,
                                      minWidth: 300,
                                      color: Colors.teal,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                      child: new Text("Login", style: TextStyle(color: Colors.white),),
                                      onPressed: () {
                                        Constants.prefs.setBool("loggedIn", true);
                                        _validateInputs();
                                        signIn();
                                      },
                                      splashColor: Colors.redAccent,
                                    ),
                                    FlatButton(
                                      child: new Text("Create an account", style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 20.0),),
                                      onPressed: (){
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>SecondScreen()),
                                        );
                                      },
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
  Future<void> signIn() async {
    final formState =  _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.pushReplacementNamed(context, "/home");

      }catch(e){
        print(e.message);
        Toast.show(e.message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }

    }
  }
}
String validateEmail(String value) {
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regexp = new RegExp(pattern);
  if (!regexp.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
