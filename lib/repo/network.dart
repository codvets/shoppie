import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/models/message.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shoppie_user.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:path/path.dart';

class Network {
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  String get uid => firebaseAuth.currentUser!.uid;

  CollectionReference get cartRef => firestore
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .collection("cart");
  CollectionReference get favorizeProductsRef => firestore
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .collection("favorizedProducts");

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
    final productImageUrl = await uploadImage(
        image: productImage,
        reference: "products/${product.sellerId}/${product.id}");
    product.image = productImageUrl;
    await firestore.collection("products").doc(id).set(product.toJson());
  }

  Future<String> uploadImage(
      {required File image, required String reference}) async {
    final storageReference = storage.ref(reference);

    TaskSnapshot uploadTask = await storageReference.putFile(image);
    final String url = await uploadTask.ref.getDownloadURL();

    print(url);

    return url;
  }

  Future<List<Product>> getProducts(Category category) async {
    String cat = getCategoryInString(category);
    try {
      final querySnapshot = await firestore
          .collection("products")
          .where("category", isEqualTo: cat)
          .get();
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

  String getCategoryInString(Category category) {
    switch (category) {
      case Category.shoes:
        return "Shoes";
      case Category.clothes:
        return "Clothes";
      case Category.pants:
        return "Pants";
      case Category.shirts:
        return "Shirts";
    }
  }

  Future<void> favorizeProduct(Product product, String uid) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection("favorizedProducts")
          .doc(product.id)
          .set(product.toJson());
    } catch (e) {}
  }

  Future<void> addToCart(Product product, String uid) async {
    final data = product.toJson();
    data["isPurchased"] = false;
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("cart")
          .doc(product.id)
          .set(data);
    } on FirebaseException catch (error, stk) {
      throw error;
    }
  }

  Future<void> deleteProductFromCart({required String productId}) async {
    await firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .doc(productId)
        .delete();
  }

  Stream<List<Product>> getCartProducts(String uid) {
    try {
      return firestore
          .collection("users")
          .doc(uid)
          .collection("cart")
          .where("isPurchased", isEqualTo: false)
          .snapshots()
          .map((event) {
        final List<Product> products = List.empty(growable: true);

        for (final doc in event.docs) {
          final product = Product.fromJson(doc.data());
          products.add(product);
        }
        return products;
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> buyProductsFromCart(List<Product> products) async {
    products.forEach((product) {
      cartRef.doc(product.id).update({
        "isPurchased": true,
        "quantity": product.quantity,
      });
    });
  }

  Future<String> updateProfile(String name, File image) async {
    final imageUrl = await uploadImage(
        image: image,
        reference:
            "profilePhotos/${firebaseAuth.currentUser!.uid}/${basename(image.path)}");

    await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"image": imageUrl, "name": name});
    return imageUrl;
  }

  Future<String?> getChatId({required String sellerId}) async {
    final chatDoc = await firestore
        .collection("chats")
        .doc(sellerId + firebaseAuth.currentUser!.uid)
        .get();

    if (!chatDoc.exists) {
      await firestore
          .collection("chats")
          .doc(sellerId + firebaseAuth.currentUser!.uid)
          .set({
        "creationTime": DateTime.now(),
        "lastUpdatedTime": DateTime.now(),
        "members": {
          sellerId: true,
          firebaseAuth.currentUser!.uid: true,
        }
      });
    }

    return sellerId + firebaseAuth.currentUser!.uid;
  }

  Future<void> sendMessage(Message message, String chatId) async {
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection("messages")
        .add(message.toJson());
  }
}


/*

  {
    id: chatIdadkflj2lfj,
    creationTime: Date,
    lastUpdatedTime: Date,
    members: {
*buyer Id*      "asjdfklj3lk2j23lk": true,
*seller Id*      "asfjklj2lkj32lkfjkl23jf": true
    }
  }

*/