import 'package:NomNom/login&signup/user_login_page.dart';
import 'package:NomNom/models/itemsmodel.dart';
import 'package:NomNom/models/shopmodel.dart';
import 'package:NomNom/services/firebase_database.dart';
import 'package:NomNom/shop/products_page.dart';
import 'package:NomNom/shop/promotion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:shimmer/shimmer.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamProvider<List<PromotionModel>>.value(
                      initialData: [],
                      value: FirebaseDatabase().getPromotionDetails(),
                      child: Promotion(),
                      catchError: (context, error) {
                        return List<PromotionModel>.empty();
                      },
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image(
                        height: 150,
                        width: double.infinity,
                        image: AssetImage('assets/promotion.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.deepOrange[300]!,
                    highlightColor: Colors.teal[300]!,
                    child: Text(
                      'Promotion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: new BubbleTabIndicator(
                    indicatorHeight: 35,
                    indicatorColor: Colors.grey[300]!,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[300],
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Fruits',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Vegetables',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Dairy',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Fish',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Meat',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Bread',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: tabController,
                children: [
                  StreamProvider<List<ItemsModel>>.value(
                    initialData: [],
                    value: FirebaseDatabase().getItemsDetails('fruits'),
                    child: ProductsPage(),
                    catchError: (context, error) {
                      return List<ItemsModel>.empty();
                    },
                  ),
                  StreamProvider<List<ItemsModel>>.value(
                    initialData: [],
                    value: FirebaseDatabase().getItemsDetails('vegetables'),
                    child: ProductsPage(),
                    catchError: (context, error) {
                      return List<ItemsModel>.empty();
                    },
                  ),
                  StreamProvider<List<ItemsModel>>.value(
                    initialData: [],
                    value: FirebaseDatabase().getItemsDetails('dairies'),
                    child: ProductsPage(),
                    catchError: (context, error) {
                      return List<ItemsModel>.empty();
                    },
                  ),
                  StreamProvider<List<ItemsModel>>.value(
                    initialData: [],
                    value: FirebaseDatabase().getItemsDetails('fish'),
                    child: ProductsPage(),
                    catchError: (context, error) {
                      return List<ItemsModel>.empty();
                    },
                  ),
                  StreamProvider<List<ItemsModel>>.value(
                    initialData: [],
                    value: FirebaseDatabase().getItemsDetails('meat'),
                    child: ProductsPage(),
                    catchError: (context, error) {
                      return List<ItemsModel>.empty();
                    },
                  ),
                  StreamProvider<List<ItemsModel>>.value(
                    initialData: [],
                    value: FirebaseDatabase().getItemsDetails('bread'),
                    child: ProductsPage(),
                    catchError: (context, error) {
                      return List<ItemsModel>.empty();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
