import 'package:flutter_test/flutter_test.dart';
import 'package:pharaohs_future/features/investments/models/investment_plan_model.dart';
import 'package:pharaohs_future/features/investments/presenters/investment_presenter.dart';
import 'package:pharaohs_future/features/investments/views/investment_contract.dart';

class MockInvestmentView implements InvestmentViewContract {
  List<InvestmentPlanModel>? plans;
  RoiCalculationResult? calculation;

  @override
  void showLoading() {}

  @override
  void hideLoading() {}

  @override
  void showInvestmentPlans(List<InvestmentPlanModel> plans) {
    this.plans = plans;
  }

  @override
  void showRoiCalculation(RoiCalculationResult result) {
    calculation = result;
  }

  @override
  void showError(String message) {}
}

void main() {
  test('InvestmentPresenter calculates ROI accurately', () {
    final presenter = InvestmentPresenter();
    final view = MockInvestmentView();
    presenter.attachView(view);

    presenter.calculateRoi(amount: 1000000, annualRate: 20.0, years: 5);

    expect(view.calculation, isNotNull);
    expect(view.calculation!.totalEstimatedProfit, 1000000);
    expect(view.calculation!.totalMaturityAmount, 2000000);
  });
}
