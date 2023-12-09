import 'package:flutter/material.dart';
import 'package:stock_scan_parser/components/stock_scan_detail_header.dart';
import 'package:stock_scan_parser/components/stock_scan_detail_tile.dart';

class StockScanDetail extends StatelessWidget {
  const StockScanDetail({
    super.key,
    required this.stockScan,
  });

  final stockScan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.keyboard_backspace_rounded,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          StockScanDetailHeader(stockScan: stockScan),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "and",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, index) => StockScanDetailTile(
                stockScan: stockScan,
                index: index,
              ),
              itemCount: stockScan['criteria'].length,
            ),
          ),
        ],
      ),
    );
  }
}
