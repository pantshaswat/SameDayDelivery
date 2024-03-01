import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/features/home/views/home_page.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<Map<String, dynamic>> checkOutItems = [
    {
      "productName": "Running Shoes",
      "shopName": "Sports Emporium",
      "price": 700,
      "quantity": 2,
    },
    {
      "productName": "Wireless Earbuds",
      "shopName": "Gadget Hub",
      "price": 400,
      "quantity": 1,
    },
  ];

  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CheckoutPageAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderSummary(checkedItems: checkOutItems),
            DeliveryPlace(),
            PaymentMethod(
                selectedPaymentMethod: selectedPaymentMethod,
                onPaymentMethodSelected: (String paymentMethod) {
                  setState(() {
                    selectedPaymentMethod = paymentMethod;
                  });
                }),
            PayementDetail()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.grey, height: 82, child: PlaceOrder()),
    );
  }
}

class CheckoutPageAppBar extends StatelessWidget {
  const CheckoutPageAppBar({super.key});

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
          "Check Out",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class OrderSummary extends StatelessWidget {
  final List<Map<String, dynamic>> checkedItems;

  const OrderSummary({super.key, required this.checkedItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            "ORDER SUMMARY",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ),
        Divider(
          thickness: 3,
          indent: 20,
          endIndent: 200,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemDetail(
              item: checkedItems[index],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: checkedItems.length,
        ),
      ],
    );
  }
}

class ItemDetail extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: 110,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  item['productName'],
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  item['shopName'],
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
                  children: [
                    Text(
                      "Price:Rs. ${item['price']},",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      "Qty:${item['quantity']}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 150, 150, 150),
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

class DeliveryPlace extends StatelessWidget {
  const DeliveryPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            "DELIVERY TO",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ),
        Divider(
          thickness: 3,
          indent: 20,
          endIndent: 200,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image(
                width: 160,
                image: NetworkImage(
                  "https://joomly.net/frontend/web/images/googlemap/map.png",
                ),
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recipient",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Contact:9865374628',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Address : Dhulikhel ,KU",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class PaymentMethod extends StatefulWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethod({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool cashOnDeliveryChecked = false;
  bool digitalPaymentChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            "PAYMENT METHOD",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ),
        Divider(
          thickness: 3,
          indent: 20,
          endIndent: 200,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              SizedBox(
                width: 8,
              ),
              Icon(Icons.money),
              SizedBox(
                width: 10,
              ),
              Text(
                "Cash on Delivery",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              Spacer(),
              Checkbox(
                activeColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey,
                ),
                value: cashOnDeliveryChecked,
                onChanged: (bool? value) {
                  setState(() {
                    cashOnDeliveryChecked = value!;
                    widget.onPaymentMethodSelected(
                      cashOnDeliveryChecked
                          ? "Cash on Delivery"
                          : digitalPaymentChecked
                              ? "Digital payment"
                              : "",
                    );
                  });
                },
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              SizedBox(
                width: 8,
              ),
              Icon(Icons.web),
              SizedBox(
                width: 10,
              ),
              Text(
                "Digital payment",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              Spacer(),
              Checkbox(
                activeColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey,
                ),
                value: digitalPaymentChecked,
                onChanged: (bool? value) {
                  setState(() {
                    digitalPaymentChecked = value!;
                    widget.onPaymentMethodSelected(
                      digitalPaymentChecked
                          ? "Digital payment"
                          : cashOnDeliveryChecked
                              ? "Cash on Delivery"
                              : "",
                    );
                  });
                },
              ),
            ]),
          ),
        )
      ],
    );
  }
}

class PayementDetail extends StatelessWidget {
  const PayementDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 243, 241, 241),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PriceList(detail: "Delivery Fee", price: '65'),
              PriceList(detail: "Discount", price: '0'),
              PriceList(detail: "Items total", price: '500'),
              PriceList(detail: "Total payment", price: '565')
            ],
          ),
        ),
      ),
    );
  }
}

class PriceList extends StatelessWidget {
  final String detail;
  final String price;

  const PriceList({super.key, required this.detail, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          detail,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
        ),
      ],
    );
  }
}

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  late bool orderPlaced;

  @override
  void initState() {
    super.initState();
    orderPlaced = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 16,
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
            text: orderPlaced ? 'Continue' : 'Place Order',
            onPressed: () {
              if (orderPlaced) {
                //continue to next screen
              } else {
                Scaffold.of(context).showBottomSheet(
                  (context) {
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        orderPlaced = true;
                      });
                    });
                    return Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              width: 25,
                              image: NetworkImage(
                                "https://cdn-icons-png.freepik.com/512/190/190411.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "Your order has been placed",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
