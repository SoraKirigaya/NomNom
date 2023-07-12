import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:NomNom/models/cartsmodel.dart';

import 'package:NomNom/models/usersmodel.dart';
import 'package:NomNom/services/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersModel>(context);
    return user != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Cart',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: StreamProvider<List<CartsModel>>.value(
              initialData: null,
              value: FirebaseDatabase().getCartsDetails(user.userID),
              builder: (context, child) => CartBody(
                user: user,
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class CartBody extends StatefulWidget {
  final UsersModel user;
  const CartBody({@required this.user});
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  Future<void> removefromCart(String id) async {
    final cartPath = 'users/${widget.user.userID}/cart/$id';
    final cartRef = FirebaseFirestore.instance.doc(cartPath);
    await cartRef.delete();
  }

  Future<void> addquanCart(String id) async {
    final cartPath = 'users/${widget.user.userID}/cart/$id';
    final cartRef = FirebaseFirestore.instance.doc(cartPath);
    await cartRef.update({'count': FieldValue.increment(1)});
  }

  Future<void> minquanCart(String id) async {
    final cartPath = 'users/${widget.user.userID}/cart/$id';
    final cartRef = FirebaseFirestore.instance.doc(cartPath);
    await cartRef.update({'count': FieldValue.increment(-1)});
  }

  Future<void> senttoPurcHistory(
      String userID, List<CartsModel> cartList) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    double total = 0;

    //Adding and delete cart
    if (cartList.length != 0) {
      for (int i = 0; i < cartList.length; i++) {
        total += (cartList[i].price) * (cartList[i].count);
        final cartPath = 'users/$userID/cart/${cartList[i].id}';
        final cartRef = FirebaseFirestore.instance.doc(cartPath);
        await cartRef.delete();
      }

      final histPath = 'users/$userID/history/$id';
      final histRef = FirebaseFirestore.instance.doc(histPath);
      await histRef.set({
        'price': total,
        'id': id,
      });
      context.showToast(
          msg: 'Thank you for your purchase',
          bgColor: Colors.green,
          position: VxToastPosition.top);
    } else if (cartList.length == 0) {
      context.showToast(
          msg: 'Please add product into the cart first',
          bgColor: Colors.red,
          position: VxToastPosition.top);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<List<CartsModel>>(context);

    return Scaffold(
      body: cartList != null
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemCount: cartList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 150,
                            child: CachedNetworkImage(
                              imageUrl: cartList[index].picture,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        (cartList[index].name),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '\$' +
                                          cartList[index]
                                              .price
                                              .toStringAsFixed(0),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.remove,
                                          color: Colors.red[300]),
                                      onPressed: () {
                                        if (cartList[index].count > 1) {
                                          minquanCart(cartList[index].id);
                                        } else if (cartList[index].count == 1) {
                                          removefromCart(cartList[index].id);
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    cartList[index].count.toStringAsFixed(0),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.add,
                                          color: Colors.red[300]),
                                      onPressed: () {
                                        addquanCart(cartList[index].id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  removefromCart(
                                    cartList[index].id,
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: TextButton(
        onPressed: () {
          senttoPurcHistory(widget.user.userID, cartList);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Checkout',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.green,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
