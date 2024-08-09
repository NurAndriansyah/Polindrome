import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:palindrome/controller/user_controller.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final UserController userController = Get.find<UserController>();
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  List<dynamic> users = [];
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          hasMore) {
        _fetchUsers();
      }
    });
  }

  Future<void> _fetchUsers() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$_page&per_page=10'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _page++;
        users.addAll(data['data']);
        if (data['data'].length < 10) hasMore = false;
      });
    } else {
      // Error handling
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white, // Background putih
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            users.clear();
            _page = 1;
            hasMore = true;
          });
          await _fetchUsers();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: users.length + 1,
          itemBuilder: (context, index) {
            if (index < users.length) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['avatar']),
                ),
                title: Text(
                  '${user['first_name']} ${user['last_name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  user['email'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () {
                  userController.setSelectedUserName(
                      '${user['first_name']} ${user['last_name']}');
                  Get.back();
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: hasMore
                      ? CircularProgressIndicator()
                      : Text(
                          'No more users',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
