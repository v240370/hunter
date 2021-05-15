// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../widgets/app_drawer.dart';
// import '../widgets/products_grid.dart';
// import '../widgets/badge.dart';
// import '../providers/cart.dart';
// import './cart_screen.dart';
// import '../providers/products.dart';
//
//
//
// class ProductsFilteredScreen extends StatefulWidget {
//   static const routeName = '/products_filtered';
//
//   @override
//   _ProductsFilteredScreenState createState() => _ProductsFilteredScreenState();
// }
//
// class _ProductsFilteredScreenState extends State<ProductsFilteredScreen> {
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
//
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
//                     : ProductsGrid('categories')),
//           ),
//         ],
//       ),
//     );
//   }
// }
