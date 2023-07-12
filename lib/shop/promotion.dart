import 'package:NomNom/models/shopmodel.dart';
import 'package:NomNom/shop/gridtile.dart';
import 'package:NomNom/shop/rowitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Promotion extends StatefulWidget {
  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  @override
  Widget build(BuildContext context) {
    final shopList = Provider.of<List<PromotionModel>>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Cheap Combo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                RowItem(name: 'Combo 3-7 \nfood day', color: Colors.red),
                const SizedBox(width: 10),
                RowItem(name: 'Set Family \nParty', color: Colors.blue),
              ],
            ),
            const SizedBox(height: 20),
            Flexible(
              child: (shopList != null)
                  ? GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: shopList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        var shop = shopList[index];
                        return Gridtile(
                          name: shop.name,
                          location: shop.location,
                          money: shop.money,
                          weight: shop.weight,
                          picture: shop.picture,
                          onTap: () {},
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
