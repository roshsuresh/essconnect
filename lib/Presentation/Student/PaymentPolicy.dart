import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PaymentPolicy extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIGuide.light_Purple,
        title: Text('Payment Policy'),
      ),
      body: SfPdfViewer.asset(
        'assets/paymentpolicy.pdf',
      ),
    );
  }
}
