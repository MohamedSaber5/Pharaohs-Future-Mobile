import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../models/property_model.dart';
import '../presenters/property_list_presenter.dart';
import '../repositories/mock_property_repository.dart';
import 'property_details_screen.dart';
import 'property_list_contract.dart';
import 'widgets/property_card_widget.dart';

class PropertyListScreen extends StatefulWidget {
  final PropertyType? initialType;

  const PropertyListScreen({super.key, this.initialType});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen>
    implements PropertyListViewContract {
  late final PropertyListPresenter _presenter;
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  List<PropertyModel> _properties = [];
  PropertyType? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    // Instantiate presenter with repository (Dependency Injection ready)
    _presenter = PropertyListPresenter(MockPropertyRepository());
    _presenter.attachView(this);
    _presenter.loadProperties(type: _selectedType);
  }

  @override
  void dispose() {
    _presenter.detachView();
    _searchController.dispose();
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
  void showProperties(List<PropertyModel> properties) {
    setState(() {
      _properties = properties;
      _errorMessage = null;
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
          AppStrings.navProperties,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => _presenter.searchProperties(val),
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryGold),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _presenter.searchProperties('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Horizontal Filter Chips
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip(label: 'الكل', type: null),
                _buildFilterChip(label: 'سكني', type: PropertyType.residential),
                _buildFilterChip(label: 'تجاري', type: PropertyType.commercial),
                _buildFilterChip(label: 'إداري', type: PropertyType.administrative),
                _buildFilterChip(label: 'ساحلي', type: PropertyType.coastal),
                _buildFilterChip(label: 'طبي', type: PropertyType.medical),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Content Area
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required String label, required PropertyType? type}) {
    final isSelected = _selectedType == type;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            _selectedType = type;
          });
          _presenter.filterByType(type);
        },
        selectedColor: AppColors.primaryGold,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondaryLight,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 13,
        ),
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primaryGold : AppColors.borderLight,
          ),
        ),
      ),
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
                onPressed: () => _presenter.loadProperties(type: _selectedType),
                child: const Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.apartment_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text(
              'لا توجد عقارات مطابقة للبحث حالياً',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: _properties.length,
      itemBuilder: (context, index) {
        final property = _properties[index];
        return PropertyCardWidget(
          property: property,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PropertyDetailsScreen(propertyId: property.id),
              ),
            );
          },
        );
      },
    );
  }
}
