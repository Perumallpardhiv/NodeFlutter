import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/config.dart';
import 'package:flutterfrontend/login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();

  void register() async {
    if (email.text.isNotEmpty && pwd.text.isNotEmpty) {
      var regBody = {
        'email': email.text,
        'password': pwd.text,
      };

      try {
        var res = await http.post(
          Uri.parse(registerUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        var json = jsonDecode(res.body);

        if (json['status'] == true) {
          print("Register Successfully");
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
          );
        } else if (json['status'] == false) {
          print("User already exist");
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
              const Text("Create Your Account"),
              const SizedBox(height: 20),
              TextField(controller: email),
              const SizedBox(height: 10),
              TextField(controller: pwd),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  register();
                },
                child: const Center(child: Text("Register")),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Center(child: Text("Login Page")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
