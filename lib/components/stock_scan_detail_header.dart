import 'package:flutter/material.dart';

class StockScanDetailHeader extends StatelessWidget {
  const StockScanDetailHeader({super.key, required this.stockScan});

  final stockScan;

  Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      default:
        return Colors.black; // Default color if not recognized
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stockScan['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            stockScan['tag'],
            style: TextStyle(
              fontSize: 10,
              color: getColorFromString(stockScan['color']),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
