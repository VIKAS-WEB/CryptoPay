import 'package:crypto_pay/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of cryptocurrency data
    final List<Map<String, dynamic>> cryptoData = [
      {
        'icon': Icons.currency_bitcoin,
        'color': Colors.orange,
        'name': 'Bitcoin',
        'amount': '\$80,617.00',
        'change': '↓ 1.7%',
        'isPositive': false,
      },
      {
        'icon': Icons.swap_horizontal_circle,
        'color': Colors.purple,
        'name': 'Ethereum ETH',
        'amount': '\$1,543.29',
        'change': '↓ 4.7%',
        'isPositive': false,
      },
      {
        'icon': Icons.attach_money,
        'color': Colors.green,
        'name': 'Tether USDT',
        'amount': '\$0.9993',
        'change': '↓ 0.0%',
        'isPositive': false,
      },
      {
        'icon': Icons.star,
        'color': Colors.blue,
        'name': 'Solana SOL',
        'amount': '\$115.18',
        'change': '↓ 0.5%',
        'isPositive': false,
      },
      {
        'icon': Icons.pets,
        'color': Colors.yellow,
        'name': 'Dogecoin DOGE',
        'amount': '\$0.156',
        'change': '↓ 0.2%',
        'isPositive': false,
      },
      {
        'icon': Icons.vpn_key,
        'color': Colors.teal,
        'name': 'Toncoin TON',
        'amount': '\$2.90',
        'change': '↓ 4.4%',
        'isPositive': false,
      },
      {
        'icon': Icons.polyline,
        'color': Colors.indigo,
        'name': 'Polygon MATIC',
        'amount': '\$0.1844',
        'change': '↑ 0.2%',
        'isPositive': true,
      },
      {
        'icon': Icons.brightness_3,
        'color': Colors.blueGrey,
        'name': 'Moonwell WELL',
        'amount': '\$0.01845',
        'change': '↓ 3.9%',
        'isPositive': false,
      },
      {
        'icon': Icons.face,
        'color': Colors.brown,
        'name': 'APES APES',
        'amount': '\$0.000007101',
        'change': '↓ 13.0%',
        'isPositive': false,
      },
    ];

    // Sample transaction data
    final List<Map<String, dynamic>> transactions = [
      {
        'transactionID': 'TX123456',
        'asset': 'Bitcoin',
        'requested': '0.5 BTC',
        'converted': '\$40,308.50',
        'received': '0.5 BTC',
        'type': 'Transfer',
        'status': 'Completed',
        'timestamp': '2025-04-12 14:30',
      },
    ];

    // Pie chart data
    final Map<String, double> pieChartData = {
      'Success': 60.0,
      'Waiting': 25.0,
      'Declined': 15.0,
    };

    final colorList = <Color>[
      Colors.green,
      Colors.orange,
      Colors.red,
    ];

    // Convert Future<String?> to Future<String> with detailed debugging
    // Future<String> getMerchantNameFuture() async {
    //   try {
    //     final prefs = await SharedPreferences.getInstance();
    //     final name = prefs.getString(AuthManager.merchantNameKey); // Use public getter
    //     print('SharedPreferences contains ${AuthManager.merchantNameKey}: ${prefs.containsKey(AuthManager.merchantNameKey)}');
    //     print('Merchant name retrieved from SharedPreferences: $name');
    //     return name ?? 'User'; // Default to 'User' if null
    //   } catch (e) {
    //     print('Error retrieving merchant name: $e');
    //     return 'User'; // Fallback value
    //   }
    // }


        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 16.0),
                  //   child: Text(
                  //     'Welcome, !',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.kprimary,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cryptoData.length,
                      itemBuilder: (context, index) {
                        final crypto = cryptoData[index];
                        return Container(
                          width: 230,
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                crypto['icon'],
                                color: crypto['color'],
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      crypto['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          crypto['amount'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: crypto['isPositive']
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          crypto['change'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: crypto['isPositive']
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coin Converter',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'BTC',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: '__',
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '=',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'USD',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: '__',
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Change: '),
                                Icon(Icons.bolt, color: Colors.orange, size: 16),
                                Text('-'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Volume: '),
                                Icon(Icons.bolt, color: Colors.orange, size: 16),
                                Text('-'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction Status',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: PieChart(
                      dataMap: pieChartData,
                      colorList: colorList,
                      chartRadius: 170,
                      legendOptions: const LegendOptions(
                        showLegends: true,
                        legendPosition: LegendPosition.right,
                        legendTextStyle: TextStyle(fontSize: 15),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transaction',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All >'),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('TransactionID')),
                          DataColumn(label: Text('Asset')),
                          DataColumn(label: Text('Requested')),
                          DataColumn(label: Text('Converted')),
                          DataColumn(label: Text('Received')),
                          DataColumn(label: Text('Type')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Timestamp')),
                        ],
                        rows: transactions.map((transaction) {
                          return DataRow(cells: [
                            DataCell(Text(transaction['transactionID'])),
                            DataCell(Text(transaction['asset'])),
                            DataCell(Text(transaction['requested'])),
                            DataCell(Text(transaction['converted'])),
                            DataCell(Text(transaction['received'])),
                            DataCell(Text(transaction['type'])),
                            DataCell(Text(transaction['status'])),
                            DataCell(Text(transaction['timestamp'])),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          
                
              ),
        );
  }
}

// Custom Painter for the mini graph (unchanged)
class GraphPainter extends CustomPainter {
  final Color color;

  GraphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.2, size.height * 0.3, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 0.4, size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}