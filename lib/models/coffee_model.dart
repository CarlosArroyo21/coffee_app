import 'package:coffee_app/utils/coffee_sizes.dart';

class CoffeeModel {
  final int? id;
  final String name;
  final double price;
  final int quantity;
  final CoffeeSize size;

  CoffeeModel({this.id, required this.name, required this.price, required this.quantity, required this.size});

  factory CoffeeModel.fromMap(Map<String, dynamic> json) {
    return CoffeeModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      size: CoffeeSize.values.byName(json['size']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'quantity': quantity,
      'size': size.name,
    };
  }

  CoffeeModel copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
    CoffeeSize? size,
  }) {
    return CoffeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }
}
