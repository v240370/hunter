import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;


  Category({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });

}