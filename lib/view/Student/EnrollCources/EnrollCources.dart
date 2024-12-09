import 'package:course_selling/theme.dart';
import 'package:flutter/material.dart';

class Enrollcources extends StatelessWidget {
  const Enrollcources({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enroll Courses'),
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: p),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(10, (index) {
              return InkWell(
                onTap: () {
                  // Add onTap action
                },
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.45, // Half of the screen width
                    padding: const EdgeInsets.all(
                        10), // Padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 80,
                            width: double.infinity, // Full width for the image
                            child: Icon(Icons.person)),
                        const SizedBox(height: 10),
                        Text(
                          'title',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'subtitle',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'createdAt',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 5),
                         
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }
}
