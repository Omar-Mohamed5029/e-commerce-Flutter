import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<String> signInWithGoogle() async{

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  // final AuthResult authResult = await firebaseAuth.signInWithCredential(credential);
  // final FirebaseUser user = authResult.user;
  final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;

  assert(user.email != null);
  assert(user.displayName != null);


}
googleSignOut () async{
  googleSignIn.signOut();
}