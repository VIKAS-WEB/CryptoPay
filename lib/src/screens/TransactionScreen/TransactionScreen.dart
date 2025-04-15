import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedTransID = 'TransID';
  String selectedStatus = 'All Status';
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();

  String formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Transactions List',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                /// ✅ PDF ICON
                // IconButton(
                //   onPressed: () {
                //     // Your PDF export logic here
                //   },
                //   icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                // ),

                // /// ✅ EXCEL ICON
                // IconButton(
                //   onPressed: () {
                //     // Your Excel export logic here
                //   },
                //   icon: const Icon(Icons.table_chart, color: Colors.green),
                // ),

                /// 🔍 SEARCH TEXTFIELD
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                });
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),

                const SizedBox(width: 10),

                /// 🔽 TransID Dropdown
                DropdownButton<String>(
                  value: selectedTransID,
                  items: ['TransID'].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),

                const SizedBox(width: 10),

                /// 🔽 Status Dropdown
                DropdownButton<String>(
                  value: selectedStatus,
                  items: ['All Status'].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),

                const SizedBox(width: 10),

                /// 📆 DATE PICKER
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          formatDate(selectedDate),
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'No Transaction Found',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
