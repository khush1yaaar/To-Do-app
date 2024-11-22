import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todoappp/screens/config.dart';
import 'package:todoappp/widgets/dialogs.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var token;
  HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userId;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Dialogs dialogs = Dialogs();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken["_id"];
  }

  void addTodo() async {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      var reqBody = {
        "userId": userId,
        "title": titleController.text,
        "desc": descriptionController.text
      };

      var response = await http.post(
        Uri.parse(storeTodo),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        titleController.clear();
        descriptionController.clear();
        Navigator.pop(context);
      } else {
        print("something went wrong!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dialogs.displayTextInputDialog(
            context, titleController, descriptionController, addTodo),
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
