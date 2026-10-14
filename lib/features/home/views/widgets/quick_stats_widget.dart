import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/home_data_model.dart';

class QuickStatsWidget extends StatelessWidget {
  final CompanyStatsModel stats;

  const QuickStatsWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.borderDark
              : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(context, stats.totalInvestmentsEGP, 'حجم الاستثمارات'),
          _buildDivider(),
          _buildItem(context, stats.totalUnitsDelivered, 'وحدة مسلمة'),
          _buildDivider(),
          _buildItem(context, stats.happyClients, 'عميل مستثمر'),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.borderLight,
    );
  }
}
