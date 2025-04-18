import 'dart:convert';
import 'package:crypto_pay/src/screens/TransactionScreen/DashboardTransactionsAll.dart';
import 'package:crypto_pay/src/screens/TransactionScreen/TransactionScreen.dart';
import 'package:crypto_pay/src/utils/AuthManager.dart';
import 'package:crypto_pay/src/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_pay/src/screens/TransactionScreen/TransactionModel/TransactionModel.dart';
import 'package:crypto_pay/src/services/Transaction_api.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> cryptoData = [];
  List<Transaction> transactions = [];
  bool isLoading = true;
  String? errorMessage;
  final TransactionApiService apiService =
      TransactionApiService(authManager: AuthManager());

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const int maxRetries = 3;
    int retries = 0;
    while (retries < maxRetries) {
      try {
        setState(() {
          isLoading = true;
          errorMessage = null;
        });
        await Future.wait([
          fetchCryptoBalances(),
          fetchTransactions(),
        ]);
        setState(() {
          isLoading = false;
        });
        return;
      } catch (e) {
        retries++;
        if (retries == maxRetries) {
          setState(() {
            isLoading = false;
            errorMessage = 'Failed to fetch data after $maxRetries attempts: $e';
          });
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Future<void> fetchCryptoBalances({String? currency}) async {
    try {
      final isAuthenticated = await AuthManager.isAuthenticated();
      if (!isAuthenticated) {
        throw Exception('User not authenticated. Please log in.');
      }

      final userData = await AuthManager.getUserData();
      if (userData == null ||
          userData['merchantId'] == null ||
          userData['merchantId'] == 0) {
        throw Exception('Invalid Merchant ID. Please log in again.');
      }

      final merchantId = userData['merchantId'].toString();
      debugPrint('MerchantID: $merchantId');

      final queryParams = {
        if (currency != null && currency.isNotEmpty) 'Currency': currency,
      };
      debugPrint('Query Parameters: $queryParams');

      final uri =
          Uri.parse('https://cryptopay.oyefin.com/API/CryptoBalanceList')
              .replace(queryParameters: queryParams);
      debugPrint('API URL: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'MerchantID': merchantId,
        },
      );

      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          cryptoData = data.map((item) {
            final name = item['Receivedcurrency']?.toString() ?? 'Unknown';
            final balance = item['Balance']?.toString() ?? '0.00';
            final amount =
                '${double.tryParse(balance)?.toStringAsFixed(6) ?? '0.00'} $name';
            final svgAsset = _getSvgAssetForCrypto(name.toLowerCase());
            final fullName = _getFullCryptoName(name.toUpperCase());

            return {
              'svgAsset': svgAsset,
              'name': fullName,
              'amount': amount,
            };
          }).toList();
        });
      } else {
        throw Exception(
            'Failed to load crypto data: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching crypto data: $e');
      debugPrint('Stack trace: $stackTrace');
      throw Exception('Error fetching crypto data: $e');
    }
  }

  Future<void> fetchTransactions() async {
    try {
      final fetchedTransactions = await apiService.fetchTransactions(limit: 100);
      debugPrint('Fetched ${fetchedTransactions.length} transactions');
      setState(() {
        transactions = fetchedTransactions;
      });
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      throw Exception('Error fetching transactions: $e');
    }
  }

  String _getSvgAssetForCrypto(String name) {
    const String basePath = 'assets/Svg/';
    switch (name) {
      case 'ada':
        return '${basePath}cardano.svg';
      case 'btc':
        return '${basePath}bitcoin.svg';
      case 'dash':
        return '${basePath}dash.svg';
      case 'doge':
        return '${basePath}dogecoin.svg';
      case 'eth':
        return '${basePath}ethereum.svg';
      case 'ltc':
        return '${basePath}litecoin.svg';
      case 'usdt':
        return '${basePath}tether.svg';
      case 'matic':
        return '${basePath}polygon.svg';
      case 'arb':
        return '${basePath}arbitrum.svg';
      case 'bnb':
        return '${basePath}binance.svg';
      default:
        return '${basePath}default.svg';
    }
  }

  String _getFullCryptoName(String code) {
    final Map<String, String> cryptoMap = {
      'ada': 'Cardano',
      'btc': 'Bitcoin',
      'dash': 'Dash',
      'doge': 'Dogecoin',
      'eth': 'Ethereum',
      'ltc': 'Litecoin',
      'usdt': 'Tether',
      'matic': 'Polygon',
      'arb': 'Arbitrum',
      'bnb': 'Binance Coin',
    };
    return cryptoMap[code.toLowerCase()] ?? code.toUpperCase();
  }

  String formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  double calculateChartRadius(BuildContext context, double totalTransactions) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double baseRadius = 100.0;
    const double scaleFactor = 0.3; // 30% of screen width
    const double minRadius = 80.0;
    const double maxRadius = 150.0;

    double radius = screenWidth * scaleFactor;
    if (totalTransactions > 50) {
      radius *= 1.2; // Increase radius for large datasets
    }
    return radius.clamp(minRadius, maxRadius);
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic pie chart data with flexible status handling
    final Map<String, double> pieChartData = {};
    final Map<String, Color> statusColors = {
      'completed': Colors.green,
      'waiting': Colors.orange,
      'declined': Colors.red,
      // Add more statuses if API introduces new ones
    };

    for (var transaction in transactions) {
      final status = transaction.status.toLowerCase();
      pieChartData[status] = (pieChartData[status] ?? 0) + 1;
    }

    final colorList = pieChartData.keys
        .map((status) => statusColors[status] ?? Colors.grey)
        .toList();

    final double totalTransactions =
        pieChartData.values.fold(0, (sum, value) => sum + value);

    return Scaffold(
      body: isLoading
          ? const Center(child: SpinKitDoubleBounce(color: AppColors.kprimary, size: 60))
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!),
                      if (errorMessage!.contains('authenticated') ||             
                          errorMessage!.contains('Merchant ID'))
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Go to Login'),
                        ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 110,
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
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 247, 230, 194),
                                        AppColors.kwhite
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  crypto['svgAsset'] as String,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                const SizedBox(width: 15),
                                                Text(
                                                  '${crypto['name'].toUpperCase()}',
                                                  style: const TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              '${crypto['amount'].toUpperCase()}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Coin Converter',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'USD',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Change: '),
                                        Icon(Icons.bolt,
                                            color: Colors.orange, size: 16),
                                        Text('-'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Volume: '),
                                        Icon(Icons.bolt,
                                            color: Colors.orange, size: 16),
                                        Text('-'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction Activates: Total - ${totalTransactions.toInt()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: Container(
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
                                  child: pieChartData.isEmpty ||
                                          totalTransactions == 0
                                      ? const Center(
                                          child: Text('No transactions available'))
                                      : PieChart(
                                          dataMap: pieChartData,
                                          colorList: colorList,
                                          chartType: ChartType.ring,
                                          chartRadius: calculateChartRadius(
                                              context, totalTransactions),
                                          ringStrokeWidth: 32,
                                          legendOptions: const LegendOptions(
                                            showLegends: true,
                                            legendPosition: LegendPosition.right,
                                            legendTextStyle:
                                                TextStyle(fontSize: 14),
                                            showLegendsInRow: false,
                                          ),
                                          chartValuesOptions:
                                              const ChartValuesOptions(
                                            showChartValues: false,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recent Transaction',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const DashboardTransactionScreenAll(),
                                    ),
                                  );
                                },
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
                                    DataCell(Text(transaction.transactionId)),
                                    DataCell(Text(transaction.receivedCurrency)),
                                    DataCell(Text(
                                        '${transaction.requestedAmount} ${transaction.requestedCurrency}')),
                                    DataCell(Text(
                                        '${transaction.convertedAmount} ${transaction.convertedCurrency}')),
                                    DataCell(
                                        Text(transaction.receivedCurrency)),
                                    DataCell(Text(transaction.transactionType)),
                                    DataCell(Text(transaction.status)),
                                    DataCell(
                                        Text(formatDate(transaction.createDate))),
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
                ),
    );
  }
}