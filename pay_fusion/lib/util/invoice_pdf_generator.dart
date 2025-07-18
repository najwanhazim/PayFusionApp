import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePdfGenerator {
  static Future<void> generateDummyPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Text('Issuer: Naam Tech Sdn Bhd'),
              pw.Text('SSM Number: 202312345678'),
              pw.Text('Phone: 6012–3456789'),
              pw.SizedBox(height: 16),
              pw.Text('Description:'),
              pw.Table.fromTextArray(
                headers: ['Desc', 'Qty', 'Unit Price', 'Total'],
                data: [
                  ['Service Fee', '1', '300', '300'],
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Text('Payment Method: DuitNow QR'),
              pw.Text('Date: 17 Feb 2023'),
              pw.Text('Time: 09:41 pm'),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
