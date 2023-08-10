import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/constants/enum/plc_enum.dart';
import 'package:stock_app/core/service/plc/plc_service.dart';
import 'package:stock_app/models/machine_model.dart';
import 'package:stock_app/models/plc_response_model.dart';

class PLCRiverpod extends ChangeNotifier {
  final _instance = PLCService.instance;

  Future<PLCResponseModel> connectPLC(
      MachineModel model, PLCFunctionEnum? enums) async {
    return await _instance!.connectPLC(model, enums);
  }

  Stream listenPLC(socket) {
    return _instance!.listenPLC(socket);
  }

  Future disconnect(socket) {
    return _instance!.disconnectPLC(socket);
  }
}

final plcProvider = ChangeNotifierProvider<PLCRiverpod>((ref) {
  return PLCRiverpod();
});
