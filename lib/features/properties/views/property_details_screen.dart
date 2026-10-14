import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/formatters.dart';
import '../models/property_model.dart';
import '../presenters/property_details_presenter.dart';
import '../repositories/mock_property_repository.dart';
import 'property_details_contract.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailsScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen>
    implements PropertyDetailsViewContract {
  late final PropertyDetailsPresenter _presenter;

  bool _isLoading = true;
  PropertyModel? _property;

  @override
  void initState() {
    super.initState();
    _presenter = PropertyDetailsPresenter(MockPropertyRepository());
    _presenter.attachView(this);
    _presenter.loadPropertyDetails(widget.propertyId);
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
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showPropertyDetails(PropertyModel property) {
    setState(() {
      _property = property;
    });
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  void showBookingSuccessMessage() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success),
            SizedBox(width: 8),
            Text('تم تسجيل الموعد بنجاح'),
          ],
        ),
        content: const Text(
          'شكراً لثقتكم في مستقبل الفراعنة. سيقوم مستشارك العقاري بالتواصل معك خلال دقائق لتأكيد الموعد وإرسال الموقع الدقيق.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGold),
        ),
      );
    }

    if (_property == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('العقار غير متوفر حالياً'),
        ),
      );
    }

    final p = _property!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver AppBar with Image Gallery
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    p.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.secondaryNavy,
                      child: const Center(
                        child: Icon(Icons.apartment, size: 80, color: AppColors.primaryGold),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type and Compound
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryGold),
                        ),
                        child: Text(
                          p.typeNameArabic,
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        p.compoundName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    p.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primaryGold, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          p.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Specifications Grid
                  Container(
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
                        _buildSpecCell(
                          icon: Icons.square_foot,
                          title: AppStrings.area,
                          value: Formatters.formatArea(p.areaSqM),
                        ),
                        if (p.bedrooms > 0)
                          _buildSpecCell(
                            icon: Icons.king_bed_outlined,
                            title: AppStrings.bedrooms,
                            value: '${p.bedrooms}',
                          ),
                        if (p.bathrooms > 0)
                          _buildSpecCell(
                            icon: Icons.bathtub_outlined,
                            title: AppStrings.bathrooms,
                            value: '${p.bathrooms}',
                          ),
                        _buildSpecCell(
                          icon: Icons.calendar_today_outlined,
                          title: AppStrings.deliveryYear,
                          value: '${p.deliveryYear}',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Plan Cards
                  const Text(
                    'خطة السداد والتسهيلات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFinancialCard(
                          title: AppStrings.price,
                          value: Formatters.formatEGP(p.totalPrice),
                          highlight: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFinancialCard(
                          title: AppStrings.downPayment,
                          value: Formatters.formatEGP(p.downPayment),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFinancialCard(
                          title: AppStrings.installment,
                          value: '${Formatters.formatEGP(p.monthlyInstallment)} / شهر',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFinancialCard(
                          title: 'مدة التقسيط',
                          value: '${p.installmentYears} ${AppStrings.years}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'عن المشروع والوحدة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 100), // spacing for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _presenter.requestTourAppointment(p.id, '01000000000');
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text(AppStrings.requestTour),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filledTonal(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري فتح محادثة واتساب...')),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.success.withValues(alpha: 0.15),
                foregroundColor: AppColors.success,
                padding: const EdgeInsets.all(14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecCell({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryGold, size: 24),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondaryLight),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFinancialCard({
    required String title,
    required String value,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primaryGold.withValues(alpha: 0.1)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight ? AppColors.primaryGold : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: highlight ? AppColors.primaryGoldDark : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: highlight ? AppColors.primaryGoldDark : null,
            ),
          ),
        ],
      ),
    );
  }
}
