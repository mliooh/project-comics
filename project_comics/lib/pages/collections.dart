import 'package:flutter/material.dart';
import 'package:project_comics/authentication/auth_service.dart';
import 'package:project_comics/components/mybottomnavbar.dart';
import 'package:project_comics/components/navbar.dart';
import 'package:project_comics/pages/SearchPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  /*final AuthService _auth = AuthService();

  Future<void> _signIn() async {
    //  sign-in logic 
    try {
     
    } catch (e) {
      print("Error during sign in: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Failed to sign in. Please check your credentials."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try{
    await _auth.signOut();
    // Navigate to the login screen or other unauthenticated pages
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signin()),
          );
  }
  catch (e)
  {print("Error during sign out: $e");}}*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
        
      ),
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text(
            'Comic Collection',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: MyBottomNavBar(index: 0),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 80, right: 40),
                child: Image.asset(
                  'lib/images/folder.png',
                  height: 300,
                  width: 200,
                ),
              ),
              const Text(
                'Your collection is empty',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                child: const Text(
                  'Add comics to your collection',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 214, 201, 82),
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
  ));}}
    
  

