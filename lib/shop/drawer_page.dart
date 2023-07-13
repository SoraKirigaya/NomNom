import 'package:NomNom/services/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:NomNom/models/cartsmodel.dart';
import 'package:NomNom/models/itemsmodel.dart';
import 'package:NomNom/models/usersmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future drawer(
    BuildContext context, ItemsModel itemsModel, UsersModel usersModel) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    // isScrollControlled: true,
    context: context,
    builder: (context) {
      return StreamProvider<List<CartsModel>?>.value(
        initialData: null,
        value: FirebaseDatabase().getCartsDetails(usersModel.userID!),
        builder: (context, child) => DrawerBody(
          itemsModel: itemsModel,
          usersModel: usersModel,
        ),
      );
    },
  );
}

class DrawerBody extends StatefulWidget {
  final UsersModel usersModel;
  final ItemsModel itemsModel;
  DrawerBody({Key? key, required this.usersModel, required this.itemsModel})
      : super(key: key);

  @override
  _DrawerBodyState createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  int count = 1;
  Future<void> sentoCart(
      String userID, ItemsModel items, List<CartsModel> cartList) async {
    final cartPath = 'users/$userID/cart/${items.id}';
    final cartRef = FirebaseFirestore.instance.doc(cartPath);
    bool itemalreadyincart = false;
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].id == items.id) {
        itemalreadyincart = true;
      }
    }

    if (itemalreadyincart == true) {
      await cartRef.update({'count': FieldValue.increment(count)});
    } else {
      await cartRef.set({
        'name': items.name,
        'count': count,
        'picture': items.picture,
        'weight': items.weight,
        'price': items.price,
        'id': items.id,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<List<CartsModel>>(context);
    return Container(
      height: 250,
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Flexible(
                child: Center(
                  child: Container(
                    height: 125,
                    width: 125,
                    child: CachedNetworkImage(
                      imageUrl: widget.itemsModel.picture,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (widget.itemsModel.name),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              widget.itemsModel.weight == null
                                  ? Text(
                                      'each',
                                      style: TextStyle(fontSize: 15),
                                    )
                                  : Text(
                                      '${widget.itemsModel.weight} kg',
                                      style: TextStyle(fontSize: 15),
                                    ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Text(
                            '\$' + widget.itemsModel.price.toStringAsFixed(0),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
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
                              icon: Icon(Icons.remove, color: Colors.red[300]),
                              onPressed: () {
                                if (count > 1) {
                                  setState(() {
                                    count--;
                                  });
                                } else {}
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            count.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            width: 15,
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
                              icon: Icon(Icons.add, color: Colors.red[300]),
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              width: double.infinity,
              height: 55,
              child: cartList != null
                  ? TextButton(
                      onPressed: () async {
                        await sentoCart(widget.usersModel.userID!,
                            widget.itemsModel, cartList);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
