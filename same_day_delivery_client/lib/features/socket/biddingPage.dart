import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({super.key});

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        Text('Bidding request from x to y at Rs 500'),
        TextField(
          controller: _textEditingController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        ElevatedButton(
            onPressed: () {
              socket.emit('bid', {
                "amount": _textEditingController.text,
                "riderId": '12345',
                "userId": '56789',
              });
            },
            child: Text('Send Bid'))
      ]),
    ));
  }
}
