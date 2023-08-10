import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobx/mobx.dart';
import 'package:stock_app/core/product/routes/router.dart';
import 'package:stock_app/core/product/view/plc/create_plc_view.dart';
import 'package:stock_app/core/product/view/store/manage/store_manage_view.dart';
import 'package:stock_app/core/product/view/store/own/store_view.dart';
import '../../../riverpod/firebase_riverpod.dart';
part 'menu_view_model.g.dart';


class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store {


  List storeNamesList = [];

  @observable
  int selectedIndex = 0;

  List bodyList = [
    const StoreManageView(),
    const CreatePLCView(),
    // ignore: prefer_const_constructors

    //because we change bodyList
  ];

  @action
  changeSelectedIndex(int newPageNumber) {
    selectedIndex = newPageNumber;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStoreNameAsStream(
      WidgetRef ref) {
    return ref.read(firebaseProvider.notifier).getStoreNameStream();
  }

  Future getStoreNames(WidgetRef ref) async {
    List nameList = await ref.read(firebaseProvider.notifier).getStoreNames();

    storeNamesList = nameList;
    debugPrint(nameList.toString());

    return storeNamesList;
  }

  setStoreNameList(snapshot) {
    return snapshot.data!.docs.map((doc) => doc.data()['storeName']).toList();
  }

  setNewList(storeNamesList) {
    for (int i = 2; i < (storeNamesList.length + 2); i++) {
      bodyList.add(StoreView(
        storeName: storeNamesList[i - 2],
      ));
    }
  }

  navigateStore(BuildContext context, storeList, index) {
    return Routers.goRouterSingleParameters(context, Routers.toOwnStore,
        Routers.ownStoreParameterName, storeList[index]!);
  }

  navigateManageStore(BuildContext context) {
    return Routers.goRoute(context, Routers.toManageStore);
  }
}
