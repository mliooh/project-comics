import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_comics/components/mybottomnavbar.dart';
import 'package:project_comics/components/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String apiKey = 'fc80e60481c2429713aa9d3dbd43a0c9e0e50e07';
  final String apiUrl =
      'https://comicvine.gamespot.com/api/issues/?api_key=fc80e60481c2429713aa9d3dbd43a0c9e0e50e07&format=json';

  List<dynamic> comics = [];

  @override
  void initState() {
    super.initState();
    fetchComics();
  }

  Future<void> fetchComics() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          comics = data['results'] ?? [];
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(
          email: '',
        ),
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: const Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Text(
              'Ultimate Comics',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          elevation: 0,
        ),
        bottomNavigationBar: const MyBottomNavBar(index: 0),
        body: ListView.builder(
          itemCount: comics.length,
          itemBuilder: (context, index) {
            final comic = comics[index];
            final id = comic['id'] ?? 0;
            if (comic['image'] != null && comic['name'] != null) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicDetailsPage(
                          name: '',
                          description: '',
                          id: id,
                          imageUrl: '',
                        ),
                      ));
                },
                leading: CachedNetworkImage(
                  height: 300,
                  imageUrl: comic['image']['medium_url'],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text(
                  comic['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  comic['id'].toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              );
            } else {
              return const SizedBox
                  .shrink(); // Hide comics without essential data
            }
          },
        ));
  }
}

class ComicDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String name;
  final int id;
  final String description;

  const ComicDetailsPage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.description,
  });

  @override
  State<ComicDetailsPage> createState() => _ComicDetailsPageState();
}

class _ComicDetailsPageState extends State<ComicDetailsPage> {
  List<int> userCollection = [];
  bool isInCollection = false;

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

  Future<void> addToCollection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCollection.add(widget.id);
      prefs.setStringList(
          'userCollection', userCollection.map((id) => id.toString()).toList());
      isInCollection = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.imageUrl),
            const SizedBox(height: 16.0),
            Text('ID: ${widget.id}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            Text(widget.description, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isInCollection ? null : addToCollection,
              child: Text(
                  isInCollection ? 'Added to Collection' : 'Add to Collection'),
            ),
          ],
        ),
      ),
    );
  }
}
