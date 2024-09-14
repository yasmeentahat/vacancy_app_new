import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vacancy_model.dart';

class VacancyService {
  static const String apiUrl = 'https://www.unhcrjo.org/jobs/api';

  Future<List<Vacancy>> fetchVacancies() async {
    final response = await http.get(Uri.parse(apiUrl));

    // Debug: Print the API response to see if you're getting valid data
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => Vacancy.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vacancies');
    }
  }
}
