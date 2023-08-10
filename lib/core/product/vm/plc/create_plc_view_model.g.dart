// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_plc_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreatePLCViewModel on _CreatePLCViewModelBase, Store {
  late final _$stateAtom =
      Atom(name: '_CreatePLCViewModelBase.state', context: context);

  @override
  bool get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(bool value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$selectedDropDownAtom =
      Atom(name: '_CreatePLCViewModelBase.selectedDropDown', context: context);

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

  late final _$_CreatePLCViewModelBaseActionController =
      ActionController(name: '_CreatePLCViewModelBase', context: context);

  @override
  dynamic mobxChangeStatus(bool newState) {
    final _$actionInfo = _$_CreatePLCViewModelBaseActionController.startAction(
        name: '_CreatePLCViewModelBase.mobxChangeStatus');
    try {
      return super.mobxChangeStatus(newState);
    } finally {
      _$_CreatePLCViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDropDownValue(String newSelect) {
    final _$actionInfo = _$_CreatePLCViewModelBaseActionController.startAction(
        name: '_CreatePLCViewModelBase.changeDropDownValue');
    try {
      return super.changeDropDownValue(newSelect);
    } finally {
      _$_CreatePLCViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
selectedDropDown: ${selectedDropDown}
    ''';
  }
}
