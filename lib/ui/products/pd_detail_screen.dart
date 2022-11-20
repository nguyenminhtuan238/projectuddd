
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../cart/cart_manager.dart';
import '../../models/products.dart';
class  PdDetailScreen extends StatefulWidget {
    static const routeName='/product-detail';
    final Product product; 
   const PdDetailScreen (this.product,{  super.key });
   
  @override
  State<PdDetailScreen> createState() => _PdDetailScreen();
}
class _PdDetailScreen extends State<PdDetailScreen> { 
  int quatri=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          widget.product.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
              widget.product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
             const SizedBox(height: 10,),
              SizedBox(
                width: 150,
                child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if(quatri<=1){
                           quatri=1;
                        }else{
                          quatri-=1;
                        };
                      });
                    }, 
                    icon: const Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 50,
                    child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                      top: BorderSide(color: Color(0xFFDFDFDF)),
                      left: BorderSide(color: Color(0xFFDFDFDF)),
                     right: BorderSide(color: Color(0xFFDFDFDF)),
                      bottom: BorderSide(color:  Color(0xFFDFDFDF)),
                      )
                    ),
                    child: Text(
                    quatri.toString(),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  ),
                  ),
                  IconButton(
                    onPressed: () {
                       setState(() {
                        quatri+=1;
                      });
                    }, 
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: (){
            final cart=context.read<CartManager>();
            cart.addItem(widget.product,quatri);
           setState(() {
             quatri=1;
           });
        },  
        tooltip: "Thêm vào giỏ hàng", 
        backgroundColor: Colors.green,  
        foregroundColor: Colors.white,  
        child: const Icon(Icons.add_shopping_cart), 
      ),  
    );
  }
  
}