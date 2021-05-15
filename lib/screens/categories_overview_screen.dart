import 'package:HunterDelivery/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../providers/category.dart';
import '../widgets/category_item.dart';



class CategoriesOverviewScreen extends StatelessWidget {
  static const routeName = '/categories_overview';

  var _isInit = true;
  var _isLoading = false;

  final List<Category> loadedCategories = [
  Category(
     id: '1',
     name: 'Мангал',
     imageUrl:
     'https://designvolga.ru/photos/mangal.jpg',
   ),
   Category(
     id: '2',
     name: 'Горячие блюда',
     imageUrl:
     'https://designvolga.ru/photos/hotmeal.jpg',
   ),
   Category(
     id: '3',
     name: 'Горячие закуски',
     imageUrl:
     'https://designvolga.ru/photos/hotsnack.jpg',
   ),
   Category(
     id: '4',
     name: 'Гарниры',
     imageUrl:
     'https://designvolga.ru/photos/garnir.jpg',
   ),
   Category(
     id: '5',
     name: 'Салаты',
     imageUrl:
     'https://designvolga.ru/photos/salad.jpg',
   ),
   Category(
     id: '6',
     name: 'Бургеры',
     imageUrl:
     'https://designvolga.ru/photos/burger.jpg',
   ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hunter Delivery'),
      ),
        drawer: AppDrawer(),
        body: Column(
          children: [
          Container(
          height: 125,
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage('assets/images/logo1.jpg'),
                  fit: BoxFit.contain)),

           ),
        Expanded(
        child: Container(
              child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                   )
        : GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedCategories.length,
        itemBuilder: (ctx, i) => CategoryItem(
          loadedCategories[i].id,
          loadedCategories[i].name,
          loadedCategories[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    ),
        ),
      ],
    ),
    );
  }
}