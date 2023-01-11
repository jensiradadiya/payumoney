import 'package:flutter/material.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // Example app to test the payumoney plugin
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayUMoney Checkout Pro'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Make Payment"),
            onPressed: () async {
              // // Every Transaction should have a unique ID. I am using timestamp as transactionid. Because its always unique :)
              String orderId = DateTime.now().millisecondsSinceEpoch.toString();
              // Amount is in rs. Enter 100 for Rs100.
              final String amount = "10";

              // Phone Number should be 10 digits. Please validate it before passing else it will throw error.
              // hashUrl is required. check github documentation for nodejs code.
              var response = await PayumoneyProUnofficial.payUParams(
                  email: 'test@example.com',
                  firstName: "Orange",
                  merchantName: 'Orange Digitals',
                  isProduction: false,
                  merchantKey:
                      'gtKFFx', //You will find these details from payumoney dashboard
                  merchantSalt: '4R38IvwiV57FwVpsgOvTXBdLE4tHUXFW',
                  amount: amount,
                  productInfo: 'OnePlus', // Enter Product Name
                  transactionId:
                      orderId, //Every Transaction should have a unique ID
                  hashUrl:
                      'ffcdbf04fa5beefdcc2dd476c18bc410f02b3968e7f4f54e8f43f1e1a310bb32e3b4dec9305232bb89db5b1d0c009a53bcace6f4bd8ec2f695baf3d43ba730ce',
                  userCredentials: 'test@example.com',
                  showLogs: true,
                  userPhoneNumber: '9999999999');

              print("respince pay==> ${response}");
              // handling success response
              if (response['status'] == PayUParams.success)
                print("successssssss=== ");
              handlePaymentSuccess(amount);
              // handling failure response
              if (response['status'] == PayUParams.failed)
                print("faillllll=== ");
              handlePaymentFailure(amount, response['message']);
            },
          ),
        ),
      ),
    );
  }

// Function to implement business login on payment success
  handlePaymentSuccess(String amount) {
    print("Success");
    // Implement your logic here for successful payment.
  }

// Function to implement business login on payment failure
  handlePaymentFailure(String amount, String error) {
    print("Failed");
    print(error);
    // Implement your logic here for failed payment.
  }
}
