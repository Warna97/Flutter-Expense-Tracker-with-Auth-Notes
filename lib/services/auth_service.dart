import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email Sign Up
  Future<User?> signUpWithEmail(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // Email Sign In
  Future<User?> signInWithEmail(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // Google Sign In
  Future<User?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn.standard().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  // Google Sign Up (same flow as sign in for Firebase Auth)
  Future<User?> signUpWithGoogle() async {
    return signInWithGoogle();
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn.standard().signOut();
  }

  // Current User
  User? get currentUser => _auth.currentUser;
}
