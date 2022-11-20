import 'package:flutter/material.dart';
import '../../models/products.dart';
import 'package:flutter/foundation.dart';
import '../../models/cart.dart';
class CartManager with ChangeNotifier{
   Map<String, CartItem> _item = {
    'p1': CartItem(
       id: 'p1',
      title: 'Olong Milktea',
      quantity: 2,
      price:2.5,
      imageUrl:
		    'http://gongcha.com.vn/wp-content/uploads/2018/02/Tr%C3%A0-s%E1%BB%AFa-Oolong-2.png',
    ),
  };
  int get productCount{
    return _item.length;
  }
  List<CartItem> get products{
    return _item.values.toList();
  }
  Iterable<MapEntry<String,CartItem>> get productEntries{
    return {..._item}.entries;
  }
  double get totalAmount {
    var total =0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
     });
     return total;
  }
  void addItem(Product product,int quatity){
    if(_item.containsKey(product.id)){
      _item.update(
        product.id!, 
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity+quatity,
        )
      );
    }else{
      _item.putIfAbsent(
        product.id!, 
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: product.title,
          price: product.price, 
          quantity: quatity, 
          imageUrl: product.imageUrl,
        )
      );
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _item.remove(productId);
    notifyListeners();
  }
  void removeSingleItem(String productId){
    if(!_item.containsKey(productId)){
      return;
    }
    if(_item[productId]?.quantity as num>1){
      _item.update(
        productId, 
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity-1,
        ),
      );
    }else{
      _item.remove(productId);
    }
    notifyListeners();
  }
  void clear(){
    _item = {};
    notifyListeners();
  }
}