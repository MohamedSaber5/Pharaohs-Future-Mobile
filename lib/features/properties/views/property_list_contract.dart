import '../models/property_model.dart';

abstract class PropertyListViewContract {
  void showLoading();
  void hideLoading();
  void showProperties(List<PropertyModel> properties);
  void showError(String message);
}

abstract class PropertyListPresenterContract {
  void attachView(PropertyListViewContract view);
  void detachView();
  void loadProperties({PropertyType? type, String? query});
  void filterByType(PropertyType? type);
  void searchProperties(String query);
}
