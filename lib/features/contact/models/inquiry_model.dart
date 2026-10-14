class InquiryModel {
  final String fullName;
  final String phone;
  final String preferredLocation;
  final double budgetEGP;
  final String propertyType;
  final String notes;

  InquiryModel({
    required this.fullName,
    required this.phone,
    required this.preferredLocation,
    required this.budgetEGP,
    required this.propertyType,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'preferredLocation': preferredLocation,
      'budgetEGP': budgetEGP,
      'propertyType': propertyType,
      'notes': notes,
    };
  }
}
