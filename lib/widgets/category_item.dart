import 'package:hunter/providers/auth.dart';
import 'package:hunter/screens/product_detail_screen.dart';
import 'package:hunter/screens/products_filtered_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category.dart';
import '../providers/cart.dart';
//import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  CategoryItem(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
     //final category = Provider.of<Category>(context, listen: false);
     //final categoryId = ModalRoute.of(context).settings.arguments as String;
     final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(

      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
             Navigator.of(context).pushNamed(
               ProductsFilteredScreen.routeName,);
           },
          child: Column(
            children: [
             Container(
               width: 100,
              height: 100,


              child: CircleAvatar(

                backgroundImage: NetworkImage(imageUrl),
              ),

            ),



            Text(name),


            ],
            ),
          ),
      ),



    );
  }
}
