import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/home/view/home_view.dart';
import 'package:gout_app/view/login/view/login_view.dart';

class FirebaseAuthController extends GetxController {
  static FirebaseAuthController get instance => Get.find();

  final firestoreController = Get.put(FirebaseFirestoreController());
  final box = GetStorage();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => HomeView());
      box.write("userUID", user.uid);
    } else {
      Get.offAll(() => LoginView());
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String name, String email, String password, String nickname) async {
    try {

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => HomeView())
          : Get.to(() => LoginView());
       firestoreController.createAnUser(name, email, password, nickname);
    
    } on FirebaseAuthException catch (e) {
      errorSnackbar("FirebaseAuthController, createUserERROR: ", "$e");
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorSnackbar("FirebaseAuthController, loginUserERROR: ", "$e");
    }
    return null;
  }

  Future<void> signOut() async => await _auth.signOut();

}
