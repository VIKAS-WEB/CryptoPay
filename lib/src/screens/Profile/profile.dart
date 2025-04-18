import 'package:crypto_pay/src/utils/AuthManager.dart';
import 'package:crypto_pay/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  String? _gender = 'Male';
  DateTime _birthDate = DateTime(1982, 02, 05);
  String _countryCode = '+91';
  String _phoneNumber = '09555555511';
  String _city = 'Delhi';
  String _state = 'Delhi';
  String _country = 'India';
  String _pincode = '110092';
  String _addressLine1 = 'Noida Sec 65';
  String _addressLine2 = 'Delhi - 92';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kthirdColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Profile Page',
          style: TextStyle(
            color: AppColors.kwhite,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: AuthManager.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data;
          final String merchantName =
              userData?['merchantName'] ?? 'Error Display Name';
          final String merchantEmail =
              userData?['merchantEmail'] ?? 'Error Display EMail ID';

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.kthirdColor, Colors.white],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: AppColors.kprimary,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    merchantName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kwhite,
                    ),
                  ),
                  Text(
                    merchantEmail,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.kprimary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: AppColors.kwhite,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Full Name : '),
                              Expanded(
                                child: Text(merchantName),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email : '),
                              Expanded(
                                child: Text(merchantEmail),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone : '),
                              Expanded(
                                child: Text('+91 09555555511'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Birth Date : '),
                              Expanded(
                                child: Text('1982-02-05'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender : '),
                              Expanded(
                                child: Text('M'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address : '),
                              Expanded(
                                child: Text('Noida Sec 65'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.orange,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Edit Profile'),
                        Tab(text: 'Change Password'),
                        Tab(text: 'Security Settings'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:
                        600, // Adjust this height based on your content needs
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    borderRadius: BorderRadius.circular(14)),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey[300],
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.blue[100],
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: _gender,
                                            items: ['Male', 'Female', 'Other']
                                                .map((String value) =>
                                                    DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    ))
                                                .toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _gender = newValue;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Gender *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue:
                                                DateFormat('dd-MM-yyyy')
                                                    .format(_birthDate),
                                            decoration: InputDecoration(
                                              labelText: 'Birth Date *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                              suffixIcon:
                                                  Icon(Icons.calendar_today),
                                            ),
                                            onTap: () async {
                                              DateTime? picked =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: _birthDate,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (picked != null) {
                                                setState(() {
                                                  _birthDate = picked;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _countryCode,
                                            decoration: InputDecoration(
                                              labelText: 'Country Code',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _phoneNumber,
                                            decoration: InputDecoration(
                                              labelText: 'Phone Number *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _city,
                                            decoration: InputDecoration(
                                              labelText: 'City *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _state,
                                            decoration: InputDecoration(
                                              labelText: 'State *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _country,
                                            decoration: InputDecoration(
                                              labelText: 'Country *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _pincode,
                                            decoration: InputDecoration(
                                              labelText: 'Pincode *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _addressLine1,
                                            decoration: InputDecoration(
                                              labelText: 'Address Line 1 *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: TextFormField(
                                            initialValue: _addressLine2,
                                            decoration: InputDecoration(
                                              labelText: 'Address Line 2 *',
                                              labelStyle:
                                                  TextStyle(color: Colors.red),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Save logic here
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.kprimary,
                                        minimumSize: Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Change Password Content',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Security Settings Content',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
