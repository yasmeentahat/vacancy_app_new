class Vacancy {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String longDescription;
  final String salary;
  final String datePosted;
  final String imageUrl;

  Vacancy({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.longDescription,
    required this.salary,
    required this.datePosted,
    required this.imageUrl,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      id: json['id'] ?? 'N/A',
      title: json['title'] ?? 'N/A',
      company: json['company'] ?? 'Unknown Company',
      location: json['location'] ?? 'Location not available',
      description: json['description'] ?? 'No description available',
      longDescription: json['long_description'] ?? 'No additional details',
      salary: json['salary'] ?? 'Salary not provided',
      datePosted: json['date_posted'] ?? 'Date not available',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}
