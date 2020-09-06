import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_checker/controller/apiHandler.dart';
import 'package:flutter_stock_checker/model/stock.dart';

class Data with ChangeNotifier {
  String ticker = '';
  String price = '';
  String shortDesc = '';
  IconData asset = Icons.arrow_upward;
  String currency = '';

  void updateData(Stock stock) async {
    price = stock.price;
    ticker = stock.ticker;
    shortDesc = stock.shortDescription;
    currency = stock.currency;
    switch (stock.trend) {
      case 'UP':
        {
          asset = Icons.trending_up;
          break;
        }
      case 'DOWN':
        {
          asset = Icons.trending_down;
          break;
        }
      default:
        {
          asset = Icons.trending_flat;
          break;
        }
    }
    print('$price - $ticker');
    notifyListeners();
  }
}
