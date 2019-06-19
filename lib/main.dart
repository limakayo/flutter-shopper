import 'package:flutter/material.dart';
import 'package:flutter_shopper/home.dart';
import 'package:flutter_shopper/route_generator.dart';

void main() {
  runApp(MaterialApp(
    title: 'Shopper Junior',
    theme: new ThemeData(
      primaryColor: Colors.deepOrange[400]
    ),
    initialRoute: Home.routeName,
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}