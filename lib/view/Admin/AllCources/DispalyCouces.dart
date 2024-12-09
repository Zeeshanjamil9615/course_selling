import 'package:course_selling/theme.dart';
import 'package:flutter/material.dart';

class Dispalycouces extends StatelessWidget {
  const Dispalycouces({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                height: 300,
                color: Colors.black,
                child: Stack(
                  children: [
                    Image.asset(
                      height: 300,
                      fit: BoxFit.cover,
                      'assets/images/c.png',
                    ),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          size: 50.0,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              // Add TabBar
              TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: redColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(text: "Lectures"),
                  Tab(text: "Description"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Lecture tab with ListView
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/c.png',
                                fit: BoxFit.cover,
                              ),
                              Icon(Icons.play_circle_fill),
                            ],
                          ),
                          title: Text('Benefits of computer course'),
                          subtitle: Text(
                            '2:30',
                            style: TextStyle(fontSize: 10),
                          ),
                          onTap: () {},
                          trailing: Icon(
                            Icons.delete,
                            color: redColor,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'This course offers a comprehensive understanding of computer',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Container
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        // controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: redColor)),
                          hintText: 'Title ',
                          hintStyle: const TextStyle(color: Colors.grey),

                          // hintText: 'password',

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: redColor)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black),
                        // controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: redColor)),
                          hintText: 'Pick video',
                          hintStyle: const TextStyle(color: Colors.grey),

                          // hintText: 'password',

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: redColor)),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: redColor,
                              )),
                          child: const Text(
                            'Add File',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.pink[50],
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(35)),
          child: Icon(
            Icons.add,
            color: redColor,
          ),
        ),
      ),
    );
  }
}
