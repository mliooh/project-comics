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
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Text("Search Comics"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: "Search comics"),
            onChanged: (value) {
              _query = value;
              _getComics();
            },
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
    );
  }
}
