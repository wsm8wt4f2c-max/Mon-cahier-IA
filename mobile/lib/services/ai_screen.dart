import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../services/subscription_service.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final TextEditingController classe = TextEditingController();
  final TextEditingController discipline = TextEditingController();
  final TextEditingController lecon = TextEditingController();
  final TextEditingController duree = TextEditingController();

  final AIService ai = AIService();
  final SubscriptionService sub = SubscriptionService();

  String result = "";
  bool loading = false;

  void generate() async {
    if (!sub.canUseAI()) {
      setState(() {
        result = "⛔ Accès bloqué.\nPassez en Premium pour continuer.";
      });
      return;
    }

    setState(() {
      loading = true;
      result = "";
    });

    try {
      final res = await ai.generateLesson(
        classe: classe.text,
        discipline: discipline.text,
        lecon: lecon.text,
        duree: duree.text,
      );

      setState(() {
        result = res;
        loading = false;
      });

      sub.useTrialDay();
    } catch (e) {
      setState(() {
        result = "Erreur IA : $e";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IA Pédagogique")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: classe,
              decoration: const InputDecoration(labelText: "Classe"),
            ),

            TextField(
              controller: discipline,
              decoration: const InputDecoration(labelText: "Discipline"),
            ),

            TextField(
              controller: lecon,
              decoration: const InputDecoration(labelText: "Leçon"),
            ),

            TextField(
              controller: duree,
              decoration: const InputDecoration(labelText: "Durée (min)"),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: loading ? null : generate,
              child: Text(loading ? "Génération..." : "Générer la fiche IA"),
            ),

            const SizedBox(height: 20),

            if (loading) const CircularProgressIndicator(),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
