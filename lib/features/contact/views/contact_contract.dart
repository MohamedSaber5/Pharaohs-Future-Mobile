import '../models/inquiry_model.dart';

abstract class ContactViewContract {
  void showLoading();
  void hideLoading();
  void showSubmissionSuccess();
  void showError(String message);
}

abstract class ContactPresenterContract {
  void attachView(ContactViewContract view);
  void detachView();
  void submitInquiry(InquiryModel inquiry);
}
