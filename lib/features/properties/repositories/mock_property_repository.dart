import '../models/property_model.dart';
import 'property_repository.dart';

class MockPropertyRepository implements PropertyRepository {
  final List<PropertyModel> _properties = [
    PropertyModel(
      id: 'prop-1',
      title: 'شقة فاخرة بإطلالة بانورامية على النهر الأخضر',
      developerName: 'مستقبل الفراعنة للتطوير العقاري',
      compoundName: 'Pharaohs Crown Residence',
      location: 'العاصمة الإدارية الجديدة - R7',
      totalPrice: 4850000,
      downPayment: 485000,
      installmentYears: 8,
      monthlyInstallment: 45400,
      areaSqM: 185,
      bedrooms: 3,
      bathrooms: 3,
      deliveryYear: 2026,
      type: PropertyType.residential,
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80',
      galleryImages: [
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=80',
      ],
      description: 'وحدة سكنية راقية في قلب العاصمة الإدارية تشطيب ألترا سوبر لوكس، مع خدمات فندقية متكاملة، ونادي صحي، ومساحات خضراء شاسعة.',
      isFeatured: true,
      expectedRoiPercentage: 18.5,
    ),
    PropertyModel(
      id: 'prop-2',
      title: 'محل تجاري واجهة مباشرة على الممشى السياحي',
      developerName: 'الفراعنة للاستثمار التجاري',
      compoundName: 'Pharaohs Plaza Mall',
      location: 'التجمع الخامس - شارع التسعين الشمالي',
      totalPrice: 8900000,
      downPayment: 1335000,
      installmentYears: 6,
      monthlyInstallment: 105000,
      areaSqM: 65,
      bedrooms: 0,
      bathrooms: 1,
      deliveryYear: 2025,
      type: PropertyType.commercial,
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
      galleryImages: [
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80',
      ],
      description: 'محل تجاري ذو حركة مرور عالية مناسب للعلامات التجارية العالمية والمطاعم، مع عقد إيجار إلزامي بعائد سنوي يتجاوز 22%.',
      isFeatured: true,
      expectedRoiPercentage: 22.0,
    ),
    PropertyModel(
      id: 'prop-3',
      title: 'مكتب إداري مجهز بالكامل في البرج الأيقوني',
      developerName: 'تحالف الفراعنة للأبراج',
      compoundName: 'CBD Iconic Sky Tower',
      location: 'العاصمة الإدارية - منطقة الأعمال المركزية CBD',
      totalPrice: 6200000,
      downPayment: 620000,
      installmentYears: 7,
      monthlyInstallment: 66400,
      areaSqM: 92,
      bedrooms: 0,
      bathrooms: 2,
      deliveryYear: 2026,
      type: PropertyType.administrative,
      imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1200&q=80',
      galleryImages: [
        'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&w=1200&q=80',
      ],
      description: 'مكتب إداري فئة A في أعلى الأبراج الإدارية بأحدث أنظمة الذكاء الاصطناعي وإدارة المرافق، يوفر عائد إيجاري بالدولار.',
      isFeatured: false,
      expectedRoiPercentage: 19.5,
    ),
    PropertyModel(
      id: 'prop-4',
      title: 'شاليه بحديقة خاصة وحمام سباحة بالساحل الشمالي',
      developerName: 'الفراعنة للتطوير السياحي',
      compoundName: 'Pharaohs Bay Resort',
      location: 'الساحل الشمالي - سيدي عبد الرحمن',
      totalPrice: 7500000,
      downPayment: 750000,
      installmentYears: 8,
      monthlyInstallment: 70300,
      areaSqM: 140,
      bedrooms: 3,
      bathrooms: 2,
      deliveryYear: 2026,
      type: PropertyType.coastal,
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80',
      galleryImages: [
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=1200&q=80',
      ],
      description: 'شاليه يرى البحر مباشرة مع تشطيب كامل والتكييفات في أرقى مناطق سيدي عبد الرحمن، مع إدارة فندقية للإيجار الصيفي المربح.',
      isFeatured: true,
      expectedRoiPercentage: 24.0,
    ),
    PropertyModel(
      id: 'prop-5',
      title: 'عيادة طبية متخصصة ومجهزة بأحدث التجهيزات',
      developerName: 'الفراعنة للرعاية الصحية',
      compoundName: 'Pharaohs Medical Center',
      location: 'الشيخ زايد - محور 26 يوليو',
      totalPrice: 3950000,
      downPayment: 395000,
      installmentYears: 6,
      monthlyInstallment: 49300,
      areaSqM: 60,
      bedrooms: 0,
      bathrooms: 1,
      deliveryYear: 2025,
      type: PropertyType.medical,
      imageUrl: 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=1200&q=80',
      galleryImages: [
        'https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=1200&q=80',
      ],
      description: 'عيادة في مجمع طبي متكامل مع منطقة انتظار مشتركة واستقبال وخدمات تعقيم ومصاعد مخصصة للمرضى.',
      isFeatured: false,
      expectedRoiPercentage: 17.0,
    ),
  ];

  @override
  Future<List<PropertyModel>> getProperties({PropertyType? type, String? query}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    var results = List<PropertyModel>.from(_properties);

    if (type != null) {
      results = results.where((p) => p.type == type).toList();
    }

    if (query != null && query.trim().isNotEmpty) {
      final q = query.toLowerCase().trim();
      results = results.where((p) =>
        p.title.toLowerCase().contains(q) ||
        p.compoundName.toLowerCase().contains(q) ||
        p.location.toLowerCase().contains(q) ||
        p.developerName.toLowerCase().contains(q)
      ).toList();
    }

    return results;
  }

  @override
  Future<List<PropertyModel>> getFeaturedProperties() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _properties.where((p) => p.isFeatured).toList();
  }

  @override
  Future<PropertyModel?> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
