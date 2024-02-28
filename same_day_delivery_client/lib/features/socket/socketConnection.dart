import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  final _socketResponse = StreamController<List<dynamic>>();

  void Function(List<dynamic>) get addResponse => _socketResponse.sink.add;

  Stream<List<dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket requestStreamSocket = StreamSocket();
late IO.Socket socket;
void socketInit() {
  socket = IO.io('http://localhost:3000', <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  socket.connect();
  socket.onConnect((_) {
    print('connected');
    socket.emit('msg', 'test');
  });
  socket.emit('riderConnected', {"name": "Shaswat", "riderId": "12345"});
  socket.on('bid', (data) {
    requestStreamSocket.addResponse(data);
  });
  socket.onDisconnect((_) => print('disconnect'));
}
