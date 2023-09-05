import 'package:flutter/material.dart';
import 'package:project_comics/components/mybottomnavbar.dart';

import 'package:project_comics/pages/SearchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<Comic> comics = [];

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
      print('Loaded userCollection: $userCollection');
    });
    await fetchComicsDetails();
  }

  Future<void> fetchComicsDetails() async {
    List<Comic> comicsList = [];

    for (int comicId in userCollection) {
      Comic? comic = await fetchComicDetails(comicId);

      if (comic != null) {
        comicsList.add(comic);
      }
    }

    setState(() {
      comics = comicsList;
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
                  if (index < comics.length) {
                    final comic = comics[index];
                    return ListTile(
                      leading: Image.network(comic.imageUrl),
                      title: Text(comic.name),
                      subtitle: Text('ID: ${comic.id}'),
                    );
                  } else {
                    return const ListTile(
                      title: Text('Comic Details Missing'),
                    );
                  }
                },
              ));
  }
}

class Comic {
  final String imageUrl;
  final String name;
  final int id;

  Comic({
    required this.imageUrl,
    required this.name,
    required this.id,
  });
}

Future<Comic?> fetchComicDetails(int comicId) async {
  final apiUrl =
      'https://comicvine.gamespot.com/api/issues/?api_key=fc80e60481c2429713aa9d3dbd43a0c9e0e50e07&format=json';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final comicData = data['results'];
      if (comicData != null) {
        final imageUrl = comicData['image']['medium_url'];
        final name = comicData['name'];
        final id = comicData['id'];
        return Comic(imageUrl: imageUrl, name: name, id: id);
      }
    } else {
      print('Error fetching comic details: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching comic details: $e');
  }
  return null; // Return null in case of errors or missing data
}
