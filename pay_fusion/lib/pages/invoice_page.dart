import 'package:flutter/material.dart';
import 'package:pay_fusion/util/invoice_pdf_generator.dart';
import '../charts/simple_pie_chart.dart'; // Import your pie chart widget
import '../theme/app_colors.dart'; // Color definitions

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('E-Invoice', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Budget Yada Yada',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Created On: 17 Feb 2023',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            // PIE CHART
            const SimplePieChart(),

            // ISSUER INFO
            _sectionContainer(
              title: 'Issuer (Business Sender)',
              children: const [
                _LabelValue('Naam Tech Sdn Bhd', '#PAY2023EDI01'),
                _LabelValue('SSM Number', '202312345678'),
                _LabelValue('Phone Number', '6012–3456789'),
              ],
            ),

            const SizedBox(height: 16),

            // DESCRIPTION
            _sectionContainer(
              title: 'Description',
              children: const [
                _TableRow([
                  'Desc',
                  'Qty',
                  'Unit Price',
                  'Total',
                ], isHeader: true),
                _TableRow(['Service Fee', '1', '300', '300']),
              ],
            ),

            const SizedBox(height: 16),

            // PAYMENT INFO
            _sectionContainer(
              children: const [
                _LabelValue('Payment Method', 'DuitNow QR'),
                _LabelValue('Application fee', '\$0.00'),
                _LabelValue('Time', '09:41 pm'),
                _LabelValue('Date', '17 Feb, 2023'),
              ],
            ),

            const SizedBox(height: 24),

            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await InvoicePdfGenerator.generateDummyPdf(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Submit Invoice'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section container styling
  static Widget _sectionContainer({
    String? title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E23),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ...children,
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValue(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final List<String> values;
  final bool isHeader;

  const _TableRow(this.values, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children:
            values.map((v) {
              return Expanded(
                child: Text(
                  v,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
