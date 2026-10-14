import '../../properties/models/property_model.dart';

class HomeBannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String actionLabel;

  HomeBannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.actionLabel,
  });
}

class CompanyStatsModel {
  final String totalUnitsDelivered;
  final String totalInvestmentsEGP;
  final String happyClients;
  final String activeProjects;

  CompanyStatsModel({
    required this.totalUnitsDelivered,
    required this.totalInvestmentsEGP,
    required this.happyClients,
    required this.activeProjects,
  });
}

class HomeDataModel {
  final List<HomeBannerModel> banners;
  final List<PropertyModel> featuredProperties;
  final CompanyStatsModel stats;

  HomeDataModel({
    required this.banners,
    required this.featuredProperties,
    required this.stats,
  });
}
