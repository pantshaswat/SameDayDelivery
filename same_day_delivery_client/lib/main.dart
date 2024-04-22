import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';
import 'package:same_day_delivery_client/services/listenRideRequest.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  final navigator = goRouter.routerDelegate.navigatorKey;

  WidgetsFlutterBinding.ensureInitialized();
  socketInit();
  runApp(KhaltiScope(
    publicKey: 'test_public_key_6e1360248e6a436b835f1565a8c303bb',
    navigatorKey: navigator,
    builder: (context, _) {
      return const MaterialApp(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: [
          KhaltiLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: MyApp(),
      );
    },
    // child: const MaterialApp(
    //   home: MyApp(),
    // ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final parentContext = context;
    listenRideRequest(parentContext);
    socket.onAny((event, data) => print(event));
    socket.on(
        "success-accepted",
        (data) => {
              showDialog(
                  context: parentContext,
                  builder: (parentContext) {
                    return Scaffold(
                      body: Center(
                        child: SizedBox(
                            height: 400,
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "You have been selected for the Ride ! Ride Accepted"),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(parentContext);
                                  },
                                  child: Text("Close"),
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            });

    return MaterialApp.router(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: [
        KhaltiLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: "Same Day Delivery",
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
