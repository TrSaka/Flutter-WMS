import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobx/mobx.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';

import '../../../../../../models/product_model.dart';
part 'main_search_view_model.g.dart';

class MainSearchViewModel = _MainSearchViewModelBase with _$MainSearchViewModel;

abstract class _MainSearchViewModelBase with Store {
  late TextEditingController searchBarController;

  @observable
  List<ProductModel?>? filteredList = [];

  @observable
  int quantity = 0;

  @action
  initalizeQuantity(int newQuatity) {
    quantity = newQuatity;
  }

  @action
  increaseQuantity() {
    quantity = quantity + 1;
  }

  @action
  decreaseQuantity() {
    if (quantity == 0 || quantity < 0) {
      quantity = 0;
    } else {
      quantity = quantity - 1;
    }
  }

  Future updateNewModel(
      WidgetRef ref, String storeName, ProductModel model) async {
    return await ref.read(firebaseProvider.notifier).updateProduct(storeName, model);
  }

  @action
  showList(List<ProductModel?>? newList) {
    filteredList = newList;
  }

  initalizeController() {
    searchBarController = TextEditingController();
  }

  disposeController() {
    searchBarController.dispose();
  }

  Future<List<ProductModel?>?>? firebaseSearch(
      WidgetRef ref, String storeName) async {
    return await ref
        .read(firebaseProvider.notifier)
        .searchFirebase(storeName, searchBarController.text);
  }
}
