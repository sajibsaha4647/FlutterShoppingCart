

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartProvider extends ChangeNotifier{


  int _counter = 0 ;
  int get counter => _counter;

  double _totalPrice = 0.0 ;
  double get totalPrice => _totalPrice;


  void _setPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }



// ================ price of total product =============
  void addTotalprice(double productprice){
    _totalPrice = _totalPrice + productprice ;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalprice(double productprice){
    _totalPrice = _totalPrice + productprice ;
    _setPrefItems();
    notifyListeners();
  }


  double getTotalPrice(){
    _getPrefItems();
    return _totalPrice ;
  }


  // ================ Cart length product =============

  void addCounter(){
    _counter ++ ;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter(){
    _counter -- ;
    _setPrefItems();
    notifyListeners();
  }


  int getcounter(){
    _getPrefItems();
    return _counter ;
  }




}