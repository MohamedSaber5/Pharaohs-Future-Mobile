import '../models/investment_plan_model.dart';

abstract class InvestmentViewContract {
  void showLoading();
  void hideLoading();
  void showInvestmentPlans(List<InvestmentPlanModel> plans);
  void showRoiCalculation(RoiCalculationResult result);
  void showError(String message);
}

abstract class InvestmentPresenterContract {
  void attachView(InvestmentViewContract view);
  void detachView();
  void loadInvestmentPlans();
  void calculateRoi({required double amount, required double annualRate, required int years});
}
