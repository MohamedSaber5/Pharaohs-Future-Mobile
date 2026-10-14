import '../repositories/property_repository.dart';
import '../views/property_details_contract.dart';

class PropertyDetailsPresenter implements PropertyDetailsPresenterContract {
  final PropertyRepository _repository;
  PropertyDetailsViewContract? _view;

  PropertyDetailsPresenter(this._repository);

  @override
  void attachView(PropertyDetailsViewContract view) {
    _view = view;
  }

  @override
  void detachView() {
    _view = null;
  }

  @override
  Future<void> loadPropertyDetails(String id) async {
    _view?.showLoading();
    try {
      final property = await _repository.getPropertyById(id);
      _view?.hideLoading();
      if (property != null) {
        _view?.showPropertyDetails(property);
      } else {
        _view?.showError('لم يتم العثور على العقار المطلوب');
      }
    } catch (e) {
      _view?.hideLoading();
      _view?.showError('حدث خطأ أثناء تحميل بيانات العقار: $e');
    }
  }

  @override
  Future<void> requestTourAppointment(String propertyId, String customerPhone) async {
    _view?.showLoading();
    try {
      // Simulate booking API call
      await Future.delayed(const Duration(milliseconds: 600));
      _view?.hideLoading();
      _view?.showBookingSuccessMessage();
    } catch (e) {
      _view?.hideLoading();
      _view?.showError('فشل حجز موعد المعاينة: $e');
    }
  }
}
