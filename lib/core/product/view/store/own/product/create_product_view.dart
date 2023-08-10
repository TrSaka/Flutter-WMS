import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/base/base_view.dart';
import 'package:stock_app/core/constants/app/global/app_global.dart';
import 'package:stock_app/core/constants/constants/color_constants.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/mixins/snackbar_mixin.dart';
import 'package:stock_app/core/product/vm/store/own/product/create_product_view_model.dart';
import 'package:stock_app/core/widgets/future_list_tile_widget.dart';

import '../../../../../widgets/create_form_field_widget.dart';

class CreateProductView extends ConsumerStatefulWidget {
  const CreateProductView(this.storeName, {super.key});
  final String storeName;

  @override
  ConsumerState<CreateProductView> createState() => _CreateProductState();
}

class _CreateProductState extends ConsumerState<CreateProductView>
    with SnackbarMixin {

        final _viewModel = CreateProductViewModel();

  @override
  void initState() {
    _viewModel.initalizeControllers();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.disposeControllers();
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
                    Row(
                      children: [
                        titleText(),
                        Observer(builder: (context) {
                          return futureDropDown(
                            _viewModel.getShelfNames(ref, widget.storeName),
                            _viewModel.dropDownSelected,
                            _viewModel.changeSelectedDropDown,
                          );
                        }),
                      ],
                    ),
                    productForms(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        await _viewModel
                            .createProduct(ref, widget.storeName,
                                _viewModel.dropDownSelected ?? '')
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
                        child: const Center(
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
          controller: _viewModel.productController,
          hintText: StringConstants.productNameText,
        ),
        CreateTextFormField(
          controller: _viewModel.barcodeController,
          hintText: StringConstants.barcodeText,
        ),
        CreateTextFormField(
          controller: _viewModel.categoryController,
          hintText: StringConstants.categoryText,
        ),
        CreateTextFormField(
          controller: _viewModel.brandController,
          hintText: StringConstants.brandText,
        ),
        CreateTextFormField(
          controller: _viewModel.typeController,
          hintText: StringConstants.typeText,
        ),
        CreateTextFormField(
          controller: _viewModel.quantityController,
          hintText: StringConstants.quantityText,
        ),
      ],
    );
  }

  Text titleText() => const Text(StringConstants.selectShelfText);
}
