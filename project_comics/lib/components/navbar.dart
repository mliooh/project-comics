import 'package:flutter/material.dart';
import 'package:project_comics/pages/collections.dart';
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
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/image1.jpg'),
                    fit: BoxFit.cover)),
            accountName: null,
            accountEmail: null,
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Collection()));
            },
            title: const Text('My Collection'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const signin()),
              );
            },
            title: const Text('Signout'),
          ),
        ],
      ),
    );
  }
}
