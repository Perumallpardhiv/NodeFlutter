import 'package:flutter/material.dart';
import 'package:flutterfrontend/home.dart';
import 'package:flutterfrontend/register.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MainApp(token: prefs.getString('token')));
}

class MainApp extends StatelessWidget {
  final token;
  const MainApp({@required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JwtDecoder.isExpired(token) == false
          ? Home(token: token)
          : const Register(),
    );
  }
}
