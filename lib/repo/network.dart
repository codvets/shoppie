import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shoppie_user.dart';

class Network {
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<ShoppieUser> checkCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    try {
      if (firebaseUser != null) {
        print(firebaseUser.uid);
        final documentSnapshot =
            await firestore.collection("users").doc(firebaseUser.uid).get();

        if (documentSnapshot.exists) {
          final data = documentSnapshot.data();
          print("USER DATA FROM FIRESTORE ${data}");
          final shoppieUser =
              ShoppieUser.fromJson(data!, uid: firebaseUser.uid);
          return shoppieUser;
        }
        throw FirebaseException(
            plugin: "Firestore",
            code: "no-data-found",
            message: "No data was found in database");
      }
      throw FirebaseException(
          plugin: "FirebaseAuth",
          code: 'no-user-logged',
          message: "No user was logged in.");
    } on FirebaseException catch (error, stk) {
      throw error;
    }
  }

  Future<ShoppieUser> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCreds = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final userSnapshot =
          await firestore.collection("users").doc(userCreds.user!.uid).get();

      final data = userSnapshot.data()!;

      return ShoppieUser.fromJson(data, uid: userCreds.user!.uid);
    } on FirebaseAuthException catch (error, stk) {
      print('An error occured during sign in: $error \n Stacktrace: $stk');
      throw FirebaseAuthException(code: error.code, message: error.message);
    }
  }

  Future<ShoppieUser> register(
      {required ShoppieUser user, required String password}) async {
    try {
      final UserCredential creds =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: password);
      user.uid = creds.user!.uid;
      await firestore
          .collection("users")
          .doc(creds.user!.uid)
          .set(user.toJson());
      return user;
    } on FirebaseException catch (error, stk) {
      throw FirebaseException(plugin: "Firebase", message: "Error: $error");
    }
  }

  Future<void> uploadProduct(Product product, File productImage) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    product.id = id;
    final productImageUrl =
        await uploadProductImage(image: productImage, product: product);
    product.image = productImageUrl;
    await firestore.collection("products").doc(id).set(product.toJson());
  }

  Future<String> uploadProductImage(
      {required File image, required Product product}) async {
    final storageReference =
        storage.ref("products/${product.sellerId}/${product.id}");

    TaskSnapshot uploadTask = await storageReference.putFile(image);
    final String url = await uploadTask.ref.getDownloadURL();

    print(url);

    return url;
  }

  Future<List<Product>> getProducts() async {
    try {
      final querySnapshot = await firestore.collection("products").get();
      print(querySnapshot.size);
      List<Product> products = List.empty(growable: true);

      querySnapshot.docs.forEach((doc) {
        final data = doc.data();

        final product = Product.fromJson(data);
        products.add(product);
      });
      return products;
    } on FirebaseException catch (error, stk) {
      //
      throw error;
    }
  }
}
