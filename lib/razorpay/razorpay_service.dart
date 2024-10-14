import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

class RazorpayService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(String totalAmount) {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY', // Replace with your Razorpay Key ID
      'amount': totalAmount, // Amount in paise
      'name': 'Emergency Store',
      'description': 'Payment for cart items',
      'prefill': {
        'contact': '7303413985', // User's contact number
        'email': 'user@example.com' // User's email
      },
      'external': {
        'wallets': ['paytm'] // List of wallets you want to support
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment here
    debugPrint('Payment Successful: ${response.paymentId}');
    // Show a success message or navigate to a success screen
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error here
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    // Show an error message to the user
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet here
    debugPrint('External Wallet: ${response.walletName}');
  }

  void dispose() {
    _razorpay.clear();
  }
}
