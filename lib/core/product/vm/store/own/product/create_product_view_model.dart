import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';
import 'package:mobx/mobx.dart';
import 'package:stock_app/core/riverpod/validation_riverpod.dart';

import '../../../../../../models/product_model.dart';
part 'create_product_view_model.g.dart';

class CreateProductViewModel = _CreateProductViewModelBase
    with _$CreateProductViewModel;

abstract class _CreateProductViewModelBase with Store {
  late TextEditingController productController;
  late TextEditingController barcodeController;
  late TextEditingController categoryController;
  late TextEditingController brandController;
  late TextEditingController typeController;
  late TextEditingController quantityController;

  void initalizeControllers() {
    productController = TextEditingController();
    barcodeController = TextEditingController();
    categoryController = TextEditingController();
    brandController = TextEditingController();
    typeController = TextEditingController();
    quantityController = TextEditingController();
  }

  void disposeControllers() {
    productController.dispose();
    barcodeController.dispose();
    categoryController.dispose();
    brandController.dispose();
    typeController.dispose();
    quantityController.dispose();
  }

  void clearControllers() {
    productController.clear();
    barcodeController.clear();
    categoryController.clear();
    brandController.clear();
    typeController.clear();
    quantityController.clear();
  }

  Future<List<String>> getShelfNames(WidgetRef ref, String storeName) async {
    return await ref.read(firebaseProvider.notifier).getShelfList(storeName);
  }

  Future<String> createProduct(
      WidgetRef ref, String storeName, String shelfName) async {

    List<String> formTextList = [
      productController.text,
      barcodeController.text,
      categoryController.text,
      brandController.text,
      typeController.text,
      quantityController.text,
      shelfName,
    ];
    
    try {
      if (ref
              .read(formValidationProvider)
              .isDefaultFormValidated(formTextList) &&
          dropDownSelected != null) {
        ProductModel newModel = ProductModel.fromCreateList(formTextList);

        return await ref
            .read(firebaseProvider.notifier)
            .createNewProduct(storeName, shelfName, newModel);
      } else {
        return StringConstants.formsNotValidatedText;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @observable
  String? dropDownSelected;

  @action
  void changeSelectedDropDown(String selected) {
    dropDownSelected = selected;
  }
}
