import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final SubscriptionService sub = SubscriptionService();

  void activatePremium() {
    setState(() {
      sub.activatePremium();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🎉 Premium activé avec succès"),
      ),
    );
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
                  onPressed: activatePremium,
                  child: const Text("Activer"),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Annuel"),
                subtitle: const Text("15000 FCFA / an"),
                trailing: ElevatedButton(
                  onPressed: activatePremium,
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
