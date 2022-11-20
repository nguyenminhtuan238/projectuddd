import 'package:flutter/material.dart';
import 'products_manager.dart';
import '../../models/products.dart';
import 'package:provider/provider.dart';
import 'edit_product_screen.dart';
class UserProductListTile extends StatelessWidget {
 
  final Product product;
  const UserProductListTile(this.product,{ super.key });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
     child: GridTile(
      footer:buildGridFooterBar(context),
      child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ), 
    ),
    );
  }
  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
  Widget buildDeleteButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: (){
      context.read<ProductsManager>().deleteProduct(product.id!);
      }, 
    color: Theme.of(context).errorColor,
    );

  }
  Widget buildGridFooterBar(BuildContext context){
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading:  buildEditButton(context),
      title: Text(
        product.title,
        textAlign: TextAlign.center,
      ),
      trailing:  buildDeleteButton(context),
       
      
    );
   
  }
}