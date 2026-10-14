import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/formatters.dart';
import '../../models/investment_plan_model.dart';

class RoiCalculatorWidget extends StatefulWidget {
  final RoiCalculationResult? calculationResult;
  final Function(double amount, double rate, int years) onCalculate;

  const RoiCalculatorWidget({
    super.key,
    required this.calculationResult,
    required this.onCalculate,
  });

  @override
  State<RoiCalculatorWidget> createState() => _RoiCalculatorWidgetState();
}

class _RoiCalculatorWidgetState extends State<RoiCalculatorWidget> {
  double _amount = 1000000;
  final double _rate = 20.0;
  int _years = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calculate_rounded, color: AppColors.primaryGold, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.roiCalculator,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'احسب تقدير أرباحك وعائد الإيجار التراكمي',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Amount Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('مبلغ الاستثمار:', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(
                Formatters.formatEGP(_amount),
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGold),
              ),
            ],
          ),
          Slider(
            value: _amount,
            min: 200000,
            max: 10000000,
            divisions: 98,
            activeColor: AppColors.primaryGold,
            onChanged: (val) {
              setState(() => _amount = val);
              widget.onCalculate(_amount, _rate, _years);
            },
          ),
          const SizedBox(height: 12),

          // Duration Selector
          const Text('فترة الاستثمار بالسنوات:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [1, 3, 5, 7, 10].map((y) {
              final isSelected = _years == y;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('$y سنين'),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _years = y);
                      widget.onCalculate(_amount, _rate, _years);
                    },
                    selectedColor: AppColors.primaryGold,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondaryLight,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Calculation Result Box
          if (widget.calculationResult != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryGold.withValues(alpha: 0.15),
                    AppColors.primaryGold.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('إجمالي الأرباح المتوقعة:', style: TextStyle(fontSize: 13)),
                      Text(
                        Formatters.formatEGP(widget.calculationResult!.totalEstimatedProfit),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('متوسط الدخل الشهري المقدر:', style: TextStyle(fontSize: 13)),
                      Text(
                        Formatters.formatEGP(widget.calculationResult!.monthlyEstimatedReturn),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGoldDark,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'إجمالي المحفظة عند الاسترداد:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Formatters.formatEGP(widget.calculationResult!.totalMaturityAmount),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
