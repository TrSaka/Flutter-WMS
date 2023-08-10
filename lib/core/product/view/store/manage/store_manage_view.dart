import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/base/base_view.dart';
import 'package:stock_app/core/constants/constants/color_constants.dart';
import 'package:stock_app/core/product/vm/store/manage/store_manage_view_model.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';
import 'package:stock_app/core/widgets/lottie_loading_widget.dart';
import '../../../../widgets/create_store_widget.dart';
import '../../../../widgets/store_row_widget.dart';

class StoreManageView extends ConsumerStatefulWidget {
  const StoreManageView({super.key});

  @override
  ConsumerState<StoreManageView> createState() => _StoreManageViewState();
}

class _StoreManageViewState extends ConsumerState<StoreManageView> {

  @override
  void dispose() {
    
    super.dispose();
  }
  final StoreManageViewModel viewModel = StoreManageViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      onModelReady: (model) {
        model = viewModel;
        viewModel.initalizeContorller();
      },
      onPageBuilder: (context, value) {
        return Scaffold(
          backgroundColor: ColorConstants.colorGrey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CreateNewStoreWidget(viewModel),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.colorWhite,
                      ),
                      height: MediaQuery.sizeOf(context).height / 2,
                      width: MediaQuery.sizeOf(context).width / 1.1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            futureBuilder(),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> futureBuilder() {
    return StreamBuilder(
      stream: ref.read(firebaseProvider.notifier).getStoreNameStream(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data != null) {
          List list = viewModel.setStoreNameList(snapshot);
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (context, index) {
                String storeText = list[index];

                return StoreRowWidget(
                    storeText: storeText, viewModel: viewModel);
              });
        } else if (snapshot.connectionState != ConnectionState.active) {
          return const CustomLoadingWidget();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
