import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cart_Provider.dart';
import 'Cartmodel.dart';
import 'DbHelper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart List"),
        actions: [
          Center(
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
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cartProvider.getCartListData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.isEmpty){
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text('Your cart is empty 😌' ,style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 20,),
                          Text('Explore products and shop your\nfavourite items' , textAlign: TextAlign.center ,style: Theme.of(context).textTheme.subtitle2)

                        ],
                      ),
                    );
                  }else {

                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image(
                                            width: 100,
                                            height: 100,
                                            image: NetworkImage(snapshot
                                                .data![index].image
                                                .toString())),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        dbHelper!.delete(
                                                            snapshot
                                                                .data![index]
                                                                .id!);
                                                        cartProvider
                                                            .removeCounter();
                                                      },
                                                      child:
                                                          Icon(Icons.delete)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  snapshot.data![index].unitTag
                                                          .toString() +
                                                      " " +
                                                      "\$" +
                                                      snapshot.data![index]
                                                          .initialPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                int quentity = snapshot.data![index].quantity!;
                                                                int price =  snapshot.data![index].productPrice!;
                                                                if(quentity != 1){
                                                                  quentity--;
                                                                }else{
                                                                  quentity;
                                                                }
                                                                int? newprice = price*quentity;
                                                                dbHelper?.updatedQuentity(
                                                                    Cart(
                                                                        id: snapshot.data![index].id!,
                                                                        productId: snapshot.data![index].id.toString(),
                                                                        productName: snapshot.data![index].productName!,
                                                                        initialPrice: snapshot.data![index].productPrice!,
                                                                        productPrice: newprice,
                                                                        quantity: quentity,
                                                                        unitTag: snapshot.data![index].unitTag.toString(),
                                                                        image: snapshot.data![index].image.toString()
                                                                    )
                                                                ).then((value){
                                                                  print("updated successfully");
                                                                }).onError((error, stackTrace){
                                                                  print(error);
                                                                  print("updated failed");
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                           Text(snapshot.data![index]
                                                              .quantity
                                                              .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          InkWell(
                                                              onTap: () {
                                                                int quentity = snapshot.data![index].quantity!;
                                                                int price =  snapshot.data![index].productPrice!;
                                                                quentity++;
                                                                int? newprice = price*quentity;
                                                                dbHelper?.updatedQuentity(
                                                                  Cart(
                                                                      id: snapshot.data![index].id!,
                                                                      productId: snapshot.data![index].id.toString(),
                                                                      productName: snapshot.data![index].productName!,
                                                                      initialPrice: snapshot.data![index].productPrice!,
                                                                      productPrice: newprice,
                                                                      quantity: quentity,
                                                                      unitTag: snapshot.data![index].unitTag.toString(),
                                                                      image: snapshot.data![index].image.toString()
                                                                  )
                                                                ).then((value){
                                                                  print("updated successfully");
                                                                }).onError((error, stackTrace){
                                                                  print(error);
                                                                  print("updated failed");
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ],
                                                      )),
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
                          }));

                  }
                }else{
                  return Text('') ;
                }
              }),
        ],
      ),
    ));
  }
}
