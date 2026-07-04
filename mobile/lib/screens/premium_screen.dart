import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final sub = SubscriptionService();

  void buyPremium() {
    setState(() {
      sub.activatePremium();
    });
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
              "Débloquez toutes les fonctionnalités IA",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  onPressed: buyPremium,
                  child: const Text("Activer"),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Annuel"),
                subtitle: const Text("15000 FCFA / an"),
                trailing: ElevatedButton(
                  onPressed: buyPremium,
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
