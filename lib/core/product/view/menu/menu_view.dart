import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/base/base_view.dart';
import 'package:stock_app/core/constants/constants/color_constants.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/constants/enum/store_type_enum.dart';
import 'package:stock_app/core/product/vm/menu/menu_view_model.dart';
import '../../../widgets/app_bar_tile_widget.dart';

class MenuView extends ConsumerStatefulWidget {
  const MenuView({super.key});

  @override
  ConsumerState<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends ConsumerState<MenuView> {
  final MenuViewModel _viewModel = MenuViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: _viewModel,
      onModelReady: (model) async {
        model = _viewModel;
      },
      onPageBuilder: (context, value) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: ColorConstants.backround,
                expandedHeight: 80,
                flexibleSpace: Row(
                  children: [
                    manageStore(),
                    createRobot(),
                    Expanded(
                      child: StreamBuilder(
                        stream: _viewModel.getStoreNameAsStream(ref),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.active) {
                            return const SizedBox();
                          }
                          if (snapshot.hasData) {
                            List storeNamesList =
                                _viewModel.setStoreNameList(snapshot);

                            _viewModel.setNewList(storeNamesList);
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: storeNamesList.length,
                              itemBuilder: (context, index) {
                                String storeName = storeNamesList[index];
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    child: AppBarTileWidget(
                                      viewModel: _viewModel,
                                      subtitleText: storeName,
                                      iconData: Icons.store,
                                      pageIndex: index + 2,
                                      storeType: StoreType.MANUAL_PAGE,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Observer(
                  builder: (context) =>
                      _viewModel.bodyList[_viewModel.selectedIndex],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container manageStore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: AppBarTileWidget(
          viewModel: _viewModel,
          subtitleText: StringConstants.storeText,
          iconData: Icons.store,
          pageIndex: 0,
          storeType: StoreType.MANUAL_PAGE),
    );
  }

  Container createRobot() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: AppBarTileWidget(
        viewModel: _viewModel,
        subtitleText: StringConstants.createRobotText,
        iconData: Icons.adb,
        pageIndex: 1,
        storeType: StoreType.PLC_PAGE,
      ),
    );
  }
}
