import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../properties/repositories/mock_property_repository.dart';
import '../../properties/views/property_details_screen.dart';
import '../../properties/views/property_list_screen.dart';
import '../../properties/views/widgets/property_card_widget.dart';
import '../models/home_data_model.dart';
import '../presenters/home_presenter.dart';
import 'home_contract.dart';
import 'widgets/category_chips_widget.dart';
import 'widgets/hero_banner_widget.dart';
import 'widgets/quick_stats_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(int tabIndex)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeViewContract {
  late final HomePresenter _presenter;

  bool _isLoading = true;
  String? _errorMessage;
  HomeDataModel? _homeData;

  @override
  void initState() {
    super.initState();
    _presenter = HomePresenter(MockPropertyRepository());
    _presenter.attachView(this);
    _presenter.loadHomeData();
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
  void showHomeData(HomeDataModel data) {
    setState(() {
      _homeData = data;
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
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.account_balance, color: AppColors.primaryGold, size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGold,
                  ),
                ),
                Text(
                  AppStrings.appSubtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('لا توجد إشعارات جديدة حالياً')),
              );
            },
          ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGold),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _presenter.loadHomeData(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    final data = _homeData!;

    return RefreshIndicator(
      color: AppColors.primaryGold,
      onRefresh: () => _presenter.loadHomeData(),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [
          // Hero Banner
          HeroBannerWidget(
            banners: data.banners,
            onExplore: () {
              widget.onNavigateToTab?.call(1); // switch to properties tab
            },
          ),

          // Company Stats
          QuickStatsWidget(stats: data.stats),

          // Categories Title
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Text(
              AppStrings.exploreCategories,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Category Chips
          CategoryChipsWidget(
            onCategorySelected: (type) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PropertyListScreen(initialType: type),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Featured Properties Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.featuredProjects,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    widget.onNavigateToTab?.call(1);
                  },
                  child: const Row(
                    children: [
                      Text(AppStrings.viewAll, style: TextStyle(color: AppColors.primaryGold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.primaryGold),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Featured Property Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: data.featuredProperties.map((property) {
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
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
