import '../models/property_model.dart';

abstract class PropertyDetailsViewContract {
  void showLoading();
  void hideLoading();
  void showPropertyDetails(PropertyModel property);
  void showError(String message);
  void showBookingSuccessMessage();
}

abstract class PropertyDetailsPresenterContract {
  void attachView(PropertyDetailsViewContract view);
  void detachView();
  void loadPropertyDetails(String id);
  void requestTourAppointment(String propertyId, String customerPhone);
}
