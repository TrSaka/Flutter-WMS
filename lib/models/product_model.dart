// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String barcode;
  final String productName;
  final String brand;
  final String type;
  final String category;
  final int quantity;
  final String? shelf;
  const ProductModel({
    required this.barcode,
    required this.productName,
    required this.brand,
    required this.type,
    required this.category,
    required this.quantity,
    this.shelf,
  });

  ProductModel copyWith({
    String? barcode,
    String? productName,
    String? brand,
    String? type,
    String? category,
    int? quantity,
    String? shelf,
  }) {
    return ProductModel(
      barcode: barcode ?? this.barcode,
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      type: type ?? this.type,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      shelf: shelf??this.shelf,
    );
  }

  factory ProductModel.fromFirebase(map) {
    return ProductModel(
      barcode: map['barcode'] as dynamic,
      productName: map['productName'] as String,
      brand: map['brand'] as String,
      type: map['type'] as String,
      category: map['category'] as String,
      quantity: map['quantity'] as int,
      shelf: map['shelf'] as String,
    );
  }

  toFirebase(ProductModel model) {
    return ({
      'productName': model.productName,
      'barcode': model.barcode,
      'brand': model.brand,
      'quantity': model.quantity,
      'type': model.type,
      'category': model.category,
      'shelf':model.shelf,
    });
  }

  factory ProductModel.fromCreateList(List<String> list) {
    return ProductModel(
      productName: list[0],
      barcode: list[1],
      brand: list[3],
      type: list[4],
      category: list[2],
      quantity: int.parse(list[5]),
      shelf: list[6],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      barcode,
      productName,
      brand,
      type,
      category,
      quantity,

    ];
  }
}
