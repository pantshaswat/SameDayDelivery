import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          MyOrder(),
          PreviousRiders(),
          RatedRiders(),
          Services(),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      color: Color.fromARGB(255, 240, 239, 239),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Person name",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  "example@gmail.com",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 82, 82, 82),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.settings,
              size: 28,
              color: const Color.fromARGB(255, 113, 113, 113),
            )
          ],
        ),
      ),
    );
  }
}

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My orders",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                OrderStatus(
                    icon: Icons.pending_actions,
                    label: 'Pending',
                    onPressed: () {}),
                SizedBox(
                  width: 17,
                ),
                OrderStatus(
                    icon: Icons.folder, label: 'Processing', onPressed: () {}),
                SizedBox(
                  width: 17,
                ),
                OrderStatus(
                    icon: Icons.fire_truck, label: 'Shipped', onPressed: () {}),
                SizedBox(
                  width: 17,
                ),
                OrderStatus(
                    icon: Icons.reviews, label: 'Review', onPressed: () {}),
                SizedBox(
                  width: 17,
                ),
                OrderStatus(
                    icon: Icons.file_copy, label: 'Preorder', onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const OrderStatus(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: Color.fromARGB(255, 82, 82, 82),
          ),
          SizedBox(
            height: 8,
          ),
          Text(label)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Services extends StatelessWidget {
  Services({super.key});

  List<Map<String, dynamic>> services = [
    {
      "icon": Icons.logout,
      "label": "Logout",
      "onPressed": () async {
        await LocalStorage.removeToken();
        await LocalStorage.removeUser();
        goRouter.refresh();
        goRouter.go('/login');
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Services",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceTile(
                    icon: services[index]["icon"] as IconData,
                    label: services[index]["label"] as String,
                    onPressed: services[index]["onPressed"] as VoidCallback,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ServiceTile(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: IconButton(
          onPressed: onPressed, icon: const Icon(Icons.arrow_circle_right)),
    );
  }
}

class PreviousRiders extends StatelessWidget {
  const PreviousRiders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Previous Riders",
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        FutureBuilder(
          future: LocalStorage.getRider(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("An error occurred"),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("No previous riders"),
              );
            }
            return SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await LocalStorage.rateRider(snapshot.data![index], 5);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class RatedRiders extends StatelessWidget {
  const RatedRiders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rated Riders",
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        FutureBuilder(
          future: LocalStorage.getRider(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("An error occurred"),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("No previous riders"),
              );
            }
            return SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future:
                          LocalStorage.getRiderRating(snapshot.data![index]),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshots.hasError) {
                          return const Center(
                            child: Text("An error occurred"),
                          );
                        }
                        if (snapshots.data == null) {
                          return const Center(
                            child: Text("No previous riders"),
                          );
                        }
                        return ListTile(
                          title: Text(snapshot.data![index]),
                          subtitle: Text(snapshots.data.toString()),
                        );
                      });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
