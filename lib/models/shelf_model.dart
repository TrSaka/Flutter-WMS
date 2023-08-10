// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:stock_app/models/product_model.dart';

class ShelfModel extends Equatable {
  final bool? isUseable;
  final int? shelfLimit;
  final String? shelfBarcode;
  final List<ProductModel>? models;
  final String shelfName;
  const ShelfModel({
    this.isUseable,
    this.shelfLimit,
    this.shelfBarcode,
    this.models,
    required this.shelfName,
  });

  ShelfModel copyWith({
    bool? isUseable,
    int? shelfLimit,
    String? shelfBarcode,
    List<ProductModel>? models,
    String? shelfName,
  }) {
    return ShelfModel(
      isUseable: isUseable ?? this.isUseable,
      shelfLimit: shelfLimit ?? this.shelfLimit,
      shelfBarcode: shelfBarcode ?? this.shelfBarcode,
      models: models ?? this.models,
      shelfName: shelfName ?? this.shelfName,
    );
  }

  factory ShelfModel.fromCreateList(List list) {
    return ShelfModel(
      shelfName: list[0] as String,
      shelfBarcode: list[1] as String,
      shelfLimit: int.parse(list[2]),
      isUseable: true,
    );
  }

  factory ShelfModel.fromFirebase(map, List<ProductModel>? model) {
    return ShelfModel(
      shelfName: map['shelfName'] as String,
      isUseable: map['isUseable'] as bool,
      models: model as List<ProductModel>,
      shelfBarcode: map['shelfBarcode'] as String,
      shelfLimit: map['shelfLimit'] as int,
    );
  }

  Map<String, dynamic> toFirebase(ShelfModel shelfModel) {
    return ({
      'shelfName': shelfModel.shelfName,
      'isUseable': shelfModel.isUseable as bool,
      'shelfBarcode': shelfModel.shelfBarcode as String,
      'shelfLimit': shelfModel.shelfLimit,
    });
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => throw UnimplementedError();
}
