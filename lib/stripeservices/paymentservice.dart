import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentservices {
  Map<String, dynamic>? paymentIntent;

  Future<bool> makePayment(BuildContext context, String amount) async {
    try {
      // STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount, 'USD');

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'Ikay',
        ),
      );

      // STEP 3: Display Payment sheet and await result
      return await displayPaymentSheet(context);
    } catch (err) {
      print('Payment failed: $err');
      return false; // Payment failed
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount).toString(),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51St7HRPPkLMB9mdQw3EKJlFHDcor1NgHUaFsf0U6iCebzmZfOSQo3hmQZs5PZk6T5pSrryUSaxplZ1IANsUeU8gk00fGCTzhjO',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
        return true;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Text("Payment Failed"),
                ],
              ),
            ],
          ),
        ),
      );
      return false;
    } catch (e) {
      print('$e');
      return false;
    }
  }

  calculateAmount(String amount) {
    return (int.parse(amount)) * 100;
  }
}
