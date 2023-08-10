// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreViewModel on _StoreViewModelBase, Store {
  late final _$bodyStateAtom =
      Atom(name: '_StoreViewModelBase.bodyState', context: context);

  @override
  int get bodyState {
    _$bodyStateAtom.reportRead();
    return super.bodyState;
  }

  @override
  set bodyState(int value) {
    _$bodyStateAtom.reportWrite(value, super.bodyState, () {
      super.bodyState = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_StoreViewModelBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$controllerAtom =
      Atom(name: '_StoreViewModelBase.controller', context: context);

  @override
  PageController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(PageController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$selectedDropDownAtom =
      Atom(name: '_StoreViewModelBase.selectedDropDown', context: context);

  @override
  String? get selectedDropDown {
    _$selectedDropDownAtom.reportRead();
    return super.selectedDropDown;
  }

  @override
  set selectedDropDown(String? value) {
    _$selectedDropDownAtom.reportWrite(value, super.selectedDropDown, () {
      super.selectedDropDown = value;
    });
  }

  late final _$isExpansionTileOpenAtom =
      Atom(name: '_StoreViewModelBase.isExpansionTileOpen', context: context);

  @override
  bool get isExpansionTileOpen {
    _$isExpansionTileOpenAtom.reportRead();
    return super.isExpansionTileOpen;
  }

  @override
  set isExpansionTileOpen(bool value) {
    _$isExpansionTileOpenAtom.reportWrite(value, super.isExpansionTileOpen, () {
      super.isExpansionTileOpen = value;
    });
  }

  late final _$_StoreViewModelBaseActionController =
      ActionController(name: '_StoreViewModelBase', context: context);

  @override
  dynamic changePageController(int pageController, int newPage) {
    final _$actionInfo = _$_StoreViewModelBaseActionController.startAction(
        name: '_StoreViewModelBase.changePageController');
    try {
      return super.changePageController(pageController, newPage);
    } finally {
      _$_StoreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpansionTileOpen(bool value) {
    final _$actionInfo = _$_StoreViewModelBaseActionController.startAction(
        name: '_StoreViewModelBase.setExpansionTileOpen');
    try {
      return super.setExpansionTileOpen(value);
    } finally {
      _$_StoreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeMiddlePage(int newPage) {
    final _$actionInfo = _$_StoreViewModelBaseActionController.startAction(
        name: '_StoreViewModelBase.changeMiddlePage');
    try {
      return super.changeMiddlePage(newPage);
    } finally {
      _$_StoreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDropDownValue(String newSelect) {
    final _$actionInfo = _$_StoreViewModelBaseActionController.startAction(
        name: '_StoreViewModelBase.changeDropDownValue');
    try {
      return super.changeDropDownValue(newSelect);
    } finally {
      _$_StoreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showSelectedShelfProduct() {
    final _$actionInfo = _$_StoreViewModelBaseActionController.startAction(
        name: '_StoreViewModelBase.showSelectedShelfProduct');
    try {
      return super.showSelectedShelfProduct();
    } finally {
      _$_StoreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bodyState: ${bodyState},
currentPage: ${currentPage},
controller: ${controller},
selectedDropDown: ${selectedDropDown},
isExpansionTileOpen: ${isExpansionTileOpen}
    ''';
  }
}
