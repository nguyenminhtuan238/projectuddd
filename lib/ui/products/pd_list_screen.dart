import 'package:flutter/material.dart';
import '../../models/products.dart';
import '../cart/cart_screen.dart';
import 'products_manager.dart';
import 'pd_list_title.dart';
import 'package:provider/provider.dart';
class  ListViewpd extends StatelessWidget {
  const ListViewpd({ super.key });
  Future<void> _refreshProducts(BuildContext  context) async{
    await context.read< ProductsManager>().fetchProduct(true);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("shop"),
        actions: <Widget>[
          buildshoppingCartIcon(context),
        ],
      ),
      body: FutureBuilder(
            future: _refreshProducts(context),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: Consumer<ProductsManager>(
                    builder: (ctx, products, child) {
                      return ListView.builder(
                        itemCount: products.itemCount,
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            ListTitlePd(products.items[i]),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ));
            }));
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