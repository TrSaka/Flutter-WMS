import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/mixins/snackbar_mixin.dart';
import 'package:stock_app/core/mixins/validate_mixin.dart';
import 'package:stock_app/core/product/vm/plc/create_plc_view_model.dart';
import 'package:stock_app/core/riverpod/validation_riverpod.dart';
import 'package:stock_app/models/machine_model.dart';
import '../../../base/base_view.dart';
import '../../../constants/constants/color_constants.dart';
import '../../../constants/constants/string_constants.dart';
import '../../../widgets/future_list_tile_widget.dart';
import '../../../widgets/lottie_loading_widget.dart';

class CreatePLCView extends ConsumerStatefulWidget {
  const CreatePLCView({super.key});

  @override
  ConsumerState<CreatePLCView> createState() => _CreatePLCViewState();
}

class _CreatePLCViewState extends ConsumerState<CreatePLCView>
    with SnackbarMixin, ValidationMixin {
  final CreatePLCViewModel _viewModel = CreatePLCViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: _viewModel,
      onModelReady: (model) {
        _viewModel.initalizeControllers();
        model = _viewModel;
      },
      onDispose: () => _viewModel.disposeControllers(),
      onPageBuilder: (context, value) {
        return Scaffold(
          backgroundColor: ColorConstants.colorGrey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTopContainer(context),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: _buildMachineList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopContainer(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.colorWhite),
          height: MediaQuery.of(context).size.height / 2.7,
          width: MediaQuery.of(context).size.width / 1.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(StringConstants.createPLCText),
                const SizedBox(height: 20),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: _buildFormFields(),
                ),
                const SizedBox(height: 5),
                _buildFormButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 5,
            child: TextFormField(
              controller: _viewModel.plcController,
              decoration: const InputDecoration(
                  hintText: StringConstants.plcFormText,
                  border: OutlineInputBorder()),
              onChanged: (value) => ref
                  .read(formValidationProvider)
                  .plcNameValidationRiverpod(value),
              validator: (text) => plcNameValidationMixin(text ?? ''),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            flex: 3,
            child: TextFormField(
              controller: _viewModel.portController,
              decoration: const InputDecoration(
                  hintText: StringConstants.portFormText,
                  border: OutlineInputBorder()),
              onChanged: (value) => ref
                  .read(formValidationProvider)
                  .portValidationRiverpod(value),
              validator: (text) => portValidationMixin(text ?? ''),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            flex: 2,
            child: TextFormField(
              controller: _viewModel.ipAddressController,
              decoration: const InputDecoration(
                  hintText: StringConstants.ipAddressFormText,
                  border: OutlineInputBorder()),
              onChanged: (value) => ref
                  .read(formValidationProvider)
                  .ipAdressValidationRiverpod(value),
              validator: (text) => ipAdressValidationMixin(text ?? ''),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormButtons() {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            bool validateState = _viewModel.checkPlcValidate(ref);

            if (validateState) {
              MachineModel machineModel = _viewModel.setMachineModel();
              await _viewModel.createPLCMachine(ref, machineModel);
            } else {
              showSnackBar(context, StringConstants.formsNotValidatedText);
            }
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
        Observer(builder: (context) {
          return futureDropDown(
            _viewModel.getStoreNames(ref),
            _viewModel.selectedDropDown,
            _viewModel.changeDropDownValue,
          );
        }),
      ],
    );
  }

  Widget _buildMachineList() {
    return FutureBuilder<List<MachineModel>>(
      future: _viewModel.getMachines(ref),
      builder: (context, AsyncSnapshot<List<MachineModel>> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width / 1.1,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MachineModel machineModel =
                    _viewModel.returnModel(snapshot, index);
                return _buildMachineItem(machineModel);
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoadingWidget();
        } else {
          return const Text("No Store");
        }
      },
    );
  }

  Widget _buildMachineItem(MachineModel machineModel) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.colorGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(machineModel.plcName),
          Text(StringConstants.ipText + machineModel.ipAddress),
          Text(StringConstants.portText + machineModel.portAddress),
          Text(machineModel.storeName),
          TextButton(
            onPressed: () async {
              machineModel.plcStatus = !machineModel.plcStatus;
              await _viewModel.updateMachine(ref, machineModel);
              setState(() {});
            },
            child:
                Text(machineModel.plcStatus == true ? StringConstants.deactiveDeviceText : StringConstants.activeText),
          ),
          TextButton(
            onPressed: () async {
              await _viewModel.deleteMachine(ref, machineModel);
            },
            child: const Text(
              StringConstants.removePLC,
              style: TextStyle(color: ColorConstants.colorRed),
            ),
          ),
        ],
      ),
    );
  }
}
