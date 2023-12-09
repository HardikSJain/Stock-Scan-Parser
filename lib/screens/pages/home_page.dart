//

import 'package:flutter/material.dart';
import 'package:stock_scan_parser/components/stock_scan_tile.dart';
import 'package:stock_scan_parser/services/apiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> stockScans;

  Future<List<Map<String, dynamic>>> fetchStockScans() async {
    return await getStockScan();
  }

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
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Stock Scan'),
    );
  }

  _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          // stockScans, // Use the Future directly, no need to call
          fetchStockScans(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () async {
                List<Map<String, dynamic>> updatedList =
                    await fetchStockScans();

                setState(() {
                  stockScans = updatedList;
                });
              },
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available.'),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 0.2,
              height: 16,
              indent: 24,
              endIndent: 24,
            ),
            itemBuilder: (context, index) {
              final scan = snapshot.data![index];
              Color textColor = getColorFromString(scan['color']);

              return StockScanTile(
                stockScan: scan,
                textColor: textColor,
              );
            },
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }
}
