import 'package:faker/faker.dart';

class CityData {
  static final faker = Faker();

  static final List<String> cities =
      List.generate(20, (index) => faker.address.city());

  static List<String> getSuggestions(String query) =>
      List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}
