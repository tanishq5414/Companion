import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/components/advertisment.dart';
import 'package:notesapp/modal/advertisment.dart';
import '../../modal/courses_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetAdvertisment{
  final advertismentDataJson =
        'https://tanishq5414.github.io/apiNotesApp/advert.json';
  Future<List<Advertisment>> getAdvertisment() async {
    final response = await http.get(Uri.parse(advertismentDataJson));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((advertisment) => Advertisment.fromJson(advertisment)).toList();
    } else {
      throw Exception('Failed to load courses from API');
    }
  }
}
final advertismentProvider = Provider<GetAdvertisment>((ref) => GetAdvertisment());
