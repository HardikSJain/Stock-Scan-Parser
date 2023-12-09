import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_scan_parser/constants/routes.dart';

class StockScanDetailTile extends StatelessWidget {
  const StockScanDetailTile({
    super.key,
    required this.stockScan,
    required this.index,
  });

  final stockScan;
  final int index;

  @override
  Widget build(BuildContext context) {
    final criteria = stockScan['criteria'][index];
    if (criteria['type'] == "plain_text") {
      return Text(
        criteria['text'],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.justify,
      );
    } else if (criteria['type'] == "variable") {
      final texts = criteria['text'].split(" ");

      return RichText(
        text: TextSpan(
          children: List.generate(
            texts.length,
            (index) {
              final variables = criteria['variable'];

              if (variables[texts[index]] == null) {
                return TextSpan(
                  text: "${texts[index]} ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }
              final variable = variables[texts[index]]!;
              String variableValue = '';

              if (variable['type'] == 'value') {
                variableValue = (variable['values']?.first ?? '').toString();
              } else if (variable['type'] == 'indicator') {
                variableValue = (variable['default_value'] ?? '').toString();
              }
              return TextSpan(
                text: "($variableValue) ",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(
                      context,
                      variableDetailRoute,
                      arguments: {
                        "variable": variable,
                        "type": variable['type'],
                        "title": stockScan['name'],
                      },
                    );
                  },
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              );
            },
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
