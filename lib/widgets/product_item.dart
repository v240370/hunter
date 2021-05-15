import 'package:HunterDelivery/models/style.dart';
import 'package:HunterDelivery/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ]),
//            height: 160,
        child: Row(
          children: <Widget>[
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetailScreen.routeName,
                      arguments: product.id,
                    );
                  },
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(

                        product.title,

                          textDirection: TextDirection.ltr,
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                          maxLines: 4

                        ),
                      ),
                    ),


                      Text(
                          'Вес ${product.netto.toString()} гр',
                        overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,

                            ),
                          ),



                      Text(
                        'Цена ${product.price.toString()} RUB',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),

                  Container(

                    child: GridTileBar(

                      leading: Consumer<Product>(
                        builder: (ctx, product, _) => IconButton(
                          icon: Icon(
                            product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            product.toggleFavoriteStatus(
                              authData.token,
                              authData.userId,
                            );
                          },
                        ),
                      ),

                      trailing: IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          cart.addItem(product.id, product.price, product.title);
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added item to cart!',
                              ),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cart.removeSingleItem(product.id);
                                },
                              ),
                            ),

                          );
                        },

                      ),
                    ),

                  ),





                    ],
                  ),

            ),

          ],
        ),
      ),
    );
  }
}
