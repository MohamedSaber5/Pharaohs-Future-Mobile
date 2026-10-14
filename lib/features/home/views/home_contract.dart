import '../models/home_data_model.dart';

abstract class HomeViewContract {
  void showLoading();
  void hideLoading();
  void showHomeData(HomeDataModel data);
  void showError(String message);
}

abstract class HomePresenterContract {
  void attachView(HomeViewContract view);
  void detachView();
  void loadHomeData();
}
