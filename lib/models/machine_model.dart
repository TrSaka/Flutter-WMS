// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class MachineModel extends Equatable {
  //this model not gonne immt. because we use this model in data trans.
  final String plcName;
  final String ipAddress;
  final String portAddress;
  bool plcStatus;
  String storeName;
  String receivedData;
  String sentData;

  MachineModel({
    required this.plcName,
    required this.ipAddress,
    this.plcStatus = false,
    required this.portAddress,
    this.receivedData = '',
    this.sentData = '',
    this.storeName = '',
  });

  MachineModel updateStatus(bool newStatus) {
    return MachineModel(
      plcName: plcName,
      ipAddress: ipAddress,
      plcStatus: newStatus,
      portAddress: portAddress,
      receivedData: receivedData,
      sentData: sentData,
    );
  }

  Map<String, dynamic> toFirebase(
    MachineModel model,
  ) {
    return ({
      'plcName': model.plcName,
      'ipAddress': model.ipAddress,
      'portAddress': model.portAddress,
      'plcStatus': model.plcStatus,
      'storeName':model.storeName,
    });
  }

  factory MachineModel.fromFirebase(map) {
    return MachineModel(
      plcName: map['plcName'],
      ipAddress: map['ipAddress'],
      portAddress: map['portAddress'],
      plcStatus: map['plcStatus'],
      storeName: map['storeName'],
    );
  }

  // Add other update methods if needed...

  @override
  List<Object?> get props => [
        plcName,
        plcStatus,
        ipAddress,
        portAddress,
        plcStatus,
      ];
}
