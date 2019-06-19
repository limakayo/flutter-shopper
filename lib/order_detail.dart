import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_shopper/qr_code.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopper/order.dart';

Future<Order> fetchOrder(String id) async {
  final response = await http.get(
    'http://api.deliverycenter.com/app/order/$id',
    headers: {
      HttpHeaders.authorizationHeader: "Bearer a973138e-cc6e-439e-a56e-d6c88e63fa7b"
    }
  );

  if (response.statusCode == 200) {
    return Order.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load order');
  }
}

class OrderDetail extends StatefulWidget {
  static const routeName = '/orderDetail';

  final String data;

  const OrderDetail({
    Key key, 
    @required this.data
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Future<Order> order;
  var qrCode;
  
  @override
  void initState() {
    super.initState();

    final Map qrCodeMap = jsonDecode(widget.data);
    qrCode = new QrCode.fromJson(qrCodeMap);

    order = fetchOrder(qrCode.id);
  }

  Widget nameSection(data) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Pedido #${data.id.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data.customer.name,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addressSection(data) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        data.street,
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido #${qrCode.id}'),
      ),
      body: Center(
        child: FutureBuilder<Order>(
          future: order,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  nameSection(snapshot.data),
                  addressSection(snapshot.data)
                ]
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            return CircularProgressIndicator();
          },
        )
      ),
    );
  }
}
