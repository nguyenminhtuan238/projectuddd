import 'package:flutter/material.dart';
import '../cart/cart_manager.dart';
import 'package:provider/provider.dart';
Future<bool?> ShowConfirmDialog(BuildContext context,String message,String productId){
  return showDialog(
    context: context, 
    builder: (ctx)=> AlertDialog(
      title: const Text('Are you sure'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: (){
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: (){
            context.read<CartManager>().removeItem(productId);
            Navigator.of(ctx).pop(true);
          },
        ),
      ],    
    ),
  );
}
Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context, 
    builder: (ctx)=>AlertDialog(
      title: const Text('An Error Occurred!') ,
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          }, 
          child: const Text('Okey')
        )
      ],
    ),
  );
}