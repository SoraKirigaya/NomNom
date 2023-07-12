import 'package:NomNom/models/purchistorymodel.dart';
import 'package:NomNom/models/usersmodel.dart';
import 'package:NomNom/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseHistory extends StatefulWidget {
  final UsersModel user;

  const PurchaseHistory({Key key, this.user}) : super(key: key);

  @override
  Body createState() => Body();
}

class Body extends State<PurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Purchase History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamProvider<List<PurcHistoryModel>>.value(
        initialData: null,
        value: FirebaseDatabase().getPurchHistoryDetails(widget.user.userID),
        builder: (context, child) => PurchaseHistoryBody(),
      ),
    );
  }
}

class PurchaseHistoryBody extends StatefulWidget {
  @override
  _PurchaseHistoryBodyState createState() => _PurchaseHistoryBodyState();
}

class _PurchaseHistoryBodyState extends State<PurchaseHistoryBody> {
  @override
  Widget build(BuildContext context) {
    final purcHistList = Provider.of<List<PurcHistoryModel>>(context);
    return purcHistList != null
        ? ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 30);
            },
            itemCount: purcHistList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 85,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID Number: ' +
                            purcHistList[index].id,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Total Price: ' +
                            '\$' +
                            purcHistList[index].price.toStringAsFixed(0),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : CircularProgressIndicator();
  }
}
