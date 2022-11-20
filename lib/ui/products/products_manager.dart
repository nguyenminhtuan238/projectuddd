import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../models/products.dart';
class  ProductsManager  with ChangeNotifier{
  final List<Product> _items=[
    Product(
      id: 'p1',
      title: 'Olong Milktea',
      description: 'Đậm vị trà , ít béo',
      price:2.5,
      imageUrl:
		    'http://gongcha.com.vn/wp-content/uploads/2018/02/Tr%C3%A0-s%E1%BB%AFa-Oolong-2.png',
      isFavorite: true,
    ),
  ];
  
  int get itemCount{
    return _items.length;
  }
  List<Product> get items{
    return [..._items];
  }
  List<Product> get favoriteItem{
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
  Product findID(String id){
    return _items.firstWhere((element) => element.id==id);
  }
  void addProduct(Product product) {
   
       _items.add(
         product.copyWith(
           id: 'p${DateTime.now().toIso8601String()}',
         )
       );
    notifyListeners();
    
  }
  void updateProduct(Product product) {
    final index=_items.indexWhere((item) => item.id == product.id);
    if(index >= 0){
      
         _items[index]=product;
        notifyListeners();
      } 
    }
  
  
  void toggleFavoriteStatus(Product product) {
    final saveStatus=product.isFavorite;
    product.isFavorite=!saveStatus;
    
  }
  void deleteProduct(String id) {
    final index=_items.indexWhere((item) => item.id==id);
    _items.removeAt(index);
    notifyListeners();
   
  }
}