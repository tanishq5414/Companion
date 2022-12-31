import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notesapp/features/auth/repository/firestore_methods.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../apikeys.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseAuthProvider = Provider((ref) => supabase.SupabaseAuth.instance);
final supabaseProvider = Provider((ref) => supabase.SupabaseClient(supabaseApiURL,supabaseApiPublicKey));
final authProvider = Provider((ref) => FirebaseAuth.instance);
final googleSignInProvider = Provider((ref) => GoogleSignIn());
final firestoreProvider = Provider(((ref) => FirebaseFirestore.instance));
