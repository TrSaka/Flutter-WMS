import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';
import 'package:mobx/mobx.dart';
import 'package:stock_app/core/riverpod/validation_riverpod.dart';
import '../../../../../../models/shelf_model.dart';
part 'create_shelf_view_model.g.dart';

class CreateShelfViewModel = _CreateShelfViewModelBase
    with _$CreateShelfViewModel;

abstract class _CreateShelfViewModelBase with Store {
  late TextEditingController shelfNameController;
  late TextEditingController shelfLimitController;
  late TextEditingController shelfBarcodeController;


  initalizeControllers() {
    shelfNameController = TextEditingController();
    shelfLimitController = TextEditingController();
    shelfBarcodeController = TextEditingController();

  }

  disposeControllers() {
    shelfBarcodeController.dispose();
    shelfLimitController.dispose();
    shelfBarcodeController.dispose();
  }


  clearControllers(){
    shelfLimitController.clear();
    shelfBarcodeController.clear();
    shelfNameController.clear();

  }

  Future<List<String>> getShelfNames(WidgetRef ref, String storeName) async {
    return await ref.read(firebaseProvider.notifier).getShelfList(storeName);
  }

  Future createShelf(
      WidgetRef ref, String storeName) async {
    List<String> formTextList = [
      shelfNameController.text,
      shelfBarcodeController.text,
      shelfLimitController.text,
    ];
    try {
      if (ref
          .read(formValidationProvider)
          .isDefaultFormValidated(formTextList)) {
        ShelfModel newModel = ShelfModel.fromCreateList(formTextList);

        return await ref
            .read(firebaseProvider.notifier)
            .createNewShelf(storeName, newModel);
      } else {
        return StringConstants.formsNotValidatedText;
      }
    } catch (e) {
      return 'Error has been occourded';
    }
  }

  @observable
  String? dropDownSelected;

  @action
  changeSelectedDropDown(String selected) {
    dropDownSelected = selected;
  }
}
