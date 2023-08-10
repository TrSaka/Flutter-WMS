import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/product/vm/store/own/main/main_search_view_model.dart';
import 'package:stock_app/models/product_model.dart';

class MainSearchView extends ConsumerStatefulWidget {
  const MainSearchView(this.storeName, {super.key});

  @override
  ConsumerState<MainSearchView> createState() => _MainSearchViewState();
  final String storeName;
}

class _MainSearchViewState extends ConsumerState<MainSearchView> {
  final MainSearchViewModel viewModel = MainSearchViewModel();

  @override
  void initState() {
    viewModel.initalizeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: _buildSearchForm(context),
      ),
      body: Observer(
        builder: (context) {
          if (viewModel.filteredList == null) {
            return const SizedBox();
          }
          debugPrint(viewModel.filteredList.toString());
          return ListView.builder(
            itemCount: viewModel.filteredList!.length,
            itemBuilder: (context, index) {
              ProductModel? model = viewModel.filteredList![index];
              viewModel.initalizeQuantity(model!.quantity);
              return Observer(builder: (context) {
                return _buildProductRow(context, model);
              });
            },
          );
        },
      ),
    );
  }

  Form _buildSearchForm(BuildContext context) {
    return Form(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: TextFormField(
              controller: viewModel.searchBarController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await viewModel.firebaseSearch(ref, widget.storeName)?.then(
                (newList) {
                  viewModel.showList(newList);
                },
              );
            },
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, ProductModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("SHELF : ${model.shelf} "),
        Text(model.productName),
        Text("Barcode: ${model.barcode}"),
        Text("Type: ${model.type}"),
        Text("Brand: ${model.brand}"),
        Text("Category: ${model.category}"),
        Text("Quantity: ${viewModel.quantity}"),
        IconButton(
          onPressed: viewModel.decreaseQuantity,
          icon: const Icon(Icons.remove),
        ),
        IconButton(
          onPressed: viewModel.increaseQuantity,
          icon: const Icon(Icons.add),
        ),
        TextButton(
          onPressed: () async {
            await viewModel.updateNewModel(
              ref,
              widget.storeName,
              model.copyWith(quantity: viewModel.quantity),
            );
          },
          child: const Text("SAVE"),
        ),
      ],
    );
  }
}
