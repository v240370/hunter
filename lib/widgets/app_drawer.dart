import 'package:hunter/screens/cart_screen.dart';
import 'package:hunter/screens/location_screen.dart';
import 'package:hunter/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/user_orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
      Container(
        height: 150,

      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/logo250.png'),
        fit: BoxFit.contain)

          ),
    ),




          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Категории'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_dining),
            title: Text('Товары'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
            Divider(),
          ListTile(
            leading: Icon(Icons.motorcycle),
            title: Text('Заказы'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserOrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_grocery_store),
            title: Text('Корзина'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CartScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Редактор'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Мы здесь'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(LocationScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Выход'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
