// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_search_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainSearchViewModel on _MainSearchViewModelBase, Store {
  late final _$filteredListAtom =
      Atom(name: '_MainSearchViewModelBase.filteredList', context: context);

  @override
  List<ProductModel?>? get filteredList {
    _$filteredListAtom.reportRead();
    return super.filteredList;
  }

  @override
  set filteredList(List<ProductModel?>? value) {
    _$filteredListAtom.reportWrite(value, super.filteredList, () {
      super.filteredList = value;
    });
  }

  late final _$quantityAtom =
      Atom(name: '_MainSearchViewModelBase.quantity', context: context);

  @override
  int get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(int value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  late final _$_MainSearchViewModelBaseActionController =
      ActionController(name: '_MainSearchViewModelBase', context: context);

  @override
  dynamic initalizeQuantity(int newQuatity) {
    final _$actionInfo = _$_MainSearchViewModelBaseActionController.startAction(
        name: '_MainSearchViewModelBase.initalizeQuantity');
    try {
      return super.initalizeQuantity(newQuatity);
    } finally {
      _$_MainSearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic increaseQuantity() {
    final _$actionInfo = _$_MainSearchViewModelBaseActionController.startAction(
        name: '_MainSearchViewModelBase.increaseQuantity');
    try {
      return super.increaseQuantity();
    } finally {
      _$_MainSearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decreaseQuantity() {
    final _$actionInfo = _$_MainSearchViewModelBaseActionController.startAction(
        name: '_MainSearchViewModelBase.decreaseQuantity');
    try {
      return super.decreaseQuantity();
    } finally {
      _$_MainSearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showList(List<ProductModel?>? newList) {
    final _$actionInfo = _$_MainSearchViewModelBaseActionController.startAction(
        name: '_MainSearchViewModelBase.showList');
    try {
      return super.showList(newList);
    } finally {
      _$_MainSearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filteredList: ${filteredList},
quantity: ${quantity}
    ''';
  }
}
