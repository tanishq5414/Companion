import 'package:companion/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;


final authProvider = Provider((ref) => FirebaseAuth.instance);
final userProvider = Provider((ref) => supabase.SupabaseClient(supabaseApiURL,supabaseApiPublicKey));
