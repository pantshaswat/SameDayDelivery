import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: NetworkImage(
                        "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"),
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              top: 93,
              right: 83,
              child: Column(
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
            ),
            Positioned(
                top: 55,
                right: 20,
                child: Icon(
                  Icons.settings,
                  size: 28,
                  color: const Color.fromARGB(255, 113, 113, 113),
                ))
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
                    icon: Icons.file_copy,
                    label: 'Preorder',
                    onPressed: () {})
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
          SizedBox(height: 8,),
          Text(label)
        ],
      ),
    );
  }
}

class Services extends StatelessWidget {
  Services({super.key});

  List<Map<String, dynamic>> services = [
    {"icon": Icons.folder, "label": "Browsing History", "onPressed": () {}},
    {"icon": Icons.location_on, "label": "Address", "onPressed": () {}},
    {"icon": Icons.support_agent_outlined, "label": "Support", "onPressed": () {}},
    {"icon": Icons.info, "label": "About Us", "onPressed": () {}}
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
          onPressed: onPressed, icon: Icon(Icons.arrow_circle_right)),
    );
  }
}
