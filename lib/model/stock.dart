import 'package:flutter/material.dart';

class Stock {
  final String ticker;
  final String shortDescription;
  final String price;
  final String trend;
  final String currency;

  Stock(
      {this.ticker,
      this.shortDescription,
      this.price,
      this.currency,
      this.trend});
}
