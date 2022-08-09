import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Product List"),
          actions: [
            Center(
              child: Badge(
                badgeContent: Text("0",style: TextStyle(color: Colors.white),),
                animationDuration: Duration(microseconds: 300),
                child: Icon(Icons.shopping_cart),
              ),
            ),
            SizedBox(width: 20,)
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Text("product list")
            ],
          ),
        ),
      ),
    );
  }
}
