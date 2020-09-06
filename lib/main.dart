import 'package:flutter/material.dart';
import 'package:flutter_stock_checker/controller/apiHandler.dart';
import 'package:provider/provider.dart';

import 'model/data.dart';
import 'model/stock.dart';

Stock stock;
Data data;

ApiHandler handler = ApiHandler();
void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => Data(),
      )
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('eGordo check'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140.0),
                child: TextField(
                  onSubmitted: (ticker) async {
                    if (ticker.length > 0) {
                      Stock stock = await handler.getData(ticker);
                      Provider.of<Data>(context, listen: false)
                          .updateData(stock);
                    }
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                context.watch<Data>().ticker,
                style: TextStyle(fontSize: 30.0),
              ),
              Container(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '${Provider.of<Data>(context).shortDesc}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${Provider.of<Data>(context).currency} ${Provider.of<Data>(context).price}'),
                    Icon(
                      Provider.of<Data>(context).asset,
                      size: 35.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
