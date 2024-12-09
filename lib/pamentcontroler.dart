import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class Pamentcontroler extends GetxController {
  var publishkey =
      'pk_test_51PxkC0P60cLEUP81tNfkaAlC4umW7mISOekfaxXv51ezWhkHrc42hDwnU2nt9Fq0tNoELAeWZdfULIariiD0fRTq00X3r2Dhym';
  var secretkey =
      'sk_test_51PxkC0P60cLEUP81QmUIlxKoVYvwObyhfPylcNxhD82G4K8B9GGPonEzSztvIFrjbbtECnNIx0PNBf4CaGx2jmyL00IkTH3J5p';
  var dio = Dio();
  var clientSecret = ''.obs;

  // Method to initiate payment process
  makePayment() async { 
    try {
      var result = await createPaymentIntent(10, 'usd');
      if (result == null) {
        print('Payment intent creation failed');
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: result,
          merchantDisplayName: 'Zeeshan Jamil',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      print('Payment successful!');
    } catch (e) {
      print('Payment error: $e');
    }
  }

  // Method to create a payment intent
  createPaymentIntent(int amount, String currency) async {
    try {
      var data = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${secretkey}",
            "Content-Type":
                'application/x-www-form-urlencoded', // Corrected typo
          },
        ),
      );

      if (response.data != null) {
        print(response.data);
        clientSecret.value = response.data['client_secret'];
        return response
            .data['client_secret']; 
      }
    } catch (e) {
      print('Error creating payment intent: $e');
    }
    return null;
  }

  calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
