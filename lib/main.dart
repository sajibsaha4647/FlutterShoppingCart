import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/Cart_Provider.dart';
import 'package:provider/provider.dart';

import 'ProductList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: ProductList(),
          ),
        ),
      ),
    );
  }
}

