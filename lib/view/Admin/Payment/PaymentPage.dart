import 'package:course_selling/theme.dart';
import 'package:flutter/material.dart';

class Paymentpage extends StatelessWidget {
  const Paymentpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        backgroundColor: redColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: p),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/t.jpg'),
                              radius: 25.0,
                            ),
                            SizedBox(width: 10),
                            Text('Zeeshan',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                )),
                            Spacer(),
                            Column(children: [
                              Text(
                                'received',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '65\$',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
                              )
                            ]),
                          ],
                        ),
                        Divider()
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
