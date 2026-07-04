import 'package:flutter/material.dart';
import '../services/subscription_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final SubscriptionService sub = SubscriptionService();

  void activatePremium(String plan) async {
  final response = await http.post(
    Uri.parse("http://localhost:3000/api/payment/subscribe"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "userId": "demo_user",
      "plan": plan,
    }),
  );

  if (response.statusCode == 200) {
    setState(() {
      sub.activatePremium();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("🎉 Paiement réussi")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Premium")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Débloquez toute la puissance de l’IA",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text("Essai gratuit"),
                subtitle: Text("${sub.trialDaysLeft} jours restants"),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text("Mensuel"),
                subtitle: const Text("2000 FCFA / mois"),
                trailing: ElevatedButton(
                  onPressed: () => activatePremium("monthly"),
                  child: const Text("Activer"),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Annuel"),
                subtitle: const Text("15000 FCFA / an"),
                trailing: ElevatedButton(
                onPressed: () => activatePremium("yearly"),
                  child: const Text("Activer"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
