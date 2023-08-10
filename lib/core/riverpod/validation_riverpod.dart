import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/mixins/validate_mixin.dart';

final formValidationProvider = Provider<FormValidation>((ref) {
  return FormValidation();
});

class FormValidation with ValidationMixin {
  bool defaultValidaitonRiverpod(String text) {
    return mixinToRiverpod(defaultValidationMixin(text));
  }

  bool emailValidationRiverpod(String text) {
    return mixinToRiverpod(emailValidationBySentence(text));
  }

  bool passwordValidationRiverpodd(String text) {
    return mixinToRiverpod(passwordValidationMixin(text));
  }

  bool ipAdressValidationRiverpod(String text) {
    return mixinToRiverpod(ipAdressValidationMixin(text));
  }

  bool portValidationRiverpod(String text) {
    return mixinToRiverpod(portValidationMixin(text));
  }

  bool plcNameValidationRiverpod(String text) {
    return mixinToRiverpod(plcNameValidationMixin(text));
  }

  bool isPLCValidated(plcName, plcIP, plcPort) {
    if (plcNameValidationRiverpod(plcName) &&
        ipAdressValidationRiverpod(plcIP) &&
        portValidationRiverpod(plcPort) == true) {
      return true;
    } else {
      return false;
    }
  }

  bool isDefaultFormValidated(List<String> list) {
    for (var defaultText in list) {
      if (!defaultValidaitonRiverpod(defaultText)) {
        return false;
      }
    }
    return true;
  }

  mixinToRiverpod(mixin) {
    if (mixin == null) {
      return true;
    } else {
      return false;
    }
  }
}
