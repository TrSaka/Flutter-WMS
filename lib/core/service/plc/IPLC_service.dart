import 'package:stock_app/core/constants/enum/plc_enum.dart';
import 'package:stock_app/models/machine_model.dart';
import 'package:stock_app/models/plc_response_model.dart';

abstract class IPLCService {
  Future<PLCResponseModel> connectPLC(
      MachineModel model, PLCFunctionEnum enums);

  Stream listenPLC(socket);

  Future disconnectPLC(socket);

  
}
