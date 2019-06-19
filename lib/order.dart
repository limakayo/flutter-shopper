class Customer {
  final int id;
  final String name;

  Customer({this.id, this.name});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Order {
  final int id;
  final String street;
  final Customer customer;

  Order({ 
    this.id,
    this.street,
    this.customer
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      street: json['street'],
      customer: Customer.fromJson(json['customer']),
    );
  }
}