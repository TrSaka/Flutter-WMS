import '../core/constants/enum/auth_enum.dart';

class LoginResponseModel {
  final String message;
  final AuthEnum state;
  LoginResponseModel({
    required this.message,
    required this.state,
  });

  LoginResponseModel copyWith({
    String? message,
    AuthEnum? state,
  }) {
    return LoginResponseModel(  
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }


  @override
  String toString() => 'LoginResponseModel(message: $message, state: $state)';

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.state == state;
  }

  @override
  int get hashCode => message.hashCode ^ state.hashCode;
}
