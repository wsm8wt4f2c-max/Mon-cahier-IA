import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String baseUrl = "https://ton-backend.com"; 
  // on remplacera plus tard par vrai backend

  Future<String> generateLesson({
    required String classe,
    required String discipline,
    required String lecon,
    required String duree,
  }) async {

    final response = await http.post(
      Uri.parse("$baseUrl/ai/generate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "classe": classe,
        "discipline": discipline,
        "lecon": lecon,
        "duree": duree,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["result"];
    } else {
      return "Erreur IA";
    }
  }
}
