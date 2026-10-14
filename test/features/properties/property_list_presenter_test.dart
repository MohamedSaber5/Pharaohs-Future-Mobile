import 'package:flutter_test/flutter_test.dart';
import 'package:pharaohs_future/features/properties/models/property_model.dart';
import 'package:pharaohs_future/features/properties/presenters/property_list_presenter.dart';
import 'package:pharaohs_future/features/properties/repositories/property_repository.dart';
import 'package:pharaohs_future/features/properties/views/property_list_contract.dart';

// Mock View for testing MVP Presenter
class MockPropertyListView implements PropertyListViewContract {
  bool isLoadingCalled = false;
  bool isHideLoadingCalled = false;
  List<PropertyModel>? receivedProperties;
  String? receivedError;

  @override
  void showLoading() {
    isLoadingCalled = true;
  }

  @override
  void hideLoading() {
    isHideLoadingCalled = true;
  }

  @override
  void showProperties(List<PropertyModel> properties) {
    receivedProperties = properties;
  }

  @override
  void showError(String message) {
    receivedError = message;
  }
}

// Mock Repository
class FakePropertyRepository implements PropertyRepository {
  final List<PropertyModel> mockData;
  FakePropertyRepository(this.mockData);

  @override
  Future<List<PropertyModel>> getProperties({PropertyType? type, String? query}) async {
    return mockData;
  }

  @override
  Future<List<PropertyModel>> getFeaturedProperties() async {
    return mockData.where((p) => p.isFeatured).toList();
  }

  @override
  Future<PropertyModel?> getPropertyById(String id) async {
    return mockData.firstWhere((p) => p.id == id);
  }
}

void main() {
  late PropertyListPresenter presenter;
  late MockPropertyListView mockView;
  late FakePropertyRepository fakeRepo;

  setUp(() {
    fakeRepo = FakePropertyRepository([
      PropertyModel(
        id: '1',
        title: 'شقة فاخرة في العاصمة الإدارية',
        developerName: 'مستقبل الفراعنة',
        compoundName: 'Crown Residence',
        location: 'العاصمة الإدارية',
        totalPrice: 5000000,
        downPayment: 500000,
        installmentYears: 8,
        monthlyInstallment: 46000,
        areaSqM: 180,
        bedrooms: 3,
        bathrooms: 2,
        deliveryYear: 2026,
        type: PropertyType.residential,
        imageUrl: '',
        galleryImages: [],
        description: 'وصف تجريبي',
        isFeatured: true,
      ),
    ]);
    presenter = PropertyListPresenter(fakeRepo);
    mockView = MockPropertyListView();
    presenter.attachView(mockView);
  });

  tearDown(() {
    presenter.detachView();
  });

  test('loadProperties should notify View with loading and properties data', () async {
    await presenter.loadProperties();

    expect(mockView.isLoadingCalled, true);
    expect(mockView.isHideLoadingCalled, true);
    expect(mockView.receivedProperties?.length, 1);
    expect(mockView.receivedProperties?.first.title, 'شقة فاخرة في العاصمة الإدارية');
  });
}
