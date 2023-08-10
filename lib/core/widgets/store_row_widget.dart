import 'package:flutter/material.dart';

import '../product/vm/store/manage/store_manage_view_model.dart';
import 'delete_text_popup.dart';

class StoreRowWidget extends StatelessWidget {
  const StoreRowWidget({
    super.key,
    required this.storeText,
    required this.viewModel,
  });

  final String storeText;
  final StoreManageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 10,
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                storeText,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            DeleteButtonWithPopUp(viewModel, storeText),
          ],
        ),
      ),
    );
  }
}
