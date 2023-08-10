import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/product/vm/store/own/product/create_product_view_model.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';
import 'package:stock_app/models/shelf_model.dart';
import 'package:mobx/mobx.dart';
part 'store_view_model.g.dart';

// ignore: library_private_types_in_public_api
class StoreViewModel = _StoreViewModelBase with _$StoreViewModel;

abstract class _StoreViewModelBase with Store {
  final viewModel1 = CreateProductViewModel();
  final viewModel2 = CreateProductViewModel();

  disposeControllers() {
    viewModel1.disposeControllers();
    viewModel1.disposeControllers();
  }

  List<dynamic> rightBodyList = [];

  @observable
  int bodyState = 0;

  @observable
  int currentPage = 0;

  @observable
  PageController controller = PageController();

  @action
  changePageController(int pageController, int newPage) {
    pageController = newPage;
  }

  @observable
  String? selectedDropDown;

  @observable
  bool isExpansionTileOpen = false;

  @action
  void setExpansionTileOpen(bool value) {
    isExpansionTileOpen = value;
  }

  late var plcStream;

  @action
  changeMiddlePage(int newPage) {
    currentPage = newPage;
  }

  @action
  changeDropDownValue(String newSelect) {
    selectedDropDown = newSelect;
  }

  @action
  showSelectedShelfProduct() {}

  Future<List<ShelfModel?>?> getShelfs(WidgetRef ref, String storeName) async {
    return await ref.read(firebaseProvider.notifier).getShelfs(storeName);
  }

  Future getProducts(WidgetRef ref, String storeName, String shelfName) async {
    return await ref
        .read(firebaseProvider.notifier)
        .getProducts(storeName, shelfName);
  }

  Future<List<String>> getShelfList(WidgetRef ref, String storeName) async {
    return await ref.read(firebaseProvider.notifier).getShelfList(storeName);
  }

  Stream<QuerySnapshot> getShelfsListener(WidgetRef ref, String storeName) {
    return ref.read(firebaseProvider.notifier).getShelfsListener(storeName);
  }

  Future<List<String>> getMachineNames(WidgetRef ref, String storeName) async {
    return ref.read(firebaseProvider.notifier).getMachineNames(storeName);
  }

  setListFromListener(snapshot) {
    return snapshot.data!.docs.map((doc) => doc.data()['shelfName']).toList();
  }
}
