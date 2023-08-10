// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../core/constants/enum/plc_enum.dart';

@immutable
class PLCResponseModel extends Equatable {
  dynamic socket;
  final String description;
  final PLCStateEnum state;

  PLCResponseModel(this.description, this.state, this.socket);

  List<Object?> get props => [description, state];
}
