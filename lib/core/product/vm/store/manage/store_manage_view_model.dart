import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/riverpod/firebase_riverpod.dart';

class StoreManageViewModel {
  late TextEditingController createStoreController;

  void dispseContorller() {
    createStoreController.dispose();
  }

  void initalizeContorller() {
    createStoreController = TextEditingController();
  }

  Future createNewStore(WidgetRef ref, String name) async {
    return await ref.read(firebaseProvider.notifier).createNewStore(name);
  }

  Future<List<String>> getStoreNames(WidgetRef ref) async {
    List<String> response =
        await ref.read(firebaseProvider.notifier).getStoreNames();
    return response;
  }

   setStoreNameList(snapshot) {
    return snapshot.data!.docs.map((doc) => doc.data()['storeName']).toList();
  }

  Future deleteStore(WidgetRef ref, storeName) async {
    return await ref.read(firebaseProvider.notifier).deleteStore(storeName);
  }
}
