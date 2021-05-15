import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class EditOrderScreen extends StatefulWidget {
  static const routeName = '/edit-order';

  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  final _idFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _userPhoneFocusNode = FocusNode();
  final _dateTimeFocusNode = FocusNode();


  // final _categoryFocusNode = FocusNode();
  // final _nettoFocusNode = FocusNode();
  // final _imageUrlController = TextEditingController();
  // final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedOrder = OrderItem(
    id: '',
    userName: '',
    userPhone: '',



  );
  var _initValues = {
    'id': '',
    'userName': '',
    'userPhone': '',
    'dateTime': '',
    'amount': 'amount',


  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final orderId = ModalRoute.of(context).settings.arguments as String;

      if (orderId != null) {
        _editedOrder =
            Provider.of<Orders>(context, listen: false).findById(orderId);

        _initValues = {
          'id': _editedOrder.id,
          'userName': _editedOrder.userName,
          'userPhone': _editedOrder.userPhone,
          //'dateTime': _editedOrder.timestamp.toIso8601String(),
          //'amount': _editedOrder.amount,



        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _idFocusNode.dispose();
    _userNameFocusNode.dispose();
    _userPhoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm1() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedOrder.id != null) {
      await Provider.of<Orders>(context, listen: false)
          .updateOrder(_editedOrder.id, _editedOrder);
    } else {
      try {
        await Provider.of<Orders>(context, listen: false)
            .updateOrder(_editedOrder.id, _editedOrder);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm1,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['userName'],
                decoration: InputDecoration(labelText: 'userName'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedOrder = OrderItem(
                      id: _editedOrder.id,
                      userName: value,
                      userPhone: _editedOrder.userPhone);
                },
              ),
              TextFormField(
                initialValue: _initValues['userPhone'],
                decoration: InputDecoration(labelText: 'userPhone'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedOrder = OrderItem(
                      id: _editedOrder.id,
                      userName: _editedOrder.userName,
                      userPhone: value);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
