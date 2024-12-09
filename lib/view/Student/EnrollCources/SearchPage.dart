// import 'package:course_selling/theme.dart';
// import 'package:flutter/material.dart';

// class Searchpage extends StatelessWidget {
//   const Searchpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: p),
//         child: Column(
//           children: [
//             SizedBox(height: 50),
//             TextFormField(
//               style: const TextStyle(color: Colors.black),
//               // controller: emailController,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.black)),
//                 hintText: 'Search Course',
//                 hintStyle: const TextStyle(color: Colors.grey),

//                 // hintText: 'password',

//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.black)),
//               ),
//             ),
//             SizedBox(height: 30),
//             Expanded(
//               child: Container(
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 5,
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 15.0),
//                         child: Container(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 80,
//                                 width: 80,
//                                 child: Image.asset(
//                                   'assets/images/c.png',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Learn Computer',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16.0,
//                                       ),
//                                     ),
//                                     Text(
//                                       '2 days ago',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 10),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                             backgroundColor: Colors.grey,
//                                             radius: 10,
//                                             child: Icon(
//                                               color: Colors.white,
//                                               Icons.person,
//                                               size: 10,
//                                             )),
//                                         SizedBox(width: 10),
//                                         Text('Sir Hamza')
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
