import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/routes.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final List<Map<String, dynamic>> cartItems = [
    {
      "productName": "Running Shoes",
      "shopName": "Sports Emporium",
      "price": 700,
      "quantity": 2,
      "isChecked": false
    },
    {
      "productName": "Wireless Earbuds",
      "shopName": "Gadget Hub",
      "price": 400,
      "quantity": 2,
      "isChecked": true
    },
    {
      "productName": "Laptop Backpack",
      "shopName": "Tech Accessories Store",
      "price": 800,
      "quantity": 3,
      "isChecked": false
    },
    {
      "productName": "Smartwatch",
      "shopName": "Electronics World",
      "price": 900,
      "quantity": 1,
      "isChecked": true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CartPageAppBar(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return ItemDetail(cartItem: cartItems[index]);
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Container(
                height: 82,
                color: Color.fromARGB(255, 240, 239, 239),
                child: ItemsCheckout(cartItems: cartItems)),
          )
        ],
      ),
    );
  }
}

class CartPageAppBar extends StatelessWidget {
  const CartPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
              )),
        ),
        Spacer(),
        Text(
          "Cart",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        Spacer(),
        Text(
          "Delete",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 162, 123, 6)),
        ),
      ],
    );
  }
}

class ItemDetail extends StatefulWidget {
  final Map<String, dynamic> cartItem;

  const ItemDetail({Key? key, required this.cartItem}) : super(key: key);

  @override
  _ItemCountState createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemDetail> {
  int quantity = 0;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem['quantity'];
    isChecked = widget.cartItem['isChecked'];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> cartItem = widget.cartItem;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            Checkbox(
              activeColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey,
              ),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                width: 130,
                image: NetworkImage(
                  "https://cdn.thewirecutter.com/wp-content/media/2021/02/whitesneakers-2048px-4187.jpg",
                ),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cartItem['productName'],
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  cartItem['shopName'],
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 10,
                    color: const Color.fromARGB(255, 150, 150, 150),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price:Rs. ${cartItem['price']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              size: 13,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ItemsCheckout extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const ItemsCheckout({Key? key, required this.cartItems}) : super(key: key);

  @override
  _ItemsCheckoutState createState() => _ItemsCheckoutState();
}

class _ItemsCheckoutState extends State<ItemsCheckout> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> checkedItems =
        widget.cartItems.where((item) => item['isChecked'] == true).toList();
    print(checkedItems);

    int deliveryPrice = 65;
    int totalPrice = checkedItems.fold<int>(
        0,
        (sum, item) =>
            sum + (item['price'] as int) * (item['quantity'] as int));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Price: Rs. $deliveryPrice",
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 150, 150, 150),
                  ),
                ),
                Text(
                  "Total Price: Rs. $totalPrice",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomButton(
                text: 'Checkout',
                onPressed: () {
                  goRouter.go('/cart/checkout');
                }),
          )
        ],
      ),
    );
  }
}
