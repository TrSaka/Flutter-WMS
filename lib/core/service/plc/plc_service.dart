import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/constants/enum/plc_enum.dart';
import 'package:stock_app/core/service/plc/IPLC_service.dart';
import 'package:stock_app/models/machine_model.dart';
import 'package:stock_app/models/plc_response_model.dart';
import 'dart:html' as html;

class PLCService extends IPLCService {
  static PLCService? _instance;
  static PLCService? get instance {
    _instance ??= PLCService._init();
    return _instance;
  }

  PLCService._init();

  @override
  Future<PLCResponseModel> connectPLC(
      MachineModel model, PLCFunctionEnum? enums) async {
    try {
      if (kIsWeb) {
        final socket =
            html.WebSocket('ws://${model.ipAddress}:${model.portAddress}');

        return PLCResponseModel('WEB SOCKET', PLCStateEnum.CONNECTED, socket);
      } else {
        if (model.plcStatus == false) {
          return PLCResponseModel(
              StringConstants.deactiveDeviceText, PLCStateEnum.DEACTIVE, null);
        }

        final socket =
            await Socket.connect(model.ipAddress, int.parse(model.portAddress));

        return PLCResponseModel(StringConstants.connectedDeviceText,
            PLCStateEnum.CONNECTED, socket);
      }
    } catch (e) {
      debugPrint(e.toString());
      return PLCResponseModel(
          "Error has been occoured $e", PLCStateEnum.FAILED, null);
    }
  }

  @override
  Stream listenPLC(socket) {
    if (kIsWeb) {
      return socket.onMessage;
    } else {
      final stream = socket.transform(utf8.decoder);
      return stream;
    }
  }

  @override
  Future disconnectPLC(socket) async {
    return await socket.close();
  }
}
