// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/base/base_view.dart';
import 'package:stock_app/core/constants/constants/color_constants.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/extensions/string_extension.dart';
import 'package:stock_app/core/mixins/snackbar_mixin.dart';
import 'package:stock_app/core/product/view/store/own/main/main_search_view.dart';
import 'package:stock_app/core/product/view/store/own/product/create_product_view.dart';
import 'package:stock_app/core/product/view/store/own/shelf/create_shelf_view.dart';
import 'package:stock_app/core/product/vm/store/own/store_view_model.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';
import 'package:stock_app/core/riverpod/plc_riverpod.dart';
import 'package:stock_app/core/widgets/lottie_loading_widget.dart';
import 'package:stock_app/models/product_model.dart';
import '../../../../widgets/future_list_tile_widget.dart';
import '../../../../widgets/product_list_tile_widget.dart';

class StoreView extends ConsumerStatefulWidget {
  const StoreView({Key? key, this.storeName}) : super(key: key);

  final String? storeName;

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends ConsumerState<StoreView> with SnackbarMixin {
  final StoreViewModel _viewModel = StoreViewModel();

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
          body: Row(
            children: [
              buildLeftSide(),
              buildRightSide(),
            ],
          ),
        );
      },
    );
  }

  Widget buildLeftSide() {
    return Flexible(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.colorGrey, width: 2),
          color: ColorConstants.colorWhite,
        ),
        child: Column(
          children: [
            storeText(),
            buildShelfListView(),
          ],
        ),
      ),
    );
  }

  Widget buildRightSide() {
    return Flexible(
      flex: 8,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _viewModel.changeMiddlePage(1);
                  },
                  child: const SizedBox(
                    child: Text(
                      "CREATE NEW SHELF",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Observer(
                  builder: (context) {
                    if (_viewModel.selectedDropDown != null) {
                      debugPrint(_viewModel.selectedDropDown);
                    }
                    return futureDropDown(
                      _viewModel.getMachineNames(ref, widget.storeName!),
                      _viewModel.selectedDropDown,
                      _viewModel.changeDropDownValue,
                    );
                  },
                ),
                TextButton(
                  onPressed: () async {
                    await ref
                        .read(firebaseProvider.notifier)
                        .getSingleMachine(
                          widget.storeName!,
                          _viewModel.selectedDropDown!,
                        )
                        .then((singleModel) => ref
                            .read(plcProvider.notifier)
                            .connectPLC(singleModel, null))
                        .then((value) => ref
                            .read(plcProvider.notifier)
                            .listenPLC(value.socket))
                        .then((value) {
                      _viewModel.plcStream = value;
                    });
                  },
                  child: const Text("Connect"),
                ),
                IconButton(
                  onPressed: () {
                    _viewModel.selectedDropDown = null;
                    ref
                        .read(plcProvider.notifier)
                        .disconnect(_viewModel.plcStream);
                  },
                  icon: const Icon(Icons.restore_sharp),
                ),
                TextButton(
                  onPressed: () {
                    _viewModel.changeMiddlePage(2);
                  },
                  child: SizedBox(
                    child: Text(
                      StringConstants.createProductText.toUpc(),
                      style: const TextStyle(
                        color: ColorConstants.colorBlue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: ColorConstants.colorGrey,
                child: Observer(
                  builder: (context) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: ColorConstants.colorGrey,
                        child: Observer(builder: (context) {
                          return PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (int newPage) {
                              _viewModel.changeMiddlePage(newPage);
                            },
                            controller: _viewModel.controller,
                            children: [
                              [
                                MainSearchView(widget.storeName!),
                                CreateShelfView(storeName: widget.storeName!),
                                CreateProductView(widget.storeName!)
                              ][_viewModel.currentPage]
                            ],
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text storeText() {
    return Text(
      StringConstants.storeText.toUpc(),
    );
  }

  Widget buildShelfListView() {
    return StreamBuilder(
      stream: _viewModel.getShelfsListener(ref, widget.storeName!),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List? shelfNameList = _viewModel.setListFromListener(snapshot);
          return FutureBuilder(
            future: _viewModel.getShelfList(ref, widget.storeName!),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CustomLoadingWidget();
              }
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return const SizedBox();
              }
              if (snapshot.hasData && snapshot.data != null) {
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: shelfNameList!.length,
                    itemBuilder: (context, index) {
                      String shelfName = shelfNameList[index]!;
                      return ExpansionTile(
                        title: Text(shelfName),
                        onExpansionChanged: (isExpanded) {
                          if (isExpanded) {
                            _viewModel.setExpansionTileOpen(true);
                          }
                        },
                        children: [
                          Column(
                            children: [
                              const Text(StringConstants.productsText),
                              Observer(
                                builder: (context) {
                                  if (_viewModel.isExpansionTileOpen) {
                                    return FutureBuilder(
                                      future: _viewModel.getProducts(
                                          ref, widget.storeName!, shelfName),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return const CustomLoadingWidget();
                                        }
                                        if (snapshot.hasError) {
                                          debugPrint(snapshot.error.toString());
                                          return const SizedBox();
                                        }
                                        if (snapshot.hasData) {
                                          List<ProductModel> products =
                                              snapshot.data;
                                          return SizedBox(
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: products.length,
                                              itemBuilder: (context, index) {
                                                return ExpansionTile(
                                                  title: Text(products[index]
                                                      .productName),
                                                  children: [
                                                    ProductListTilesWidget(
                                                      product: products[index],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const SizedBox();
        } else if (snapshot.connectionState != ConnectionState.done) {
          return const CustomLoadingWidget();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
