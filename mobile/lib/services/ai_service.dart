import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // ⚠️ Pour l’instant backend fictif (sera remplacé par Node.js)
  final String baseUrl = "http://localhost:3000/api";

  Future<String> generateLesson({
    required String classe,
    required String discipline,
    required String lecon,
    required String duree,
  }) async {
    try {
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
        return data["result"] ?? "Aucune réponse IA";
      } else {
        return "Erreur serveur IA (${response.statusCode})";
      }
    } catch (e) {
      return "Erreur de connexion IA : $e";
    }
  }
}
