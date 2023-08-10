import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app/global/app_global.dart';
import '../constants/constants/color_constants.dart';
import '../constants/constants/string_constants.dart';
import '../mixins/snackbar_mixin.dart';
import '../product/vm/store/manage/store_manage_view_model.dart';

class CreateNewStoreWidget extends ConsumerWidget with SnackbarMixin {
  const CreateNewStoreWidget(
    this.viewModel, {
    super.key,
  });

  final StoreManageViewModel viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.colorWhite),
          height: MediaQuery.of(context).size.height / 2.7,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                createStoreText(context),
                const SizedBox(height: 20),
                craeteStoreTextForm(viewModel.createStoreController),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    await viewModel
                        .createNewStore(
                            ref, viewModel.createStoreController.text)
                        .then((value) {
                      showSnackBar(context, value ?? '');
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 13,
                    width: 80,
                    decoration: BoxDecoration(
                        color: ColorConstants.colorGreen,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                        child: Text(
                      StringConstants.saveText,
                      style: TextStyle(
                        color: ColorConstants.colorWhite,
                        fontSize: 14,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form craeteStoreTextForm(formController) {
    return Form(
      key: GlobalConstants.formKey,
      child: TextFormField(
        controller: formController,
        decoration: InputDecoration(
          label: const Text(StringConstants.storeName),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Text createStoreText(BuildContext context) {
    return Text(StringConstants.createStoreText,
        style: Theme.of(context).textTheme.titleLarge);
  }
}
