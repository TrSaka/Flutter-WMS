import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/constants/color_constants.dart';
import '../constants/constants/string_constants.dart';

Drawer drawer(BuildContext context, viewModel, WidgetRef ref) {
  return Drawer(
    backgroundColor: Theme.of(context).backgroundColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
            future: viewModel.getStoreNames(ref),
            builder: (context, AsyncSnapshot snapshot) {
              return buildMenuItems(
                  context, viewModel.storeNamesList, viewModel);
            }),
      ],
    ),
  );
}

Widget buildMenuItems(
    BuildContext context, List<String?>? storeList, viewModel) {
  return Wrap(
    runSpacing: 16,
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.1,
          child: Column(
            children: [
              const SizedBox(height: 20),
              manageStoreListTile(viewModel, context),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: storeList?.length ?? 0,
                itemBuilder: (context, index) {
                  // ignore: prefer_is_empty
                  if (storeList?.length == 0) {
                    return const SizedBox();
                    //if user's has no store just pass it zero.
                  } else {
                    return ListTile(
                      leading: Icon(
                        Icons.store_mall_directory,
                        color: ColorConstants.colorPurple,
                      ),
                      title: Text(
                        storeList![index]!,
                        style: TextStyle(color: ColorConstants.colorPurple),
                      ),
                      onTap: () {
                        viewModel.navigateStore(context, storeList, index);
                        //navigates to store view by giving store name of parameter.
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

ListTile manageStoreListTile(viewModel, BuildContext context) {
  return ListTile(
    leading: Icon(
      Icons.store_mall_directory,
      color: ColorConstants.colorPurple,
    ),
    title: Text(
      StringConstants.storeText,
      style: TextStyle(color: ColorConstants.colorPurple),
    ),
    onTap: () {
      viewModel.navigateManageStore(context);
    },
  );
}
