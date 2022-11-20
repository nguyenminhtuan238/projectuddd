

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_product_list_tile.dart';
import 'products_manager.dart';
import 'edit_product_screen.dart';
import '../auth/auth_manager.dart';
class  UserProductsScreen  extends StatefulWidget {
   static const routename='/manager';
  const UserProductsScreen({ super.key });

  @override
  State<UserProductsScreen> createState() => _UserProductsScreen();
}


class _UserProductsScreen extends State<UserProductsScreen> {
  late Future<void> _fetchProducts;
  @override
  void initState(){
    super.initState();
    _fetchProducts=context.read<ProductsManager>().fetchProduct();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Your Products'),
        actions:<Widget> [
          buildAddButton(context),
        ],
      ),
      body: FutureBuilder(
        future: _fetchProducts,
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return RefreshIndicator(
            onRefresh: () async=>print('hello'),
            child: buildUserProductListView(), 
          );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () { 
              context.read<AuthManager>().logout(); 
        },
        child: const Icon(Icons.lock_open),
      )
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
