import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiUrl = dotenv.env['API_URL']!;

String supabaseApiURL = dotenv.env['SUPABASE_API_URL']!;
String supabaseApiPublicKey = dotenv.env['SUPABASE_API_PUBLIC_KEY']!;
// Endpoint URLs
String coursesUrl = '$apiUrl/getJsonFiles'; // URL for fetching JSON files
String notesUrl = '$apiUrl/getFiles'; // URL for fetching files
String uploadNotesUrl = '$apiUrl/addFile'; // URL for uploading files
String trendingNotesByDayURL = '$apiUrl/getTrendingDay'; // URL for fetching trending notes by day
String trendingNotesByWeekURL = '$apiUrl/getTrendingWeek'; // URL for fetching trending notes by week
String trendingNotesDataURL = '$apiUrl/trending'; // URL for fetching all trending notes
const advertismentURL = 'https://tanishq5414.github.io/apiNotesApp/test1.json'; // URL for advertisements
const wordlistURL = 'https://tanishq5414.github.io/apiNotesApp/english.json'; // URL for wordlist
const privacyPolicyURL = 'https://tanishq5414.github.io/apiNotesApp/privacypolicy.html'; // URL for privacy policy
