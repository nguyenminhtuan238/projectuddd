import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../models/cart.dart';
import '../../models/order_item.dart';
class OrdersManager with ChangeNotifier{
  final List<OrderItem> _orders=[
    OrderItem(
      id: 'o1',
      amount: 59.98,
      products: [
          CartItem(
            id: 'c1',
            title: 'Red Shirt',
            price: 29.99,
            quantity: 2,
             imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          ),
        ], 
        dateTime: DateTime.now(),
      )
  ];
  int get orderCount{
    return _orders.length;
  }
 
  List<OrderItem> get orders {
    return [..._orders];
  }
  void addOrder(List<CartItem> cartProducts,double total){
    _orders.insert(
      0, 
      OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total, 
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
  void deleteOrder(String? orderID){
    final index =_orders.indexWhere((element) => element.id == orderID);
    _orders.removeAt(index);
    notifyListeners();
  }
}