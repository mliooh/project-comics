import 'package:flutter/material.dart';
import 'package:project_comics/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavBar extends StatelessWidget {
  //final VoidCallback onSignOutPressed;
  //NavBar({required this.onSignOutPressed});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Nam'),
            accountEmail: Text('nam'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/image1.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signin()),
          );
            }
            ,
            title: Text('Signout'),
          )
        ],
      ),
    );
  }
}
