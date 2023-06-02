import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Home extends StatefulWidget {
  final token;
  const Home({required this.token, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var email;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);

    email = jwtDecodeToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(email)),
    );
  }
}
