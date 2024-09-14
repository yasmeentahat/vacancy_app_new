import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/vacancy_model.dart';

class VacancyDetailsScreen extends StatelessWidget {
  final Vacancy vacancy;

  const VacancyDetailsScreen({Key? key, required this.vacancy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: vacancy.imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  vacancy.company,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Job ID: ${vacancy.id}',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('Location: ${vacancy.location}',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('Salary: ${vacancy.salary}',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 20),
                const Text('Description:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(vacancy.description,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),
                const Text('Long Description:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(vacancy.longDescription,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),
                Text('Date Posted: ${vacancy.datePosted}',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
