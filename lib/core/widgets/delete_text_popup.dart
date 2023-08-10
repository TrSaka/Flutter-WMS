import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/constants/color_constants.dart';
import '../constants/constants/string_constants.dart';
import '../product/vm/store/manage/store_manage_view_model.dart';

class DeleteButtonWithPopUp extends ConsumerWidget {
  const DeleteButtonWithPopUp(
    this.viewModel,
    this.storeName, {
    super.key,
  });

  final StoreManageViewModel viewModel;
  final String storeName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(StringConstants.deleteStoreText),
                actions: [
                  cancelTextPopup(context),
                  TextButton(
                      onPressed: () async {
                        await viewModel
                            .deleteStore(ref, storeName)
                            .then((value) => context.pop());  
                      },
                      child: const Text(StringConstants.deleteText)),
                ],
              );
            },
          );
        },
        child: const Text(StringConstants.removeStore,
            style: TextStyle(
              color: ColorConstants.colorRed,
            )),
      ),
    );
  }

  TextButton cancelTextPopup(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.pop();
        },
        child: const Text(StringConstants.cancelText));
  }
}
