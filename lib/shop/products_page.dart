import 'package:cached_network_image/cached_network_image.dart';
import 'package:NomNom/models/itemsmodel.dart';
import 'package:NomNom/models/usersmodel.dart';
import 'package:NomNom/shop/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final itemsList = Provider.of<List<ItemsModel>>(context);
    final user = Provider.of<UsersModel>(context);
    return user != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: (itemsList != null)
                ? GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: itemsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      var items = itemsList[index];
                      return ItemGridTile(itemsModel: items, usersModel: user);
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        : CircularProgressIndicator();
  }
}

class ItemGridTile extends StatelessWidget {
  final UsersModel usersModel;
  final ItemsModel itemsModel;
  const ItemGridTile({
    @required this.itemsModel,
    @required this.usersModel,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
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
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.red[300]),
                    onPressed: () {
                      drawer(context, itemsModel, usersModel);
                    },
                  ),
                ),
              ],
            ),
            Flexible(
              child: CachedNetworkImage(
                imageUrl: itemsModel.picture,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (itemsModel.name),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      itemsModel.weight == null
                          ? Text('each')
                          : Text('${itemsModel.weight} kg'),
                    ],
                  ),
                  Text(
                    '\$' + itemsModel.price.toStringAsFixed(0),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
