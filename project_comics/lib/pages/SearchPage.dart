import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const API_KEY = "fc80e60481c2429713aa9d3dbd43a0c9e0e50e07";

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = "%22Master%20of%";
  List<Map<String, dynamic>> _comics = [];
  List<dynamic> filteredComics = [];

  Future<void> _getComics() async {
    // https://comicvine.gamespot.com/api/search/?api_key=fc80e60481c2429713aa9d3dbd43a0c9e0e50e07&format=json&sort=name:asc&resources=issue&query=%22Master%20of%
    final url = Uri.parse(
        "https://comicvine.gamespot.com/api/search/?&api_key=$API_KEY&format=json&sort=name:asc&resources=issue&query=$_query");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      _comics =
          jsonDecode(response.body)["results"] as List<Map<String, dynamic>>;
    } else {
      _comics = [];
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 40.0),
              child: Text(
                "Search",
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: "Search comics",
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      onChanged: (value) {
                        _query = value;
                        _getComics();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _comics.length,
                  itemBuilder: (context, index) {
                    final comic = _comics[index];
                    return ListTile(
                      title: Text(comic["name"]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
