import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_item_card.dart';
import 'order_manager.dart';
import 'package:intl/intl.dart';
class  OrdersScreen extends StatefulWidget {
 static const routeName = '/orders';
  const OrdersScreen({ super.key });

  @override
  State<OrdersScreen> createState() => _OrdersScreen();
}

class _OrdersScreen extends State<OrdersScreen> {
  DateTime _datatime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
          backgroundColor: Colors.green ,
        ),
        body: Column(
          children: <Widget>[
            searchOrder(context),  
              const SizedBox(height: 10,),
             Expanded(
               child:  Orderdetail(context),
            ),
          ],
        )
        );
  }
  Widget Orderdetail( BuildContext context){
      return Consumer<OrdersManager>(builder: (ctx, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) =>
            DateFormat('dd/MM/yyyy').format( ordersManager.orders[i].dateTime)
            ==DateFormat('dd/MM/yyyy').format(_datatime)
              ?OrderItemCard(ordersManager.orders[i])
              :const Card(),
              
          );
      });
  }
  Widget searchOrder(BuildContext context){
      return Card(
        margin: const EdgeInsets.only(
          top: 10,
          right: 40,
          left: 40,
          bottom: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Text("Chọn thời gian"),
              SizedBox(
                width: 100,
                child:  Column(
                children:[
                   Text(DateFormat('dd/MM/yyyy').format(_datatime))
                ],
              ),
              ),
              IconButton(
              onPressed: () async{
                final tg=await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime.utc(2001), 
                  lastDate: DateTime.now(),
                );
                setState(() {
                  if (tg != null) {
                     _datatime= tg;
                  }
                });
              }, 
              icon: const Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
      );
  }
}
