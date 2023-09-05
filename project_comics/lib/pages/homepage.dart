import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_comics/components/mybottomnavbar.dart';
import 'package:project_comics/components/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:project_comics/pages/collections.dart';
import 'package:project_comics/pages/comiccollection.dart';

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
        drawer: NavBar(),
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                        builder: (context) => ComicDetailsScreen(
                          imageUrl: comic['image']['medium_url'],
                          id: id,
                          name: comic['name'],
                          dateOfPublication:
                              comic['date_of_publication'] ?? 'Unknown',
                        ),
                      ));
                },
                leading: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: comic['image']['medium_url'],
                  height: 400,
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

class ComicDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String name;
  final int id;
  final String dateOfPublication;

  ComicDetailsScreen({
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.dateOfPublication,
  });

  @override
  _ComicDetailsScreenState createState() => _ComicDetailsScreenState();
}

class _ComicDetailsScreenState extends State<ComicDetailsScreen> {
  bool isInCollection = false;

  @override
  void initState() {
    super.initState();
    // Check if the comic is already in the collection
    checkIsInCollection();
  }

  Future<void> checkIsInCollection() async {
    bool isInCollection = await ComicCollection.isInCollection(widget.id);
    setState(() {
      this.isInCollection = isInCollection;
    });
  }

  void _addToCollection(BuildContext context) async {
    if (isInCollection) {
      // Comic is already in the collection, show a pop-up message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Comic Already in Collection'),
          content: Text('The comic is already in your collection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Add the comic to the collection
      await ComicCollection.addToCollection(widget.id);

      // Set isInCollection to true to update the heart icon color
      setState(() {
        isInCollection = true;
      });

      // Show the popup dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Comic Added to Collection'),
          content: Text('The comic has been added to your collection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Collection(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'comicImage${widget.id}',
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: Colors.black.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ID: ${widget.id}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date of Publication: ${widget.dateOfPublication}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Add the comic to the collection here and show the popup dialog
                          _addToCollection(context);
                        },
                        icon: Icon(isInCollection
                            ? Icons.favorite
                            : Icons.favorite_border),
                        label: Text(isInCollection
                            ? 'Added to Collection'
                            : 'Add to Collection'),
                        style: ElevatedButton.styleFrom(
                          primary: isInCollection ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
