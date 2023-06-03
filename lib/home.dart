import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterfrontend/config.dart';
import 'package:flutterfrontend/createTodo.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final token;
  const Home({required this.token, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var email;
  var userId;
  List userTodos = [];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    email = jwtDecodeToken['email'];
    userId = jwtDecodeToken['_id'];
    getUserAllTodos(userId);
  }

  void getUserAllTodos(userId) async {
    try {
      var body = {
        'userId': userId,
      };

      var res = await http.post(
        Uri.parse(userAlltodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      var json = jsonDecode(res.body);

      var items = json['success'];
      print(items);
      setState(() {
        userTodos = items;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(email),
                    GestureDetector(
                      onTap: () {
                        getUserAllTodos(userId);
                      },
                      child: Icon(Icons.replay_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userTodos.length,
                  itemBuilder: (context, index) {
                    return userTodos.isNotEmpty
                        ? ListTile(
                            title: Text(userTodos[index]['title']),
                            subtitle: Text(userTodos[index]['desc']),
                          )
                        : const Center(child: Text("No TODO"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTodo(token: widget.token),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
