import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async{
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
       
        ChangeNotifierProvider(
          create:(ctx)=>CartManager(), 
        ),
        ChangeNotifierProvider(
          create:(ctx)=>OrdersManager(), 
        ),
        ChangeNotifierProvider(
          create:(ctx)=>AuthManager(), 
        ),
        ChangeNotifierProxyProvider<AuthManager,ProductsManager>(
          create: (ctx)=>ProductsManager(),
          update: (ctx,authmanager,productManager){
            productManager!.authToken =authmanager.authToken;
            return productManager;
          },
        ),
      ],
      child:Consumer<AuthManager>(
        builder: (ctx,authManager,child){
          return  MaterialApp(
    
      debugShowCheckedModeBanner: false,
      home:authManager.isAuth? const  MyHomePage()
      :FutureBuilder(
        future: authManager.tryAutoLogin(),
        builder: (ctx,snapshot){
          return snapshot.connectionState == ConnectionState.waiting?const SplashScreen():const AuthScreen();
        },
      ),
      routes: {
        CartScreen.routeName: (ctx) => const CartScreen(),
        OrdersScreen.routeName:(ctx)=>const OrdersScreen(),

      },
      onGenerateRoute: (settings) {
        if (settings.name == PdDetailScreen.routeName) {
          final productId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (ctx) {
              return PdDetailScreen(
                ctx.read<ProductsManager>().findID(productId),
              );
            },
          );
        }
        if (settings.name == EditProductScreen.routeName) {
          final productId = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (ctx) {
              return EditProductScreen(
                productId != null?
                ctx.read<ProductsManager>().findID(productId)
                : null,
              );
            },
          );
        }
        return null;
      },
    );
        },
      )
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _current=0;
  final _tab=[
    const ListViewpd(),
   const OrdersScreen(),
    const UserProductsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     
      body:_tab[_current],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _current,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue  
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Order',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: 'manager',
              backgroundColor: Colors.blue  
            )
          ],
          onTap: (index){
            setState(() {
              _current=index;
            });
          },
        ),    
    );
  }
}
