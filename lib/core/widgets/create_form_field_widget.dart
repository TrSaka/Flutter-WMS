import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/mixins/validate_mixin.dart';
import 'package:stock_app/core/riverpod/validation_riverpod.dart';

class CreateTextFormField extends ConsumerWidget with ValidationMixin {
  const CreateTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: controller,
        validator: (text) => defaultValidationMixin(text ?? ''),
        onChanged: (changedText) {
          ref
              .read(formValidationProvider)
              .defaultValidaitonRiverpod(changedText);
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

