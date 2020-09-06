import 'package:flutter_stock_checker/config.dart';
import 'package:flutter_stock_checker/model/stock.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHandler {
  Future<Stock> getData(String ticker) async {
    var client = http.Client();
    var url =
        'https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-financials?symbol=$ticker';
    Map<String, String> headers = Map<String, String>();
    headers['x-rapidapi-host'] = 'apidojo-yahoo-finance-v1.p.rapidapi.com';
    headers['x-rapidapi-key'] = 'JKASHDKSAJDSAK';
    Stock stock = Stock();
    try {
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        String resp = response.body;

        if (resp != '') {
          String value =
              await jsonDecode(resp)['price']['regularMarketPrice']['fmt'];
          String trend = await jsonDecode(resp)['pageViews']['shortTermTrend'];
          String shortDesc = await jsonDecode(resp)['quoteType']['shortName'];
          String currency = await jsonDecode(resp)['price']['currency'];

          stock = Stock(
              ticker: ticker.toUpperCase(),
              price: value,
              trend: trend,
              shortDescription: shortDesc,
              currency: currency);
        }
      }
    } catch (e) {
      print(e);
    }
    return stock;
  }
}
