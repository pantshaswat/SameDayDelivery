import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/features/socket/biddingPage.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';

void listenRideRequest(BuildContext parentContext) {
  return socket.on(
      'request',
      (request) => {
            showDialog(
              context: parentContext,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BiddingPage();
                              });
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          // return const BiddingPage();
                          // }));
                        },
                        child: const Text('Set Bid')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancle')),
                  ],
                );
              },
            )
          });
}
