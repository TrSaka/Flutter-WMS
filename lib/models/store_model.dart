// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:stock_app/models/shelf_model.dart';


class StoreModel extends Equatable {
  final String storeName;
  final List<ShelfModel> shelfs;
  const StoreModel({
    required this.storeName,
    required this.shelfs,
  });

  StoreModel copyWith({
    String? storeName,
    List<ShelfModel>? shelfs,
  }) {
    return StoreModel(
      storeName: storeName ?? this.storeName,
      shelfs: shelfs ?? this.shelfs,
    );
  }


  factory StoreModel.fromFirebase(data) {
    return StoreModel(
      shelfs: data['shelfs'],
      storeName: data['storeName'],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [storeName, shelfs];
}
