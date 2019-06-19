import 'package:flutter/material.dart';
import 'package:flutter_shopper/home.dart';
import 'package:flutter_shopper/order_detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Home.routeName:
        return MaterialPageRoute(builder: (context) => Home());
      case OrderDetail.routeName:
        if (args is String) {
          return MaterialPageRoute(builder: (context) => OrderDetail(data: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error')
        ),
      );
    });
  }
}