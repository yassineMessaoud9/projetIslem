import 'package:flutter/material.dart';
import 'package:testtech/Service/forumService.dart';
import 'package:testtech/models/ForumModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ForumService fs = ForumService();
  List<ForumItem> forumData = []; // Replace with your actual data model

  @override
  void initState() {
    super.initState();
    _fetchForumData();
  }

  List<Map<String, dynamic>> _loadedForumData = [];

  Future<void> _fetchForumData() async {
    try {
      List<Map<String, dynamic>> forumData = await ForumService().getForum();
      setState(() {
        _loadedForumData = forumData;
        forumData = _loadedForumData
            .map((item) => ForumItem(
                  title: item['title'],
                  description: item['description'],
                  image: item['image'],
                ))
            .cast<Map<String, dynamic>>()
            .toList();
      });
    } catch (error) {
      print('Error fetching forum data: $error');
    }
  }

  List<ForumItem> filterForum(String query) {
    return _loadedForumData
        .where(
            (item) => item['title'].toLowerCase().contains(query.toLowerCase()))
        .map((item) => ForumItem(
              title: item['title'],
              description: item['description'],
              image: item['image'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  forumData = filterForum(query);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search forums...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: forumData.length,
              itemBuilder: (context, index) {
                final forumItem = forumData[index];
                return ListTile(
                  leading: SizedBox(
                      width: 50, child: Image.network(forumItem.image ?? '')),
                  title: Text(forumItem.title ?? ''),
                  subtitle: Text(forumItem.description ?? ''),
                  // Add additional UI elements based on your data model
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
