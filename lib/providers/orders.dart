import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'package:mailer/mailer.dart';
import './cart.dart';


class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String userName;
  final String userPhone;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.userName,
    @required this.userPhone,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  OrderItem findById(String id) {
    return _orders.firstWhere((ord) => ord.id == id);
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://hunter-9f58f.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
         // userName: orderData['userName'],
         // userPhone: orderData['userPhone'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title'],
            ),
          )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://hunter-9f58f.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        //'userName': 'userName',
        //'userPhone': 'userPhone',
        'products': cartProducts
            .map((cp) => {
          'id': cp.id,
          'title': cp.title,
          'quantity': cp.quantity,
          'price': cp.price,
        })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        // userName: 'userName',
        // userPhone: 'userPhone',
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  Future<void> updateOrder(String id, OrderItem newOrder) async {
    final ordIndex = _orders.indexWhere((ord) => ord.id == id);
    if (ordIndex >= 0) {
      final timestamp = DateTime.now();
      final url =
          'https://hunter-9f58f.firebaseio.com/orders/$userId.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'id': newOrder.id,
            'amount': newOrder.amount,
            'userName': newOrder.userName,
            'userPhone': newOrder.userPhone,
            'dateTime': timestamp.toIso8601String(),
            'products': newOrder.products,
          }));
      _orders[ordIndex] = newOrder;
      notifyListeners();
    } else {
      print('...');
    }
  }
  // Future<void> sendOrder(String id, OrderItem newOrder) async {
  //   final ordIndex = _orders.indexWhere((ord) => ord.id == id);
  //   if (ordIndex >= 0) {
  //
  //
  //     String username = 'desmailer@yandex.ru';
  //     String password = 'designvolga2020';
  //
  //     final Map<String, String> where = {
  //       'id': 'id',
  //       'amount': 'amount',
  //       'userName': 'userName',
  //       'userPhone': 'userPhone',
  //       'dateTime': 'dateTime',
  //       'products': 'products',
  //     };
  //
  //
  //     //  final smtpServer = yandex(username, password);
  //     // Creating the Gmail server
  //
  //     // Create our email message.
  //     final message = Message()
  //       ..from = Address(username)
  //     //..recipients.add('v240370@yandex.ru') //recipent email
  //       ..recipients.add('v240370@yandex.ru') //recipent email
  //       ..ccRecipients.addAll(['v240370@yandex.ru']) //cc Recipents emails
  //       ..bccRecipients.add(Address('v240370@yandex.ru')) //bcc Recipents emails
  //       ..subject = 'Hunter Delivery. Новый заказ из приложения :: 😀 :: ${DateTime.now()}' //subject of the email
  //       ..text = "json.encode({
  //           'id'; 'amount'; 'userName'; 'userPhone'; 'products';};);";//body of the email
  //
  //     try {
  //       //  final sendReport = await send(message, smtpServer);
  //       //    print('Message sent: ' + sendReport.toString()); //print if the email is sent
  //     } on MailerException catch (e) {
  //       print('Message not sent. \n'+ e.toString()); //print if the email is not sent
  //       // e.toString() will show why the email is not sending
  //     }
  // }
}
