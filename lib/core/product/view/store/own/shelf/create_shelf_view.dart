import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/product/vm/store/own/shelf/create_shelf_view_model.dart';
import 'package:stock_app/core/widgets/create_form_field_widget.dart';
import '../../../../../base/base_view.dart';
import '../../../../../constants/app/global/app_global.dart';
import '../../../../../constants/constants/color_constants.dart';
import '../../../../../constants/constants/string_constants.dart';
import '../../../../../mixins/snackbar_mixin.dart';

class CreateShelfView extends ConsumerStatefulWidget {
  const CreateShelfView({super.key, required this.storeName});
  final String storeName;

  @override
  ConsumerState<CreateShelfView> createState() => _CreateShelfState();
}

class _CreateShelfState extends ConsumerState<CreateShelfView>
    with SnackbarMixin {
  final _viewModel = CreateShelfViewModel();

  @override
  void initState() {
    _viewModel.initalizeControllers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: _viewModel,
      onModelReady: (model) {
        model = _viewModel;
      },
      onPageBuilder: (context, value) {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width / 20),
              child: Form(
                key: GlobalConstants.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      StringConstants.createProductText,
                      style: TextStyle(fontSize: 16),
                    ),
                    productForms(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        await _viewModel
                            .createShelf(ref, widget.storeName)
                            .then((value) {
                          showSnackBar(context, value.toString());
                          _viewModel.clearControllers();
                          setState(() {});
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorConstants.backround,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  const Center(
                          child: Text(
                            StringConstants.submitText,
                            style: TextStyle(color: ColorConstants.colorWhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column productForms() {
    return Column(
      children: [
        CreateTextFormField(
          controller: _viewModel.shelfNameController,
          hintText: StringConstants.shelfNameText,
        ),
        CreateTextFormField(
          controller: _viewModel.shelfBarcodeController,
          hintText: StringConstants.shelfBarcodeText,
        ),
        CreateTextFormField(
          controller: _viewModel.shelfLimitController,
          hintText: StringConstants.shelfLimitText,
        ),
      ],
    );
  }

  Text titleText() => const Text(StringConstants.selectShelfText);
}
