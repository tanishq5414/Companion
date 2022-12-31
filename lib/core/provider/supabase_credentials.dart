import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCredentials {
  static const String APIKEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpzbmR2YWhvcWxvaHpjaHdhYXN1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzE3Nzc4NDgsImV4cCI6MTk4NzM1Mzg0OH0.x6o4waoAApdztiFhGdtcEyOVlMaFb3ZFxBBwVRUech4";
  static const String APIURL = "https://zsndvahoqlohzchwaasu.supabase.co";

  static SupabaseClient supabaseClient = SupabaseClient(APIURL, APIKEY);
}
