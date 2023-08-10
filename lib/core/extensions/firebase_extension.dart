import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseExtension on dynamic {
  static get firebaseAuth => FirebaseAuth.instance;
  static get firestore => FirebaseFirestore.instance;

  static get storeCollection => 'stores';
  static get storeName => 'storeName';
  static get shelfCollection => 'shelfs';
  static get machineCollection => 'machines';
  static get shelfName => "shelfName";
  static get productCollection => "products";
  static get productName => "productName";
  static get barcodeName => "barcode";
}
