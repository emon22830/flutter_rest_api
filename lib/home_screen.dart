import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Models/PostModel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postlist = [];

  // Fetch data from API
  Future<List<PostModel>> getPostApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postlist.clear(); // Clear list before adding new data
      for (var i in data) {
        postlist.add(PostModel.fromJson(i as Map<String, dynamic>)); // Casting
      }
      return postlist;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('API Test'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postlist[index].title.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5), // Spacer between title and body
                              Text(postlist[index].body.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
