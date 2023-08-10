import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/constants/enum/plc_response_state_enum.dart';
import 'package:stock_app/core/extensions/firebase_extension.dart';
import 'package:stock_app/core/service/cloud/IFirestore.dart';
import 'package:stock_app/models/create_plc_response_model.dart';
import 'package:stock_app/models/machine_model.dart';
import 'package:stock_app/models/product_model.dart';
import 'package:stock_app/models/shelf_model.dart';

class FirestoreService extends FirebaseFireStoreService {
  static FirestoreService? _instance;
  static FirestoreService? get instance {
    _instance ??= FirestoreService._init();
    return _instance;
  }

  FirestoreService._init();

  @override
  Future getAllStores() async {}

  @override
  Future<List<String>> getStoreNamesForListTile() async {
    List<String> storeNames = [];

    QuerySnapshot<Map<String, dynamic>> storeNameResponse =
        await FirebaseFirestore.instance
            .collection(FirebaseExtension.storeCollection)
            .get();

    for (var element in storeNameResponse.docs) {
      storeNames.add(element[FirebaseExtension.storeName]);
    }
    return storeNames;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStoreNameStream() {
    return firestore.collection(FirebaseExtension.storeCollection).snapshots();
  }

  @override
  Future createNewStore(String newStoreName) async {
    var collection = await storePath(newStoreName).get();

    if (collection.exists == false) {
      try {
        await storePath(newStoreName).set({'storeName': newStoreName});
        return StringConstants.succesfullyCreated;
      } catch (e) {
        Exception(StringConstants.createNewStoreExpect);
      }
    } else {
      return StringConstants.storeSameNameError;
    }
  }

  @override
  Future deleteStore(String storeName) async {
    try {
      return await storePath(storeName).delete();
    } catch (e) {
      return e;
    }
  }

  Future<List<ShelfModel?>?> getShelfs(String storeName) async {
    List<ShelfModel?>? shelfList = [];
    var path = await firestore
        .collection('stores')
        .doc(storeName)
        .collection('shelfs')
        .get();

    if (path.docs.isNotEmpty) {
      for (var element in path.docs) {
        List<ProductModel>? productList =
            await getProducts(storeName, element['shelfName']);

        var model = ShelfModel.fromFirebase(element, productList);
        shelfList.add(model);
      }
    }
    return shelfList;
  }

  Future<List<ProductModel>?> getProducts(
      String storeName, String shelfName) async {
    List<ProductModel>? productList = [];
    try {
      var path = await productPath(storeName, shelfName).get();

      for (var element in path.docs) {
        productList.add(ProductModel.fromFirebase(element));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    debugPrint(productList.toString());

    return productList;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getShelfsListener(
      String storeName) {
    return storePath(storeName).collection('shelfs').snapshots();
  }

  @override
  Future<CreatePLCResponse> createMachine(MachineModel model) async {
    CreatePLCResponse responseModel = CreatePLCResponse(
        state: CreatePLCState.PLC_STATELESS,
        description: StringConstants.plcStateLessText);
    var path = machinePath(model.storeName);

    try {
      return await path
          .doc(model.plcName)
          .set(model.toFirebase(model))
          .then((value) => responseModel.copyWith(
                description: StringConstants.plcSuccessText,
                state: CreatePLCState.PLC_SUCCESS,
              ));
    } catch (e) {
      return responseModel.copyWith(
        description: StringConstants.plcFailedText + e.toString(),
        state: CreatePLCState.PLC_FAILED,
      );
    }
  }

  @override
  Future<List<MachineModel>> getMachines() async {
    List<MachineModel> machineList = [];

    List<String> storeList = await getStoreNamesForListTile();

    for (var storeName in storeList) {
      QuerySnapshot path = await machinePath(storeName).get();
      for (var element in path.docs) {
        machineList.add(MachineModel.fromFirebase(element));
      }
    }

    return machineList;
  }

  @override
  Future<void> deleteMachine(MachineModel model) async {
    return machinePath(model.storeName).doc(model.plcName).delete();
  }

  @override
  Stream getMachineStream() {
    return firestore
        .collectionGroup(FirebaseExtension.machineCollection)
        .snapshots();
  }

  @override
  Future updateMachine(MachineModel newMachineModel) async {
    return await machinePath(newMachineModel.storeName)
        .doc(newMachineModel.plcName)
        .update(
          newMachineModel.toFirebase(newMachineModel),
        );
  }

  @override
  Future<List<String>> getMachineNames(String storeName) async {
    List<String> modelList = [];
    QuerySnapshot<Object?> data = await machinePath(storeName).get();
    for (var element in data.docs) {
      modelList.add(element['plcName']);
    }
    return modelList;
  }

  @override
  Future getSingleMachine(String storeName, String machineName) async {
    DocumentSnapshot path = await machinePath(storeName).doc(machineName).get();

    return MachineModel.fromFirebase(path);
  }

  @override
  Future getShelfListName(String storeName) async {
    List<String> shelfList = [];

    var path = await storePath(storeName)
        .collection(FirebaseExtension.shelfCollection)
        .get();

    for (var element in path.docs) {
      shelfList.add(element[FirebaseExtension.shelfName]);
    }
    return shelfList;
  }

  @override
  Future createNewProduct(
      String storeName, String shelfName, ProductModel model) async {
    try {
      await checkProduct(storeName, shelfName, model).then((value) =>
          productPath(storeName, shelfName).doc(model.productName).set(
                model.toFirebase(model),
              ));

      return StringConstants.succesfullyCreated;
    } catch (e) {
      return e;
    }
  }

  @override
  Future createNewShelf(String storeName, ShelfModel shelfModel) async {
    return checkShelf(shelfModel, storeName).then((value) =>
        storePath(storeName)
            .collection(FirebaseExtension.shelfCollection)
            .doc(shelfModel.shelfName)
            .set(shelfModel.toFirebase(shelfModel)));
  }

  Future<bool> checkShelf(ShelfModel model, String storeName) async {
    var path = await shelfPath(storeName, model.shelfName).get();

    if (path.exists) {
      return false;
    } else {
      return true;
    }
  }

  Future checkProduct(
      String storeName, String shelfName, ProductModel model) async {
    var path =
        await productPath(storeName, shelfName).doc(model.productName).get();
    if (path.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<List<ProductModel?>?> searchFirebase(
      String storeName, String filterName) async {
    List<ProductModel?>? products = [];
    try {
      if (filterName == '') {
        return [];
      }
      QuerySnapshot filteredByNameSnapshot =
          await returnFilterData(FirebaseExtension.productName, filterName);

      if (filteredByNameSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnapshot in filteredByNameSnapshot.docs) {
          Map<String, dynamic> productData =
              docSnapshot.data() as Map<String, dynamic>;

          products.add(ProductModel.fromFirebase(productData));
        }
        return products;
      } else {
        QuerySnapshot filteredByBarcodeSnapshot =
            await returnFilterData(FirebaseExtension.barcodeName, filterName);

        if (filteredByBarcodeSnapshot.docs.isNotEmpty) {
          for (QueryDocumentSnapshot docSnapshot
              in filteredByBarcodeSnapshot.docs) {
            Map<String, dynamic> productData =
                docSnapshot.data() as Map<String, dynamic>;

            products.add(ProductModel.fromFirebase(productData));

            print("Ürün Verisi: $productData");
          }
          return products;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return products;
  }

  returnFilterData(whereGroup, filteredData) {
    return firestore
        .collectionGroup(FirebaseExtension.productCollection)
        .where(whereGroup, isEqualTo: filteredData)
        .get();
  }

  @override
  Future updateProduct(String storeName, ProductModel model) async {
    return productPath(storeName, model.shelf!)
        .doc(model.productName)
        .set(model.toFirebase(model));
  }
}
