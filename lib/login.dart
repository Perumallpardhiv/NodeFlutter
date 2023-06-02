import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();

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
                onPressed: () {},
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
