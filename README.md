# 🏛️ مستقبل الفراعنة للتطوير والاستثمار العقاري (Pharaohs Future)
### تطبيق الموبايل الرسمي بنظام **MVP Architecture (Model - View - Presenter)**

---

## 🌟 نبذة عن المشروع
تطبيق موبايل متكامل بتقنية **Flutter** مصمم خصيصاً لشركة **مستقبل الفراعنة للإستثمار والتطوير العقاري**، بهدف عرض المشاريع والوحدات العقارية الحصرية (في العاصمة الإدارية الجديدة، التجمع الخامس، الساحل الشمالي، والشيخ زايد)، مع خطط استثمارية ذكية وحاسبة عائد استثماري (ROI)، وتواصل مباشر مع مستشاري المبيعات.

تم بناء وتنسيق المشروع من البداية وفق هيكلية **MVP Architecture** مع تقسيم واضح ومفصول للطبقات (Feature-first MVP).

---

## 📐 الهيكلية المعمارية للمشروع (MVP Architecture)

```
lib/
├── core/                                # المكونات المشتركة على مستوى التطبيق بالكامل
│   ├── constants/
│   │   ├── app_colors.dart             # لوحة الألوان الفاخرة (الذهبي الملكي والأزرق الداكن)
│   │   └── app_strings.dart            # نصوص التطبيق باللغتين العربية والإنجليزية
│   ├── network/
│   │   ├── api_endpoints.dart          # روابط الـ API
│   │   └── api_response.dart           # كلاس موحد لحالات الاتصال بالشبكة (Loading/Success/Error)
│   ├── theme/
│   │   └── app_theme.dart              # الثيم المظلم والفاتح وخط Cairo من Google Fonts
│   └── utils/
│       └── formatters.dart             # دوال تنسيق العملة (ج.م) والمساحات (م²)
│
├── features/                            # الميزات الرئيسية مقسمة بنمط MVP
│   ├── home/                            # شاشة الرئيسية
│   │   ├── models/home_data_model.dart # (Model)
│   │   ├── views/                      # (View)
│   │   │   ├── home_contract.dart      # View & Presenter Contracts
│   │   │   ├── home_screen.dart        # View Implementation
│   │   │   └── widgets/                # مكونات واجهة المستخدم
│   │   └── presenters/home_presenter.dart # (Presenter) منطق العرض وجلب البيانات
│   │
│   ├── properties/                      # ميزة استعراض العقارات والوحدات
│   │   ├── models/property_model.dart  # (Model)
│   │   ├── repositories/               # (Repository Layer)
│   │   │   ├── property_repository.dart
│   │   │   └── mock_property_repository.dart
│   │   ├── views/                      # (View)
│   │   │   ├── property_list_contract.dart
│   │   │   ├── property_list_screen.dart
│   │   │   ├── property_details_contract.dart
│   │   │   ├── property_details_screen.dart
│   │   │   └── widgets/property_card_widget.dart
│   │   └── presenters/                 # (Presenter)
│   │       ├── property_list_presenter.dart
│   │       └── property_details_presenter.dart
│   │
│   ├── investments/                     # ميزة الاستثمار وحاسبة الـ ROI
│   │   ├── models/investment_plan_model.dart # (Model)
│   │   ├── views/                      # (View)
│   │   │   ├── investment_contract.dart
│   │   │   ├── investment_screen.dart
│   │   │   └── widgets/roi_calculator_widget.dart
│   │   └── presenters/investment_presenter.dart # (Presenter)
│   │
│   ├── contact/                         # ميزة إرسال طلب استشارة والتواصل
│   │   ├── models/inquiry_model.dart   # (Model)
│   │   ├── views/                      # (View)
│   │   │   ├── contact_contract.dart
│   │   │   └── contact_screen.dart
│   │   └── presenters/contact_presenter.dart # (Presenter)
│   │
│   └── main_layout/                     # شريط التنقل السفلي بين الأقسام
│       └── views/main_navigation_screen.dart
│
├── app.dart                             # إعدادات التطبيق والدعم الكامل للغة العربية RTL
└── main.dart                            # نقطة انطلاق التطبيق الرئيسية
```

---

## 💡 كيف يعمل الـ MVP في هذا المشروع؟
1. **Model**:
   - يحتوي على البيانات وهياكلها (`PropertyModel`, `InvestmentPlanModel`, `InquiryModel`).
   - يتضمن طبقة الـ `Repositories` لجلب البيانات سواء من API خارجي أو Mock Data.
2. **View (Contract & Screen)**:
   - تحدد واجهة العقد مثل `PropertyListViewContract` الدوال التي يجب على الشاشة تنفيذها (`showLoading`, `hideLoading`, `showProperties`, `showError`).
   - الشاشة مسؤولة فقط عن رسم عناصر الواجهة وتمرير تفاعل المستخدم للـ Presenter.
3. **Presenter**:
   - كلاس Dart نقي (Pure Dart) لا يرتبط مباشرة بالـ Flutter Widgets.
   - يتواصل مع الـ Repository، يعالج العمليات الحسابية، ويخاطب الـ View عبر الـ Contract.
   - سهل الاختبار جداً عبر اختبارات الـ Unit Tests المعزولة.

---

## 🚀 كيفية تشغيل التطبيق
```bash
# 1. تثبيت الاعتماديات
flutter pub get

# 2. فحص الأكواد للتأكد من خلوها من أي أخطاء
flutter analyze

# 3. تشغيل الـ Unit Tests
flutter test

# 4. تشغيل التطبيق على الهاتف أو المحاكي
flutter run
```
