import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/config.dart';
import 'package:flutterfrontend/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void login() async {
    if (email.text.isNotEmpty && pwd.text.isNotEmpty) {
      var reqBody = {
        'email': email.text,
        'password': pwd.text,
      };

      try {
        var res = await http.post(
          Uri.parse(loginUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );

        var json = jsonDecode(res.body);

        if (json['status'] == true) {
          print("Logged In Successfully");

          var mytoken = json['token'];
          prefs.setString("token", mytoken);

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home(token: mytoken)),
            (route) => false,
          );
        } else if (json['status'] == false) {
          print("Some Error");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Pls fill the requierd fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login to your Account"),
              const SizedBox(height: 20),
              TextField(controller: email),
              const SizedBox(height: 10),
              TextField(controller: pwd),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Center(child: Text("Login")),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Center(child: Text("Register Page")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
