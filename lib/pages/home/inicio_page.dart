import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sockets/pages/home/home_page.dart';
import 'dart:io';
import 'group_page.dart';


class IniPage extends StatefulWidget {
  final String name;
  final String ip;
  final String port;
  final String num;

  const IniPage({Key? key, required this.name, required this.ip, required this.port, required this.num})
      : super(key: key);

  @override
  State<IniPage> createState() => _IniPageState();
}

class _IniPageState extends State<IniPage> {
  List<ServerConnection> _connections = [];
  List<Socket> _sockets = [];
  bool _isConnecting = false;

  

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _numController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeConnections();
  }

  void _initializeConnections() {
    // Aquí puedes agregar tus conexiones de servidor iniciales utilizando los datos proporcionados por widget.
    _connections.addAll(
      [
        ServerConnection(name: "key", ip: "-", port: "-", number: "123456", messages: []),
        ServerConnection(name: "victor", ip: "-", port: "-", number: "654321", messages: [])
      ]
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: const Text('Chats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresar a la vista anterior
            Navigator.push(context, MaterialPageRoute(builder: 
                      (context) => HomePage()));
          },
        ),
      ),
      body: ListView.builder(
      itemCount: _connections.length,
      itemBuilder: (context, index) {
        final connection = _connections[index];

        return ListTile(
          leading: CircleAvatar(
            child: Text(connection.name[0]),
          ),
          title: Text(connection.name),
          subtitle: Text('Number: ${connection.number} | Status: ${connection.status}'),
          onTap: _isConnecting
              ? null
              : () {
                    String name = _nameController.text;
                    String senderNum = widget.num;
                    String targetNum = connection.number;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupPage(name: name, ip: widget.ip, port: widget.port, senderNum: senderNum, targetNum:targetNum)),
                  );
                },
        );
      },
    ),
  );
}
}

class Message
{
  final String senderNumber;
  final String targetNumber;
  final String data;

  Message(this.senderNumber, this.targetNumber, this.data);

  Message.fromJson(Map<String, dynamic> json)
      : senderNumber = json['senderNumber'],
        targetNumber = json['targetNumber'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
    'senderNumber': senderNumber,
    'targetNumber': targetNumber,
    'data': data
  };
}

class ServerConnection {
  final String name;
  final String ip;
  final String port;
  final String number;
  List<String> messages;
  String status;

  ServerConnection({
    required this.name,
    required this.ip,
    required this.port,
    required this.number,
    required this.messages,
    this.status = 'Desconectado'
  });
}