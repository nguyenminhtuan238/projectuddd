import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../models/cart.dart';
import '../../models/order_item.dart';
class OrdersManager with ChangeNotifier{
  final List<OrderItem> _orders=[
    OrderItem(
      id: 'o1',
      amount: 5,
      products: [
        CartItem(
          id: 'p1',
          title: 'Olong Milktea',
          quantity: 2,
          price: 2.5,
          imageUrl:
              'http://gongcha.com.vn/wp-content/uploads/2018/02/Tr%C3%A0-s%E1%BB%AFa-Oolong-2.png',
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