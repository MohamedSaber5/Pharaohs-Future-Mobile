import '../models/investment_plan_model.dart';
import '../views/investment_contract.dart';

class InvestmentPresenter implements InvestmentPresenterContract {
  InvestmentViewContract? _view;

  @override
  void attachView(InvestmentViewContract view) {
    _view = view;
  }

  @override
  void detachView() {
    _view = null;
  }

  @override
  Future<void> loadInvestmentPlans() async {
    _view?.showLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 250));

      final plans = [
        InvestmentPlanModel(
          id: 'plan-1',
          title: 'صندوق الاستثمار التجاري بالعاصمة',
          targetSector: 'مولات تجارية ومطاعم',
          minInvestment: 500000,
          expectedAnnualReturnPercentage: 22.0,
          durationYears: 5,
          payoutFrequency: 'ربع سنوي (كل 3 أشهر)',
          securityGuarantee: 'عقد إيجار إلزامي مسجل بالشهر العقاري',
          description: 'امتلك حصة في محلات ومساحات تجارية مؤجرة لتوكيلات عالمية بعائد دوري مضمون وإعادة بيع بربح رأسمالي مجزي.',
        ),
        InvestmentPlanModel(
          id: 'plan-2',
          title: 'محفظة الأبراج الإدارية (CBD)',
          targetSector: 'مقرات شركات وبنوك',
          minInvestment: 750000,
          expectedAnnualReturnPercentage: 19.5,
          durationYears: 4,
          payoutFrequency: 'نصف سنوي',
          securityGuarantee: 'شيكات مصرفية وإدارة فندقية دولية',
          description: 'استثمار آمن في منطقة المال والأعمال بنظام العائد الدولاري وإمكانية الاسترداد بعد انقضاء المدة التعاقدية.',
        ),
        InvestmentPlanModel(
          id: 'plan-3',
          title: 'خطة الضيافة الفندقية بالساحل الشمالي',
          targetSector: 'شاليهات وفلل فندقية',
          minInvestment: 1000000,
          expectedAnnualReturnPercentage: 25.0,
          durationYears: 3,
          payoutFrequency: 'سنوي في نهاية الموسم الصيفي',
          securityGuarantee: 'عقد إدارة وتشغيل مع سلاسل فندقية',
          description: 'أعلى عائد موسمي في مصر من خلال تأجير الوحدات الفاخرة في رأس الحكمة وسيدي عبد الرحمن.',
        ),
      ];

      _view?.hideLoading();
      _view?.showInvestmentPlans(plans);

      // Default calculation for initial display
      calculateRoi(amount: 1000000, annualRate: 20.0, years: 5);
    } catch (e) {
      _view?.hideLoading();
      _view?.showError('فشل تحميل خطط الاستثمار: $e');
    }
  }

  @override
  void calculateRoi({required double amount, required double annualRate, required int years}) {
    // Simple compound return formula for real estate appreciation + rental yield
    final rateDecimal = annualRate / 100.0;
    final totalProfit = amount * rateDecimal * years;
    final totalMaturity = amount + totalProfit;
    final monthlyReturn = (amount * rateDecimal) / 12.0;

    final result = RoiCalculationResult(
      principalAmount: amount,
      annualReturnRate: annualRate,
      years: years,
      totalEstimatedProfit: totalProfit,
      totalMaturityAmount: totalMaturity,
      monthlyEstimatedReturn: monthlyReturn,
    );

    _view?.showRoiCalculation(result);
  }
}
