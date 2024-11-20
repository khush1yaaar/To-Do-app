import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var token;
  HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken["email"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(email),
      ),
    );
  }
}
