enum PropertyType { residential, commercial, administrative, coastal, medical }

class PropertyModel {
  final String id;
  final String title;
  final String developerName;
  final String compoundName;
  final String location;
  final double totalPrice;
  final double downPayment;
  final int installmentYears;
  final double monthlyInstallment;
  final double areaSqM;
  final int bedrooms;
  final int bathrooms;
  final int deliveryYear;
  final PropertyType type;
  final String imageUrl;
  final List<String> galleryImages;
  final String description;
  final bool isFeatured;
  final double expectedRoiPercentage;

  PropertyModel({
    required this.id,
    required this.title,
    required this.developerName,
    required this.compoundName,
    required this.location,
    required this.totalPrice,
    required this.downPayment,
    required this.installmentYears,
    required this.monthlyInstallment,
    required this.areaSqM,
    required this.bedrooms,
    required this.bathrooms,
    required this.deliveryYear,
    required this.type,
    required this.imageUrl,
    required this.galleryImages,
    required this.description,
    this.isFeatured = false,
    this.expectedRoiPercentage = 15.0,
  });

  String get typeNameArabic {
    switch (type) {
      case PropertyType.residential:
        return 'سكني فاخر';
      case PropertyType.commercial:
        return 'تجاري & محلات';
      case PropertyType.administrative:
        return 'مكاتب إدارية';
      case PropertyType.coastal:
        return 'شاليه ساحلي';
      case PropertyType.medical:
        return 'عيادات ومراكز طبية';
    }
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      developerName: json['developerName'] ?? '',
      compoundName: json['compoundName'] ?? '',
      location: json['location'] ?? '',
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      downPayment: (json['downPayment'] as num?)?.toDouble() ?? 0.0,
      installmentYears: json['installmentYears'] ?? 0,
      monthlyInstallment: (json['monthlyInstallment'] as num?)?.toDouble() ?? 0.0,
      areaSqM: (json['areaSqM'] as num?)?.toDouble() ?? 0.0,
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      deliveryYear: json['deliveryYear'] ?? 2026,
      type: PropertyType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PropertyType.residential,
      ),
      imageUrl: json['imageUrl'] ?? '',
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      description: json['description'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      expectedRoiPercentage: (json['expectedRoiPercentage'] as num?)?.toDouble() ?? 15.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'developerName': developerName,
      'compoundName': compoundName,
      'location': location,
      'totalPrice': totalPrice,
      'downPayment': downPayment,
      'installmentYears': installmentYears,
      'monthlyInstallment': monthlyInstallment,
      'areaSqM': areaSqM,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'deliveryYear': deliveryYear,
      'type': type.name,
      'imageUrl': imageUrl,
      'galleryImages': galleryImages,
      'description': description,
      'isFeatured': isFeatured,
      'expectedRoiPercentage': expectedRoiPercentage,
    };
  }
}
