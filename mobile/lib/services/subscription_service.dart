class SubscriptionService {
  // simulation locale (sera remplacé par backend + Firebase)
  bool isPremium = false;
  int trialDaysLeft = 3;

  bool canUseAI() {
    return isPremium || trialDaysLeft > 0;
  }

  void activatePremium() {
    isPremium = true;
  }

  void useTrialDay() {
    if (trialDaysLeft > 0) {
      trialDaysLeft--;
    }
  }
}
