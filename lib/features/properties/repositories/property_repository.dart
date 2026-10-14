import '../models/property_model.dart';

abstract class PropertyRepository {
  Future<List<PropertyModel>> getProperties({PropertyType? type, String? query});
  Future<List<PropertyModel>> getFeaturedProperties();
  Future<PropertyModel?> getPropertyById(String id);
}
