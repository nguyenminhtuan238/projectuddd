import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_product_list_tile.dart';
import 'products_manager.dart';
import 'edit_product_screen.dart';
class UserProductsScreen extends StatelessWidget {
   static const routename='/manager';
  const UserProductsScreen({ super.key });
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Your Products'),
        actions:<Widget> [
          buildAddButton(context),
        ],
      ),
      body: RefreshIndicator(
            onRefresh: () async=>print('hello'),
            child: buildUserProductListView(), 
          ),
      );
    }
  }
   Widget buildUserProductListView() {
  return Consumer<ProductsManager>(
    builder: (ctx, productsManager, child) {
      return GridView.builder(
        itemCount: productsManager.itemCount,
        itemBuilder: (ctx, i) => UserProductListTile(
              productsManager.items[i],
            ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
    },
  );
}
   Widget buildAddButton(BuildContext context){
     return IconButton(

       onPressed: (){
         Navigator.of(context).pushNamed(EditProductScreen.routeName);
       }, 
       icon: const Icon(Icons.add),
       );
   }
