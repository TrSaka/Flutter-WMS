// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobx/mobx.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';
import 'package:stock_app/core/riverpod/validation_riverpod.dart';
import 'package:stock_app/models/create_plc_response_model.dart';
import 'package:stock_app/models/machine_model.dart';
part 'create_plc_view_model.g.dart';

class CreatePLCViewModel = _CreatePLCViewModelBase with _$CreatePLCViewModel;

abstract class _CreatePLCViewModelBase with Store {
  
  late TextEditingController plcController;
  late TextEditingController portController;
  late TextEditingController ipAddressController;

  void initalizeControllers() {
    plcController = TextEditingController();
    portController = TextEditingController();
    ipAddressController = TextEditingController();
  }

  void disposeControllers() {
    plcController.dispose();
    portController.dispose();
    ipAddressController.dispose();
  }

  @observable
  bool state = true;

  @action
  mobxChangeStatus(bool newState) {
    state = newState;
  }

  returnModel(snapshot, index) {
    return snapshot.data![index];
  }

  bool checkPlcValidate(WidgetRef ref) {
    bool validateState = ref.read(formValidationProvider).isPLCValidated(
        plcController.text, ipAddressController.text, portController.text);

    if (validateState && selectedDropDown != null) {
      return true;
    } else {
      return false;
    }
  }

  Future updateMachine(WidgetRef ref, MachineModel newModel) async {
    return await ref.read(firebaseProvider.notifier).updateMachine(newModel);
  }

  Future deleteMachine(WidgetRef ref, MachineModel model) async {
    return await ref.read(firebaseProvider.notifier).deleteMachine(model);
  }

  @observable
  String? selectedDropDown;

  @action
  changeDropDownValue(String newSelect) {
    selectedDropDown = newSelect;
  }

  MachineModel setMachineModel() {
    return MachineModel(
      plcName: plcController.text,
      ipAddress: ipAddressController.text,
      portAddress: portController.text,
      plcStatus: true,
      storeName: selectedDropDown ?? '',
    );
  }

  Future<List<MachineModel>> getMachines(WidgetRef ref) async {
    return await ref.read(firebaseProvider.notifier).getMachines();
  }

  Future<List<String>> getStoreNames(WidgetRef ref) async {
    return await ref.read(firebaseProvider.notifier).getStoreNames();
  }

  Future<CreatePLCResponse> createPLCMachine(
      WidgetRef ref, MachineModel model) async {
    return await ref.read(firebaseProvider.notifier).createPLCMachine(model);
  }
}
