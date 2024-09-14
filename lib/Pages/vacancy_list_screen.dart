import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_1/Api/vacancy_api.dart';
import '../models/vacancy_model.dart';
import 'vacancy_details_screen.dart';

class VacancyListScreen extends StatelessWidget {
  final VacancyService vacancyService = VacancyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Vacancies',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueAccent, Colors.lightBlue],
          ),
        ),
        child: FutureBuilder<List<Vacancy>>(
          future: vacancyService.fetchVacancies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 60, color: Colors.redAccent),
                    const SizedBox(height: 10),
                    const Text('Error loading vacancies.'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => vacancyService.fetchVacancies(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No vacancies available.'));
            }

            final vacancies = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vacancies.length,
              itemBuilder: (context, index) {
                final vacancy = vacancies[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  VacancyDetailsScreen(vacancy: vacancy),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                              imageUrl: vacancy.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vacancy.title,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  vacancy.company,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  vacancy.description,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500]),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  vacancy.datePosted,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
