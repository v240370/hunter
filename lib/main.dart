import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/splash_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/categories.dart';
import './providers/category.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './screens/user_orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/edit_order_screen.dart';
import './screens/auth_screen.dart';
import 'screens/categories_overview_screen.dart';
import 'screens/location_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),


        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(null, null, []),
          update: (ctx, auth, previousProducts) => Products(auth.token, auth.userId,
              previousProducts == null ? [] : previousProducts.items
          ),
        ),

        ChangeNotifierProxyProvider<Auth, Categories>(
          create: (_) => Categories(null, null, []),
          update: (ctx, auth, previousCategories) => Categories(auth.token, auth.userId,
              previousCategories == null ? [] : previousCategories.items
          ),
        ),


        ChangeNotifierProvider.value(
          value: Cart(),
        ),


        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(null, null, []),
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders
          ),
        ),

      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Hunter Delivery',
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.white,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? CategoriesOverviewScreen()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState ==
                ConnectionState.waiting
                ? SplashScreen()
                : AuthScreen(),
          ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            UserOrdersScreen.routeName: (ctx) => UserOrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            EditOrderScreen.routeName: (ctx) => EditOrderScreen(),
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            LocationScreen.routeName: (ctx) => LocationScreen(),

            //ProductsFilteredScreen.routeName: (ctx) => ProductsFilteredScreen(),
          },
        ),
      ),
    );
  }
}
