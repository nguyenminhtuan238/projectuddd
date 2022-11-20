import 'package:flutter/material.dart';
import 'package:shop/ui/products/products_manager.dart';
import 'pd_detail_screen.dart';
import '../../models/products.dart';
import 'package:provider/provider.dart';
class ListTitlePd extends StatelessWidget {
  const ListTitlePd(this.product,{super.key});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(
              PdDetailScreen.routeName,
              arguments: product.id
            );
      },
      child: ListTile(
        leading: Image.network(product.imageUrl),
        title: Text("\$${product.price}"),
        subtitle: Text(product.title),
        trailing: ValueListenableBuilder<bool>(
            valueListenable: product.isFavoriteListenable,
            builder: (ctx, isFavorite, child) {
              return IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  ctx.read<ProductsManager>().toggleFavoriteStatus(product);
                },
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
              );
            }),
      ),
    );
  }
}


