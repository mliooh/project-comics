import 'package:flutter/material.dart';
import 'package:project_comics/components/mybottomnavbar.dart';

import 'package:project_comics/pages/SearchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Collection extends StatefulWidget {
  const Collection({
    super.key,
  });

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
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

  List<int> userCollection = [];

  @override
  void initState() {
    super.initState();
    loadUserCollection();
  }

  Future<void> loadUserCollection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCollection =
          prefs.getStringList('userCollection')?.map(int.parse).toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: userCollection.isEmpty
          ? Center(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, top: 80, right: 40),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()));
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
            )
          : ListView.builder(
              itemCount: userCollection.length,
              itemBuilder: (context, index) {
                final comicId = userCollection[index];
                // Here, you can fetch the detailed information about each comic using the Comic Vine API or any other data source
                // You can use FutureBuilder or any state management solution to handle fetching data for each comic.
                // For simplicity, I'll just display the comic ID in this example.
                return ListTile(
                  title: Text('Comic ID: $comicId'),
                );
              },
            ),
    );
  }
}
