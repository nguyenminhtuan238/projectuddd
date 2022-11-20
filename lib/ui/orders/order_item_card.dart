import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order_item.dart';
import 'package:provider/provider.dart';
import 'order_manager.dart';
class OrderItemCard extends StatefulWidget {
  final OrderItem order;
  const OrderItemCard(this.order,{ super.key });

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}
class _OrderItemCardState extends State<OrderItemCard>{
  var _expanded =false;
  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          if(_expanded)buildOrderDetails()
        ],
      ),
    );
  }
  Widget buildOrderDetails(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      height: min(widget.order.productCount * 20.0+10, 100),
      child: ListView(
        children: widget.order.products
        .map(
          (prod) => Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text(
                 prod.title,
                 style: const TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               Text(
                 '${prod.quantity}x \$${prod.price}',
                 style: const TextStyle(
                   fontSize: 18,
                   color: Colors.grey,
                 ),
               ),
             ],
          ),
        )
        .toList(),
      ),
    );
  }
  Widget buildOrderSummary(){
    return ListTile(
      title: Text('\$${widget.order.amount}'),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
      ),
      trailing:SizedBox(
        width: 100,
        child:  Row(
        children: [
           IconButton(
        onPressed: (){
          setState(() {
            _expanded=!_expanded;
          });
        }, 
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        ),
          IconButton(
        onPressed: (){
          final order=context.read<OrdersManager>();
          order.deleteOrder(widget.order.id);
        }, 
        icon: const Icon(Icons.delete),
        color: Theme.of(context).colorScheme.secondary,
        ),
        ],
      ),
      )
    );
  }
}