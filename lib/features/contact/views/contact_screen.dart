import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../models/inquiry_model.dart';
import '../presenters/contact_presenter.dart';
import 'contact_contract.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    implements ContactViewContract {
  late final ContactPresenter _presenter;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _budgetController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedLocation = 'العاصمة الإدارية الجديدة';
  String _selectedType = 'سكني فاخر';
  bool _isLoading = false;

  final List<String> _locations = [
    'العاصمة الإدارية الجديدة',
    'التجمع الخامس - القاهرة الجديدة',
    'الساحل الشمالي - رأس الحكمة',
    'الشيخ زايد وأكتوبر',
    'مدينة المستقبل الشروق',
  ];

  final List<String> _types = [
    'سكني فاخر',
    'تجاري ومحلات',
    'مكاتب إدارية',
    'شاليهات وفلل ساحلية',
    'عيادات ومراكز طبية',
  ];

  @override
  void initState() {
    super.initState();
    _presenter = ContactPresenter();
    _presenter.attachView(this);
  }

  @override
  void dispose() {
    _presenter.detachView();
    _nameController.dispose();
    _phoneController.dispose();
    _budgetController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // MVP View Contract Implementation
  @override
  void showLoading() {
    setState(() => _isLoading = true);
  }

  @override
  void hideLoading() {
    setState(() => _isLoading = false);
  }

  @override
  void showSubmissionSuccess() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.verified, color: AppColors.success),
            SizedBox(width: 8),
            Text('تم استلام طلبكم'),
          ],
        ),
        content: const Text(AppStrings.inquirySuccess),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _nameController.clear();
              _phoneController.clear();
              _budgetController.clear();
              _notesController.clear();
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.navContact,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: AppColors.royalDarkGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.contactTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGoldLight,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      AppStrings.contactSubtitle,
                      style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Full Name
              const Text(AppStrings.fullName, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'مثال: محمد أحمد',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number
              const Text(AppStrings.phoneNumber, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '010XXXXXXXX',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Preferred Location
              const Text(AppStrings.preferredArea, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedLocation,
                items: _locations.map((loc) {
                  return DropdownMenuItem(value: loc, child: Text(loc));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedLocation = val);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Property Type
              const Text('نوع العقار المطلوب', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                items: _types.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedType = val);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.apartment_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Budget
              const Text('الميزانية التقريبية (ج.م)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'مثال: 3,000,000',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Notes
              const Text(AppStrings.message, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'أي تفاصيل أخرى ترغب في الاستفسار عنها...',
                ),
              ),
              const SizedBox(height: 28),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          final inquiry = InquiryModel(
                            fullName: _nameController.text,
                            phone: _phoneController.text,
                            preferredLocation: _selectedLocation,
                            propertyType: _selectedType,
                            budgetEGP: double.tryParse(_budgetController.text) ?? 0.0,
                            notes: _notesController.text,
                          );
                          _presenter.submitInquiry(inquiry);
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : const Text(AppStrings.submitInquiry, style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),

              // Direct Call & WhatsApp row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الاتصال بالخط الساخن: 19XXX')),
                        );
                      },
                      icon: const Icon(Icons.headset_mic_outlined, color: AppColors.primaryGold),
                      label: const Text('الخط الساخن'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppColors.primaryGold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('جاري فتح تطبيق WhatsApp...')),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline, color: AppColors.success),
                      label: const Text('واتساب مباشر', style: TextStyle(color: AppColors.success)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppColors.success),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
