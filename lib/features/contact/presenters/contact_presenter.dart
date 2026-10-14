import '../models/inquiry_model.dart';
import '../views/contact_contract.dart';

class ContactPresenter implements ContactPresenterContract {
  ContactViewContract? _view;

  @override
  void attachView(ContactViewContract view) {
    _view = view;
  }

  @override
  void detachView() {
    _view = null;
  }

  @override
  Future<void> submitInquiry(InquiryModel inquiry) async {
    // Validation
    if (inquiry.fullName.trim().isEmpty) {
      _view?.showError('يرجى إدخال الاسم بالكامل');
      return;
    }
    if (inquiry.phone.trim().isEmpty || inquiry.phone.length < 10) {
      _view?.showError('يرجى إدخال رقم هاتف صحيح');
      return;
    }

    _view?.showLoading();
    try {
      // Simulate API network call to lead CRM
      await Future.delayed(const Duration(milliseconds: 700));
      _view?.hideLoading();
      _view?.showSubmissionSuccess();
    } catch (e) {
      _view?.hideLoading();
      _view?.showError('تعذر إرسال الطلب: $e');
    }
  }
}
