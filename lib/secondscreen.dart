import 'package:jmd3/Bgimage.dart';
import 'package:jmd3/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>  with SingleTickerProviderStateMixin{

  String _email1, _password1 , _repassword;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();


  @override
  void  initState(){
    super.initState();
  }
  void _validateInputs1() {
    if (_formKey1.currentState.validate()) {
// If all data are correct then save data to out variables
      _formKey1.currentState.save();

    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BgImage(),
          Padding(
            padding: const EdgeInsets.only(bottom: 400.0),
            child: Center(child: Text("Register",style: TextStyle(fontSize: 60,color: Colors.white,fontWeight: FontWeight.bold),)),
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
                        key: _formKey1,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter Email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail1,
                                onSaved: (String val){
                                  _email1 = val;
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
                                controller: _pass,
                                validator: (val){
                                  if( val.length < 8)
                                    return 'Empty or less then 8 cher';
                                  return null;
                                },

                                onSaved: (String val){
                                  _password1 = val;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "ReEnter Password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: _confirmPass,
                                validator: (val){
                                  if(val != _pass.text)
                                    return 'Not Match';
                                  return null;
                                },

                                onSaved: (String val){
                                  _repassword = val;
                                },

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 300.0,
                                  height: 40,
                                  child: RaisedButton(
                                    color: Colors.teal,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: new Text("Register", style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      _validateInputs1();
                                      signUp();
                                    },
                                    splashColor: Colors.redAccent,
                                  ),
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
  void signUp() async {
    if(_formKey1.currentState.validate()){
      _formKey1.currentState.save();
      try{

        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email1, password: _password1)).user;
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)  => LoginPage()));
        Toast.show("regisered", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      }catch(e){
        print(e.message);
        Toast.show(e.message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    }
  }
}
String validateEmail1(String value) {
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regexp = new RegExp(pattern);
  if (!regexp.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}