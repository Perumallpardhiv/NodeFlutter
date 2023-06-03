import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/config.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class CreateTodo extends StatefulWidget {
  final token;
  const CreateTodo({required this.token, super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  var email;
  var id;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);

    email = jwtDecodeToken['email'];
    id = jwtDecodeToken['_id'];
  }

  void addTodo() async {
    if (title.text.isNotEmpty && desc.text.isNotEmpty) {
      var body = {
        'userId': id,
        'title': title.text,
        'desc': desc.text,
      };
      try {
        var res = await http.post(
          Uri.parse(createtodoUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );

        var json = jsonDecode(res.body);

        if (json['status'] == true) {
          print(json['success']);
          Navigator.pop(context);
        } else {
          print("Something went wrong");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Create TO-DO"),
              const SizedBox(height: 15),
              TextField(controller: title),
              const SizedBox(height: 10),
              TextField(controller: desc),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addTodo();
                },
                child: const Text("Add TODO"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
