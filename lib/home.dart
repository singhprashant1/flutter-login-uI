
import 'package:flutter/material.dart';
import 'constent.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
        title: Text("firestore"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
              Constants.prefs.setBool("loggedIn", false);
              Navigator.pushReplacementNamed(context, "/login");
            }
            ),
          ],

        ),
      body: Stack(
        children: <Widget>[
          Image.asset("ASSETS/images1.jpeg",
            fit: BoxFit.fill,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.darken,
      ),
        ],
      ),
      drawer:Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
//            DrawerHeader(
//                child: Text("hi i am drawer",style: TextStyle(color: Colors.white),
//                ),
//              decoration: BoxDecoration(color: Colors.purpleAccent),
//            ),
        UserAccountsDrawerHeader(
        accountName: Text("prashant"),
        accountEmail: Text("prashantsingh@gmail.com"),
        currentAccountPicture: CircleAvatar(
          backgroundImage: AssetImage("ASSETS/images1.jpeg"),

        ),
      ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Account"),
                subtitle: Text("personal"),
                trailing: Icon(Icons.edit),

              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Email"),
                subtitle: Text("rajan@gmail.com"),
                trailing: Icon(Icons.send),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout",),
                onTap: (){
                  Constants.prefs.setBool("loggedIn", false);
                  Navigator.pushReplacementNamed(context, "/login");
                }
              ),
      ]
    )

      ),

    );
}
}
