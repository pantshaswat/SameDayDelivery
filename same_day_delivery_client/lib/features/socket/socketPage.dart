import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';

class SocketPage extends StatefulWidget {
  const SocketPage({super.key});

  @override
  State<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(children: [
          ElevatedButton(
              onPressed: () {
                socket.emit('requestRide', 'i need a ride');
              },
              child: Text('send')),
          Expanded(
            child: StreamBuilder(
              stream: streamSocket.getResponse,
              builder: (BuildContext context, snapshot) {
                if (snapshot != null && snapshot.hasData) {
                  print('smth');
                  return Text(snapshot.data!.toString());
                } else {
                  print('nops');
                  return Center(
                    child: Text('no data'),
                  );
                }
              },
            ),
          ),
        ])),
      ),
    );
  }
}
