import 'package:flutter/material.dart';
import 'package:sockets/pages/home/home_page.dart';



void main() => runApp(const chatexp());

// ignore: camel_case_types
class chatexp extends StatelessWidget {
  const chatexp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat experimental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,),
      home: const HomePage(),
    );
  }
}
