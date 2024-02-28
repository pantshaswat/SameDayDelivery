import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/features/socket/biddingPage.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';

class SocketPage extends StatefulWidget {
  const SocketPage({super.key});

  @override
  State<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {
  List<dynamic> bidLists = [];
  @override
  Widget build(BuildContext context) {
    socket.on(
        'request',
        (request) => {
              print(request),
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BiddingPage();
                            }));
                          },
                          child: Text('Set Bid')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancle')),
                    ],
                  );
                },
              )
            });
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(children: [
          ElevatedButton(
              onPressed: () {
                socket.emit('requestRide', {
                  'userId': '56789',
                  'startingPoint': 'dhulikhel',
                  'endingPoint': 'banepa',
                  'amount': '100'
                });
                print('requested');
              },
              child: Text('Request Ride')),
          Expanded(
            child: StreamBuilder(
              stream: requestStreamSocket.getResponse,
              builder: (BuildContext context, snapshot) {
                bidLists.add(snapshot.data);
                if (snapshot != null && snapshot.hasData) {
                  return ListView.builder(
                    itemCount: bidLists.length,
                    itemBuilder: (context, index) {
                      ListTile(
                        title: Text(bidLists[index]),
                      );
                    },
                  );
                } else {
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
