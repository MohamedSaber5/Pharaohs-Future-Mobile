class ApiEndpoints {
  static const String baseUrl = 'https://api.pharaohsfuture.com/api/v1';

  // Properties Endpoints
  static const String properties = '$baseUrl/properties';
  static const String featuredProperties = '$baseUrl/properties/featured';
  static const String propertyDetails = '$baseUrl/properties/'; // + id

  // Investments Endpoints
  static const String investmentPlans = '$baseUrl/investments/plans';
  static const String calculateRoi = '$baseUrl/investments/calculate';

  // Inquiries / Leads
  static const String submitInquiry = '$baseUrl/inquiries';

  // Auth (if applicable)
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
}
