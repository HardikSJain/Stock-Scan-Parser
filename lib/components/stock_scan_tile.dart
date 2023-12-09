import 'package:flutter/material.dart';
import 'package:stock_scan_parser/constants/routes.dart';

class StockScanTile extends StatelessWidget {
  const StockScanTile({
    super.key,
    required this.stockScan,
    required this.textColor,
  });

  final Map<String, dynamic> stockScan;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          stockScanDetailRoute,
          arguments: stockScan,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stockScan['name'] ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stockScan['tag'] ?? '',
              style: TextStyle(
                fontSize: 10,
                color: textColor,
                // color: stockScan['color'] ?? Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
