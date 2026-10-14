import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../properties/models/property_model.dart';

class CategoryChipsWidget extends StatelessWidget {
  final Function(PropertyType) onCategorySelected;

  const CategoryChipsWidget({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'سكني فاخر',
        'icon': Icons.apartment_rounded,
        'type': PropertyType.residential,
      },
      {
        'title': 'تجاري ومحلات',
        'icon': Icons.storefront_rounded,
        'type': PropertyType.commercial,
      },
      {
        'title': 'مكاتب إدارية',
        'icon': Icons.business_center_rounded,
        'type': PropertyType.administrative,
      },
      {
        'title': 'شاليهات وساحلي',
        'icon': Icons.beach_access_rounded,
        'type': PropertyType.coastal,
      },
      {
        'title': 'مراكز طبية',
        'icon': Icons.local_hospital_rounded,
        'type': PropertyType.medical,
      },
    ];

    return SizedBox(
      height: 94,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          final type = item['type'] as PropertyType;

          return GestureDetector(
            onTap: () => onCategorySelected(type),
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: AppColors.primaryGold,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
