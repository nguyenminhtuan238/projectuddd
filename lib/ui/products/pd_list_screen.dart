import 'package:flutter/material.dart';
import '../../models/products.dart';
import '../cart/cart_screen.dart';
import 'products_manager.dart';
import 'pd_list_title.dart';
import 'package:provider/provider.dart';
class  ListViewpd extends StatelessWidget {
  const ListViewpd({ super.key });
  @override
  Widget build(BuildContext context) {
     final products=context.select<ProductsManager,List<Product>>(
        (productsManager)=>productsManager.items
     );
    return Scaffold(
      appBar: AppBar(
        title: const Text("shop"),
        actions: <Widget>[
          buildshoppingCartIcon(context),
        ],
      ),
      body: ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx,i)=>Column(
        children: [
            ListTitlePd(products[i]),
            const SizedBox(height: 10,)
        ],
      ),
    ),
    );
  }
  Widget buildshoppingCartIcon(BuildContext context){
    return IconButton(
            icon:const Icon(
              Icons.shopping_cart
            ),
            onPressed: (){
            Navigator.of(context).pushNamed(CartScreen.routeName);
            },
        );
  }
  
}