// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuViewModel on _MenuViewModelBase, Store {
  late final _$selectedIndexAtom =
      Atom(name: '_MenuViewModelBase.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$_MenuViewModelBaseActionController =
      ActionController(name: '_MenuViewModelBase', context: context);

  @override
  dynamic changeSelectedIndex(int newPageNumber) {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.changeSelectedIndex');
    try {
      return super.changeSelectedIndex(newPageNumber);
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex}
    ''';
  }
}
