class InvestmentPlanModel {
  final String id;
  final String title;
  final String targetSector;
  final double minInvestment;
  final double expectedAnnualReturnPercentage;
  final int durationYears;
  final String payoutFrequency;
  final String securityGuarantee;
  final String description;

  InvestmentPlanModel({
    required this.id,
    required this.title,
    required this.targetSector,
    required this.minInvestment,
    required this.expectedAnnualReturnPercentage,
    required this.durationYears,
    required this.payoutFrequency,
    required this.securityGuarantee,
    required this.description,
  });
}

class RoiCalculationResult {
  final double principalAmount;
  final double annualReturnRate;
  final int years;
  final double totalEstimatedProfit;
  final double totalMaturityAmount;
  final double monthlyEstimatedReturn;

  RoiCalculationResult({
    required this.principalAmount,
    required this.annualReturnRate,
    required this.years,
    required this.totalEstimatedProfit,
    required this.totalMaturityAmount,
    required this.monthlyEstimatedReturn,
  });
}
