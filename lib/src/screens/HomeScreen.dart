import 'package:crypto_pay/src/screens/DashboardScreen.dart';
import 'package:crypto_pay/src/screens/TransactionScreen/TransactionScreen.dart';
import 'package:crypto_pay/src/screens/paylinks/plink.dart';
import 'package:crypto_pay/src/screens/payrequest/PayRequestScreen.dart';
import 'package:crypto_pay/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _drawerIndex = 0;
  int _bottomNavIndex = 0;

  // Pages for Drawer navigation
  final List<Widget> _drawerPages = [
    const DashboardScreen(), // Index 0
    PayLinksScreen(),       // Index 1
    const PayRequestScreen(), // Index 2
    const WithdrawPage(),    // Index 3
     TransactionsScreen(), // Index 4
  ];

  // Pages for Bottom Navigation
  final List<Widget> _bottomNavPages = [
    const DashboardScreen(), // Index 0 (Home)
    const SearchPage(),      // Index 1
    const ProfilePage(),     // Index 2
    const NotificationsPage(), // Index 3
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _drawerIndex = index;
      // Reset bottom nav to Home when Drawer item is selected
      _bottomNavIndex = 0;
    });
    Navigator.pop(context); // Close the Drawer
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display Drawer pages when Drawer is active, else Bottom Nav pages
    Widget currentPage = _bottomNavIndex == 0 && _drawerIndex != 0
        ? _drawerPages[_drawerIndex]
        : _bottomNavPages[_bottomNavIndex];

    return Scaffold(
      backgroundColor: AppColors.kbackground,
      appBar: AppBar(
        backgroundColor: AppColors.kprimary,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(Icons.menu, color: AppColors.kwhite, size: 32),
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.notifications, color: AppColors.kwhite),
                SizedBox(width: 30),
                Icon(Icons.person, color: AppColors.kwhite),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.kwhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 0),
                  Image.asset(
                    'assets/images/logo1.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            // Drawer Items
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              index: 0,
              onTap: _onDrawerItemTapped,
            ),
            _buildDrawerItem(
              icon: Icons.link,
              title: 'Pay Links',
              index: 1,
              onTap: _onDrawerItemTapped,
            ),
            _buildDrawerItem(
              icon: Icons.request_page,
              title: 'Pay Request',
              index: 2,
              onTap: _onDrawerItemTapped,
            ),
            _buildDrawerItem(
              icon: Icons.wallet,
              title: 'Withdraw',
              index: 3,
              onTap: _onDrawerItemTapped,
            ),
            _buildDrawerItem(
              icon: Icons.receipt,
              title: 'Transactions',
              index: 4,
              onTap: _onDrawerItemTapped,
            ),
          ],
        ),
      ),
      body: currentPage,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.search,
          Icons.person,
          Icons.notifications,
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: _onBottomNavTapped,
        activeColor: AppColors.kprimary,
        inactiveColor: Colors.grey,
        splashColor: AppColors.ksecondary,
        elevation: 8,
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
    required Function(int) onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: _drawerIndex == index ? AppColors.kwhite : Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: _drawerIndex == index ? AppColors.kwhite : Colors.grey,
          ),
        ),
        tileColor: _drawerIndex == index ? AppColors.kprimary : null,
        selectedTileColor: AppColors.kprimary,
        onTap: () => onTap(index),
      ),
    );
  }
}

// Placeholder Pages (unchanged)
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Page', style: TextStyle(fontSize: 24)));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24)));
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications Page', style: TextStyle(fontSize: 24)));
  }
}

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Withdraw Page', style: TextStyle(fontSize: 24)));
  }
}

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Transactions Page', style: TextStyle(fontSize: 24)));
  }
}