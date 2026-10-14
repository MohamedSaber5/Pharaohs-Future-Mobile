import '../models/property_model.dart';
import '../repositories/property_repository.dart';
import '../views/property_list_contract.dart';

class PropertyListPresenter implements PropertyListPresenterContract {
  final PropertyRepository _repository;
  PropertyListViewContract? _view;
  PropertyType? _selectedType;
  String _currentQuery = '';

  PropertyListPresenter(this._repository);

  @override
  void attachView(PropertyListViewContract view) {
    _view = view;
  }

  @override
  void detachView() {
    _view = null;
  }

  PropertyType? get selectedType => _selectedType;

  @override
  Future<void> loadProperties({PropertyType? type, String? query}) async {
    _selectedType = type;
    if (query != null) _currentQuery = query;

    _view?.showLoading();
    try {
      final properties = await _repository.getProperties(
        type: _selectedType,
        query: _currentQuery,
      );
      _view?.hideLoading();
      _view?.showProperties(properties);
    } catch (e) {
      _view?.hideLoading();
      _view?.showError('حدث خطأ أثناء تحميل العقارات: $e');
    }
  }

  @override
  void filterByType(PropertyType? type) {
    _selectedType = type;
    loadProperties(type: _selectedType, query: _currentQuery);
  }

  @override
  void searchProperties(String query) {
    _currentQuery = query;
    loadProperties(type: _selectedType, query: _currentQuery);
  }
}
