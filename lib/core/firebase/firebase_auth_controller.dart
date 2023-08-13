import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/home/view/home_view.dart';
import 'package:gout_app/view/login/view/login_view.dart';

class FirebaseAuthController extends GetxController {

  static FirebaseAuthController get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => LoginView()) : Get.offAll(() => HomeView());
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => HomeView())
          : Get.to(() => LoginView());
    } on FirebaseAuthException catch (e) {
      errorSnackbar(
        "FirebaseAuthController, createUserERROR: ", "$e"
        
        );
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorSnackbar("FirebaseAuthController, loginUserERROR: ", "$e");
    }
  }

  Future<void> signOut() async => await _auth.signOut();
}
