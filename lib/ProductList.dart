import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/Cart_Provider.dart';
import 'package:flutter_shopping_cart/Cartmodel.dart';
import 'package:flutter_shopping_cart/Utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_cart/DbHelper.dart';

import 'CartScreen.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg',
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg',
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg',
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612',
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612',
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612',
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612',
  ];

  DBHelper? dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Product List"),
          actions: [
           InkWell(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen()));
             },
            child: Center(
               child: Badge(
                 badgeContent: Consumer<CartProvider>(
                   builder: (context, val, child) {
                     return Text(
                       val.getcounter().toString(),
                       style: TextStyle(color: Colors.white),
                     );
                   },
                 ),
                 animationDuration: Duration(microseconds: 300),
                 child: Icon(Icons.shopping_cart),
               ),
             ),
           ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: productImage.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image(
                                        width: 100,
                                        height: 100,
                                        image: NetworkImage(
                                            productImage[index].toString())),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productName[index].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              productUnit[index].toString() +
                                                  " " +
                                                  "\$" +
                                                  productPrice[index]
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                dbHelper!
                                                    .insert(Cart(
                                                        id: index,
                                                        productId: (index + 1)
                                                            .toString(),
                                                        productName:
                                                            productName[index]
                                                                .toString(),
                                                        initialPrice:
                                                            productPrice[index],
                                                        productPrice:
                                                            productPrice[index],
                                                        quantity: 1,
                                                        unitTag:
                                                            productUnit[index]
                                                                .toString(),
                                                        image:
                                                            productImage[index]
                                                                .toString()))
                                                    .then((value) {
                                                  print(value);
                                                  print("success");
                                                  cartProvider.addTotalprice(
                                                      double.parse(
                                                          productPrice[index]
                                                              .toString()));
                                                  cartProvider.addCounter();

                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        'Product is added to cart'),
                                                    duration:
                                                        Duration(seconds: 1),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }).onError((error, stackTrace) {
                                                  print(error);
                                                  print("error");
                                                  // Utils.Toasts("Cart Did not added !");
                                                });
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Text(
                                                    "Added to cart",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
