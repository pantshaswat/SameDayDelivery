import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';
import 'package:same_day_delivery_client/model/user.model.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';
import 'package:same_day_delivery_client/services/location.dart';

class RiderSelectPage extends StatefulWidget {
  final GeoPoint startPoint;
  final GeoPoint endPoint;
  const RiderSelectPage({
    super.key,
    required this.startPoint,
    required this.endPoint,
  });

  @override
  State<RiderSelectPage> createState() => _RiderSelectPage();
}

class _RiderSelectPage extends State<RiderSelectPage> {
  StreamSocket requestStreamSocket = StreamSocket();
  late MapController controller;
  late StaticPositionGeoPoint point1, point2;

  List<dynamic> bidLists = [];

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initPosition: widget.endPoint,
    );

    point1 = StaticPositionGeoPoint(
      widget.startPoint.toString(),
      const MarkerIcon(
        icon: Icon(Icons.pin_drop, color: Colors.purple),
      ),
      [widget.startPoint],
    );
    point2 = StaticPositionGeoPoint(
      widget.endPoint.toString(),
      const MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
        ),
      ),
      [widget.endPoint],
    );
  }

  drawRoad() async {
    RoadInfo roadInfo = await controller.drawRoad(
      widget.startPoint,
      widget.endPoint,
      roadType: RoadType.car,
      roadOption: const RoadOption(
        roadWidth: 5,
        roadColor: Colors.deepPurple,
        zoomInto: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    socket.on('bid', (data) {
      requestStreamSocket.addResponse(data);
    });

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     RoadInfo roadInfo = await controller.drawRoad(
      //       widget.startPoint,
      //       widget.endPoint,
      //       roadType: RoadType.car,
      //       roadOption: RoadOption(
      //         roadWidth: 10,
      //         roadColor: Colors.blue,
      //         zoomInto: true,
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.arrow_back),
      // ),
      appBar: AppBar(
          title: const Text('Delivery Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(children: [
            //show OSM MAP
            Expanded(
              child: Stack(
                children: [
                  RiderPageMap(
                      controller: controller, point1: point1, point2: point2),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      backgroundColor: Colors.orangeAccent,
                      elevation: 0,
                      onPressed: () {
                        drawRoad();
                      },
                      child: const Icon(Icons.directions),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    right: 10,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      child: const Icon(Icons.my_location),
                      onPressed: () async {
                        final position = await LocationService().getLocation();

                        controller.changeLocation(
                          GeoPoint(
                              latitude: position.latitude,
                              longitude: position.longitude),
                        );
                        controller.zoomIn();
                      },
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Order No.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      "${((LocationService().getDistance(widget.startPoint, widget.endPoint)) / 1000).toStringAsFixed(2)} km",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "From:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FutureBuilder(
                        future:
                            LocationService().getPlaceName(widget.startPoint),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading...');
                          }
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.street.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return const Text('Error');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "To:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FutureBuilder(
                          future:
                              LocationService().getPlaceName(widget.endPoint),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.street.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return const Text('Error');
                          }),
                    ],
                  ),
                ),
              ],
            ),
            // Spacer(),
            FutureBuilder(
                future: LocalStorage.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomButton(text: "Loading...", onPressed: () {});
                  }

                  return CustomButton(
                      onPressed: () async {
                        // final UserModel? user = await LocalStorage.getUser();
                        final id = snapshot.data!.userId;
                        socket.emit(
                          'riderConnected',
                          {
                            "_id": id,
                            "name": "Shaswat",
                            "riderId": "12345",
                          },
                        );
                      },
                      text: Text("Be a Rider"));
                }),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () async {
                //check if mounted

                final UserModel? user = await LocalStorage.getUser();
                await LocalStorage.saveRider(user!.userId!);
                socket.emit('requestRide', {
                  'userId': user!.userId,
                  'startingPoint': 'dhulikhel',
                  'endingPoint': 'banepa',
                  'amount': '100'
                });
              },
              text: const Text("Request a Ride"),
            ),
            RiderBids(requestStreamSocket: requestStreamSocket, bidLists: bidLists),
          ])),
        ),
      ),
    );
  }
}

class RiderBids extends StatelessWidget {
  const RiderBids({
    super.key,
    required this.requestStreamSocket,
    required this.bidLists,
  });

  final StreamSocket requestStreamSocket;
  final List bidLists;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: requestStreamSocket.getResponse,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(),
            );
          }
          bidLists.add(snapshot.data![0]);
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Bids'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: bidLists.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text(bidLists[index]['riderId']),
                  subtitle: Text(bidLists[index]['amount']),
                  trailing: GestureDetector(
                    onTap: () async {
                      socket.emit('riderSelected', {
                        "riderId": bidLists[index]['riderId'],
                        "userId": '56789',
                        "amount": bidLists[index]['amount'],
                        "from": "dhulikhel",
                        "to": "banepa"
                      });
    
                      await LocalStorage.saveRider(
                          bidLists[index]['riderId']);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Select ->',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}

class RiderPageMap extends StatelessWidget {
  const RiderPageMap({
    super.key,
    required this.controller,
    required this.point1,
    required this.point2,
  });

  final MapController controller;
  final StaticPositionGeoPoint point1;
  final StaticPositionGeoPoint point2;

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      osmOption: OSMOption(
        // userTrackingOption: UserTrackingOption(
        //   enableTracking: true,
        //   unFollowUser: true,
        // ),
        staticPoints: [point1, point2],
        showZoomController: true,
        markerOption: MarkerOption(),
        isPicker: false,
        zoomOption: const ZoomOption(
          minZoomLevel: 4,
          maxZoomLevel: 19,
          initZoom: 10,
        ),
      ),
    );
  }
}
