import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Constructor ensures Firebase is initialized
  AuthService() {
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
      print("Firebase initialized");
    }
  }

  // Get the current user
  User? get currentUser => _auth.currentUser;

  // Stream of authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign-up method with Firestore integration
  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': '', // Placeholder for name
        'username': '', // Placeholder for username
        'program': '', // Placeholder for program
        'semester': '', // Placeholder for semester
        'contact': '', // Placeholder for contact
        'createdAt': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(msg: "Sign-up successful!", toastLength: Toast.LENGTH_SHORT);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: _getFirebaseErrorMessage(e), toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred.", toastLength: Toast.LENGTH_LONG);
    }
  }

  // Login method with Firestore validation
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if profile is complete
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

        // Check if required fields are incomplete
        bool isProfileIncomplete = data?['name'] == '' ||
            data?['username'] == '' ||
            data?['program'] == '' ||
            data?['semester'] == '' ||
            data?['contact'] == '';

        return isProfileIncomplete; // Returns true if profile is incomplete
      }
      return true; // If no document, consider profile incomplete
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: _getFirebaseErrorMessage(e), toastLength: Toast.LENGTH_LONG);
      return true; // Assume incomplete profile on error
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred.", toastLength: Toast.LENGTH_LONG);
      return true; // Assume incomplete profile on error
    }
  }

  // Sign-out method
  Future<void> signOut() async {
    await _auth.signOut();
    Fluttertoast.showToast(msg: "Signed out successfully.", toastLength: Toast.LENGTH_SHORT);
  }

  // Helper method to provide user-friendly error messages
  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "Invalid email format.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Incorrect password.";
      case 'email-already-in-use':
        return "This email is already in use.";
      case 'weak-password':
        return "The password is too weak.";
      default:
        return "An error occurred: ${e.message}";
    }
  }
}
