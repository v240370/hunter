import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './category.dart';

class Categories with ChangeNotifier {
   List<Category> _items = [
  //   Category(
  //     id: '1',
  //     name: 'Мангал',
  //     imageUrl:
  //     'https://designvolga.ru/photos/mangal.jpg',
  //   ),
  //   Category(
  //     id: '2',
  //     name: 'Горячие блюда',
  //     imageUrl:
  //     'https://designvolga.ru/photos/hotmeal.jpg',
  //   ),
  //   Category(
  //     id: '3',
  //     name: 'Горячие закуски',
  //     imageUrl:
  //     'https://designvolga.ru/photos/hotsnack.jpg',
  //   ),
  //   Category(
  //     id: '4',
  //     name: 'Гарниры',
  //     imageUrl:
  //     'https://designvolga.ru/photos/garnir.jpg',
  //   ),
  //   Category(
  //     id: '5',
  //     name: 'Салаты',
  //     imageUrl:
  //     'https://designvolga.ru/photos/salad.jpg',
  //   ),
  //   Category(
  //     id: '6',
  //     name: 'Бургеры',
  //     imageUrl:
  //     'https://designvolga.ru/photos/burger.jpg',
  //   ),


   ];

   final String authToken;
   final String userId;

   Categories(this.authToken, this.userId, this._items);


  List<Category> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }


  Category findById(String id) {
    return _items.firstWhere((cat) => cat.id == id);
  }

    Future<void> fetchAndSetCategories([bool filterByUser = false]) async {
      final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      var url = 'https://hunter-9f58f.firebaseio.com/categories.json?auth=$authToken&$filterString';
      try {
        final response = await http.get(url);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        if (extractedData == null) {
          return;
        }
        url =
        'https://hunter-9f58f.firebaseio.com/userFavorites/$userId.json?auth=$authToken';




        final List<Category> loadedCategories = [];
        extractedData.forEach((catId, catData) {
          loadedCategories.add(Category(
            id: catId,
            name: catData['name'],
            imageUrl: catData['imageUrl'],
          ));
        });
        _items = loadedCategories;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    }
  }
