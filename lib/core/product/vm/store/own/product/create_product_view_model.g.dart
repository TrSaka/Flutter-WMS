// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateProductViewModel on _CreateProductViewModelBase, Store {
  late final _$dropDownSelectedAtom = Atom(
      name: '_CreateProductViewModelBase.dropDownSelected', context: context);

  @override
  String? get dropDownSelected {
    _$dropDownSelectedAtom.reportRead();
    return super.dropDownSelected;
  }

  @override
  set dropDownSelected(String? value) {
    _$dropDownSelectedAtom.reportWrite(value, super.dropDownSelected, () {
      super.dropDownSelected = value;
    });
  }

  late final _$_CreateProductViewModelBaseActionController =
      ActionController(name: '_CreateProductViewModelBase', context: context);

  @override
  void changeSelectedDropDown(String selected) {
    final _$actionInfo =
        _$_CreateProductViewModelBaseActionController.startAction(
            name: '_CreateProductViewModelBase.changeSelectedDropDown');
    try {
      return super.changeSelectedDropDown(selected);
    } finally {
      _$_CreateProductViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dropDownSelected: ${dropDownSelected}
    ''';
  }
}
