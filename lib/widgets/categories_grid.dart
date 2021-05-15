// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/categories.dart';
// import 'category_item.dart';
//
// class CategoriesGrid extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     final categoriesData = Provider.of<Categories>(context);
//     final categories = categoriesData.items;
//
//
//     return GridView.builder(
//       padding: const EdgeInsets.all(10.0),
//       itemCount: categories.length,
//       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//
//         // builder: (c) => products[i],
//         value: categories[i],
//         child: CategoryItem(
//           // products[i].id,
//           // products[i].title,
//           // products[i].imageUrl,
//         ),
//       ),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 3 / 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//     );
//
//    }
// }
