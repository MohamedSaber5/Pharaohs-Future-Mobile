import '../../properties/repositories/property_repository.dart';
import '../models/home_data_model.dart';
import '../views/home_contract.dart';

class HomePresenter implements HomePresenterContract {
  final PropertyRepository _propertyRepository;
  HomeViewContract? _view;

  HomePresenter(this._propertyRepository);

  @override
  void attachView(HomeViewContract view) {
    _view = view;
  }

  @override
  void detachView() {
    _view = null;
  }

  @override
  Future<void> loadHomeData() async {
    _view?.showLoading();
    try {
      final featuredProperties = await _propertyRepository.getFeaturedProperties();

      final banners = [
        HomeBannerModel(
          id: 'b1',
          title: 'استثمر في عاصمة المستقبل',
          subtitle: 'مشاريع حصرية بأعلى عائد إيجاري مع تسهيلات تصل إلى 8 سنوات',
          imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=1200&q=80',
          actionLabel: 'اكتشف الفرص',
        ),
        HomeBannerModel(
          id: 'b2',
          title: 'الفراعنة بلازا - التجمع الخامس',
          subtitle: 'وحدات تجارية وإدارية بمقدم يبدأ من 10% وعائد إلزامي',
          imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80',
          actionLabel: 'تفاصيل المشروع',
        ),
      ];

      final stats = CompanyStatsModel(
        totalUnitsDelivered: '2,500+',
        totalInvestmentsEGP: '8.5 مليار',
        happyClients: '4,200+',
        activeProjects: '14 مشروع',
      );

      final homeData = HomeDataModel(
        banners: banners,
        featuredProperties: featuredProperties,
        stats: stats,
      );

      _view?.hideLoading();
      _view?.showHomeData(homeData);
    } catch (e) {
      _view?.hideLoading();
      _view?.showError('فشل تحميل بيانات الصفحة الرئيسية: $e');
    }
  }
}
