import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/formatters.dart';
import '../models/investment_plan_model.dart';
import '../presenters/investment_presenter.dart';
import 'investment_contract.dart';
import 'widgets/roi_calculator_widget.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen>
    implements InvestmentViewContract {
  late final InvestmentPresenter _presenter;

  bool _isLoading = true;
  String? _errorMessage;
  List<InvestmentPlanModel> _plans = [];
  RoiCalculationResult? _roiResult;

  @override
  void initState() {
    super.initState();
    _presenter = InvestmentPresenter();
    _presenter.attachView(this);
    _presenter.loadInvestmentPlans();
  }

  @override
  void dispose() {
    _presenter.detachView();
    super.dispose();
  }

  // MVP View Contract Implementation
  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showInvestmentPlans(List<InvestmentPlanModel> plans) {
    setState(() {
      _plans = plans;
      _errorMessage = null;
    });
  }

  @override
  void showRoiCalculation(RoiCalculationResult result) {
    setState(() {
      _roiResult = result;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.investmentTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGold),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 12),
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _presenter.loadInvestmentPlans(),
                child: const Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ROI Calculator
        RoiCalculatorWidget(
          calculationResult: _roiResult,
          onCalculate: (amount, rate, years) {
            _presenter.calculateRoi(amount: amount, annualRate: rate, years: years);
          },
        ),

        const SizedBox(height: 24),

        // Plans Section Title
        const Text(
          'خطط ومحافظ الاستثمار العقاري المتاحة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'عقود استثمارية رسمية موثقة مع إدارة تشغيل وتأجير احترافية',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondaryLight),
        ),
        const SizedBox(height: 16),

        // Investment Plans List
        ..._plans.map((plan) => _buildPlanCard(plan)),
      ],
    );
  }

  Widget _buildPlanCard(InvestmentPlanModel plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.borderDark
              : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  plan.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${plan.expectedAnnualReturnPercentage}% سنوياً',
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            plan.targetSector,
            style: const TextStyle(color: AppColors.primaryGoldDark, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            plan.description,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondaryLight, height: 1.4),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('الحد الأدنى للاكتتاب', style: TextStyle(fontSize: 11, color: AppColors.textSecondaryLight)),
                  const SizedBox(height: 2),
                  Text(
                    Formatters.formatEGP(plan.minInvestment),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('دورية صرف العائد', style: TextStyle(fontSize: 11, color: AppColors.textSecondaryLight)),
                  const SizedBox(height: 2),
                  Text(
                    plan.payoutFrequency,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم اختيار: ${plan.title}، يمكنك استكمال البيانات من صفحة التواصل')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                child: const Text('اشترك الآن', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
