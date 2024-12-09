import 'package:course_selling/pamentcontroler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Paymentscreen extends StatefulWidget {
  const Paymentscreen({super.key});

  @override
  _PaymentscreenState createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  var controller = Get.put(Pamentcontroler());

  // List of asset image paths
  List<String> imagePaths = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/t.jpg',
  ];

  // Variable to hold the currently selected image
  late String selectedImage;

  // Variable to track if payment is completed
  bool paymentCompleted = false;

  @override
  void initState() {
    super.initState();
    // Initialize selectedImage with the 0th index image on widget load
    selectedImage = imagePaths[0];
  }

  // Function to handle image selection
  void onImageSelected(int index) async {
    if (index != 0 && !paymentCompleted) {
      // Show dialog asking the user to make payment first
      bool proceedWithPayment = await _showPaymentDialog();
      if (proceedWithPayment) {
        // If the user agrees to make the payment
        await controller.makePayment();
        setState(() {
          paymentCompleted = true; // Mark payment as completed
          selectedImage = imagePaths[index]; // Change the image after payment
        });
      }
    } else {
      // If it's the 0th image or payment is already completed
      setState(() {
        selectedImage = imagePaths[index];
      });
    }
  }

  // Function to show a dialog asking for payment
  Future<bool> _showPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Required'),
        content: Text('You need to make a payment before viewing this image.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Cancel
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Proceed with payment
            },
            child: Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Show the selected image at the top
            Image.asset(
              selectedImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),

            // Display the images in a horizontal ListView.builder
            Container(
              height: 100, // Set height for ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      onImageSelected(index); // Handle image selection
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 8.0), // Add spacing between items
                      child: Image.asset(
                        imagePaths[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Payment button (optional: this can be hidden or disabled based on your needs)
            ElevatedButton(
              onPressed: () async {
                await controller.makePayment();
                setState(() {
                  paymentCompleted = true;
                });
              },
              child: Text('Make a Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
