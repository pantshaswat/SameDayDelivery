import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/features/socket/biddingPage.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';
import 'package:same_day_delivery_client/services/listenRideRequest.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  socketInit();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final parentContext = context;
    listenRideRequest(parentContext);
    socket.onAny((event, data) => print(event));
    socket.on(
        "success",
        (data) => {
              showDialog(
                  context: parentContext,
                  builder: (parentContext) {
                    return Center(
                      child: Container(
                          height: 400,
                          width: 400,
                          child: Text(data[0].toString())),
                    );
                  })
            });
    return MaterialApp.router(
      title: "Same Day Delivery",
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
