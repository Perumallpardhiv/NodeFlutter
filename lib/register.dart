import 'package:flutter/material.dart';
import 'package:flutterfrontend/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              onPressed: () {},
              child: const Center(child: Text("Register")),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Center(child: Text("Login Page")),
            ),
          ],
        ),
      ),
    );
  }
}
