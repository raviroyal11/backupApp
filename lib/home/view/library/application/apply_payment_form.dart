import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  void _submitPayment() {
    // Implement your logic to submit the payment data
    String amount = _amountController.text;
    String cardNumber = _cardNumberController.text;
    String expiryDate = _expiryDateController.text;
    String cvv = _cvvController.text;

    // Example: Display the submitted data
    print('Amount: $amount');
    print('Card Number: $cardNumber');
    print('Expiry Date: $expiryDate');
    print('CVV: $cvv');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Form'),
        titleTextStyle: AppStyle()
            .workSansSemiBold(context)
            .copyWith(fontSize: 20, color: AppColor.color4551),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Lottie.asset("assets/images/coming_soon.json",
                height: height * 0.2),
            const SizedBox(height: 20),
            Text(
              "Coming Soon..",
              textAlign: TextAlign.center,
              style: AppStyle()
                  .workSansSemiBold(context)
                  .copyWith(color: AppColor.color8EE9, fontSize: 30),
            ),
          ],
        ),
      ),
      /* Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Payment Form',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPayment,
              child: Text('Submit Payment'),
            ),
          ],
        ),
      ),
     */
    );
  }
}
