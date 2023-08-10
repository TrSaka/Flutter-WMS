import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/service/auth/auth_service.dart';
import 'package:stock_app/core/service/cloud/firestore_service.dart';
import 'package:stock_app/models/create_plc_response_model.dart';
import 'package:stock_app/models/login_response.dart';
import 'package:stock_app/models/machine_model.dart';
import 'package:stock_app/models/product_model.dart';
import 'package:stock_app/models/shelf_model.dart';

import '../../models/auth_model.dart';

class FirebaseServiceNotifier extends ChangeNotifier {
  final _auth = AuthService.instance;
  final _firestore = FirestoreService.instance;

  Future<LoginResponseModel> loginUser(AuthModel model) async {
    return await _auth!.authLogin(model);
  }

  Future getStores() async {
    return await _firestore!.getAllStores();
  }

  Future getStoreNames() async {
    return await _firestore!.getStoreNamesForListTile();
  }

  Future createNewStore(String newStoreName) async {
    return await _firestore!.createNewStore(newStoreName);
  }

  Future deleteStore(String storeName) async {
    return await _firestore!.deleteStore(storeName);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStoreNameStream() {
    return _firestore!.getStoreNameStream();
  }

  Future getShelfs(storeName) async {
    return await _firestore!.getShelfs(storeName);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getShelfsListener(
      String storeName) {
    return _firestore!.getShelfsListener(storeName);
  }

  Future<CreatePLCResponse> createPLCMachine(MachineModel model) async {
    return await _firestore!.createMachine(model);
  }

  Future<List<MachineModel>> getMachines() async {
    return await _firestore!.getMachines();
  }

  Stream getMachineStream() {
    return _firestore!.getMachineStream();
  }

  Future deleteMachine(MachineModel model) async {
    return await _firestore!.deleteMachine(model);
  }

  Future updateMachine(MachineModel newModel) async {
    return await _firestore!.updateMachine(newModel);
  }

  Future<List<String>> getMachineNames(String storeName) async {
    return await _firestore!.getMachineNames(storeName);
  }

  Future getSingleMachine(String storeName, String machineName) async {
    return await _firestore!.getSingleMachine(storeName, machineName);
  }

  Future getShelfList(String storeName) async {
    return await _firestore!.getShelfListName(storeName);
  }

  Future getProducts(String storeName, String shelfName) async {
    return await _firestore!.getProducts(storeName, shelfName);
  }

  Future createNewProduct(
      String storeName, String shelfName, ProductModel model) async {
    return await _firestore!.createNewProduct(storeName, shelfName, model);
  }

  Future createNewShelf(String storeName, ShelfModel shelf) async {
    return await _firestore!.createNewShelf(storeName, shelf);
  }

  Future searchFirebase(String storeName, String filterName) async {
    return await _firestore!.searchFirebase(storeName, filterName);
  }

  Future updateProduct(String storeName, ProductModel model) async {
    return await _firestore!.updateProduct(storeName, model);
  }
}

final firebaseProvider = ChangeNotifierProvider<FirebaseServiceNotifier>((ref) {
  return FirebaseServiceNotifier();
});
