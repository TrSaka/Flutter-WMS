// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../core/constants/enum/plc_response_state_enum.dart';

class CreatePLCResponse {
  final CreatePLCState state;
  final String description;
  CreatePLCResponse({
    required this.state,
    required this.description,
  });

  CreatePLCResponse copyWith({
    CreatePLCState? state,
    String? description,
  }) {
    return CreatePLCResponse(
      state: state ?? this.state,
      description: description ?? this.description,
    );
  }
}
