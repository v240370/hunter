// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets/app_drawer.dart';
// import '../widgets/categories_grid.dart';
// import '../widgets/badge.dart';
// import '../providers/cart.dart';
// import './cart_screen.dart';
// import '../providers/categories.dart';
//
// class CategoriesScreen extends StatefulWidget {
//
//   static const routeName = '/categories';
//
//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }
//
// class _CategoriesScreenState extends State<CategoriesScreen> {
//   var _isInit = true;
//   var _isLoading = false;
//
//   @override
//   void initState() {
//     // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
//     // Future.delayed(Duration.zero).then((_) {
//     //   Provider.of<Products>(context).fetchAndSetProducts();
//     // });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hunter Delivery'),
//         actions: <Widget>[
//           Consumer<Cart>(
//             builder: (_, cart, ch) => Badge(
//               child: ch,
//               value: cart.itemCount.toString(),
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.shopping_cart,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pushNamed(CartScreen.routeName);
//               },
//             ),
//           ),
//         ],
//       ),
//       drawer: AppDrawer(),
//       body: Column(
//         children: [
//           Container(
//             height: 125,
//             decoration: BoxDecoration(
//                 color: Colors.black,
//                 image: DecorationImage(
//                     image: AssetImage('assets/images/logo1.jpg'),
//                     fit: BoxFit.contain)),
//           ),
//           Expanded(
//             child: Container(
//                 child: _isLoading
//                     ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//                     : CategoriesGrid()),
//           ),
//         ],
//       ),
//     );
//   }
// }
