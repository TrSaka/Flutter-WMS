import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_app/models/product_model.dart';
import '../../../models/machine_model.dart';
import '../../../models/shelf_model.dart';
import '../../extensions/firebase_extension.dart';

abstract class FirebaseFireStoreService {
  FirebaseFirestore firestore = FirebaseExtension.firestore;

  DocumentReference storePath(storeName) {
    return firestore
        .collection(FirebaseExtension.storeCollection)
        .doc(storeName);
  }

  DocumentReference shelfPath(storeName, shelfName) {
    return storePath(storeName)
        .collection(FirebaseExtension.shelfCollection)
        .doc(shelfName);
  }

  CollectionReference machinePath(storeName) {
    return storePath(storeName).collection(FirebaseExtension.machineCollection);
  }

  CollectionReference productPath(String storeName, String shelfName) {
    return storePath(storeName)
        .collection(FirebaseExtension.shelfCollection)
        .doc(shelfName)
        .collection(FirebaseExtension.productCollection);
  }

  Future getAllStores();

  Future getStoreNamesForListTile();

  Future createNewStore(String newStoreName);

  Future deleteStore(String storeName);

  Stream<QuerySnapshot<Map<String, dynamic>>> getShelfsListener(
      String storeName);

  Future createMachine(MachineModel model);

  Future<List<MachineModel>> getMachines();

  Future deleteMachine(MachineModel model);

  Stream getMachineStream();

  Future updateMachine(MachineModel newMachineModel);

  Future getMachineNames(String storeName);

  Future getSingleMachine(String storeName, String plcName);

  Future getShelfListName(String storeName);

  Future createNewProduct(
      String storeName, String shelfName, ProductModel model);

  Future createNewShelf(String storeName, ShelfModel shelfModel);

  Future<List<ProductModel?>?> searchFirebase(
      String storeName, String filterName);

  Future updateProduct(String storeName,ProductModel model);
}
