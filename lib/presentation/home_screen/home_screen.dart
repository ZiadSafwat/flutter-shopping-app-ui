import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_grid_widget.dart';
import './widgets/hero_banner_widget.dart';
import './widgets/product_section_widget.dart';
import './widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final RefreshIndicator _refreshIndicator = RefreshIndicator(
    onRefresh: () async {
      await Future.delayed(const Duration(seconds: 1));
    },
    child: Container(),
  );
  int _currentBottomNavIndex = 0;
  final int _cartItemCount = 3;
  bool _isRefreshing = false;

  // Mock data for recent searches
  final List<String> _recentSearches = [
    'iPhone 15',
    'Nike Air Max',
    'Samsung TV',
    'MacBook Pro'
  ];

  // Mock data for new arrivals
  final List<Map<String, dynamic>> _newArrivals = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": "\$199.99",
      "originalPrice": "\$249.99",
      "image":
          "https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": true,
      "rating": 4.5,
      "reviews": 128
    },
    {
      "id": 2,
      "name": "Smart Watch Series 9",
      "price": "\$399.99",
      "originalPrice": null,
      "image":
          "https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": false,
      "rating": 4.8,
      "reviews": 256
    },
    {
      "id": 3,
      "name": "Bluetooth Speaker",
      "price": "\$89.99",
      "originalPrice": "\$119.99",
      "image":
          "https://images.pexels.com/photos/1649771/pexels-photo-1649771.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": true,
      "rating": 4.3,
      "reviews": 89
    }
  ];

  // Mock data for trending products
  final List<Map<String, dynamic>> _trendingProducts = [
    {
      "id": 4,
      "name": "Gaming Laptop",
      "price": "\$1299.99",
      "originalPrice": null,
      "image":
          "https://images.pexels.com/photos/18105/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": false,
      "rating": 4.7,
      "reviews": 342
    },
    {
      "id": 5,
      "name": "Wireless Mouse",
      "price": "\$49.99",
      "originalPrice": "\$69.99",
      "image":
          "https://images.pexels.com/photos/2115256/pexels-photo-2115256.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": true,
      "rating": 4.4,
      "reviews": 156
    },
    {
      "id": 6,
      "name": "4K Monitor",
      "price": "\$599.99",
      "originalPrice": null,
      "image":
          "https://images.pexels.com/photos/777001/pexels-photo-777001.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": false,
      "rating": 4.6,
      "reviews": 203
    }
  ];

  // Mock data for recommended products
  final List<Map<String, dynamic>> _recommendedProducts = [
    {
      "id": 7,
      "name": "Fitness Tracker",
      "price": "\$129.99",
      "originalPrice": "\$159.99",
      "image":
          "https://images.pexels.com/photos/267394/pexels-photo-267394.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": true,
      "rating": 4.2,
      "reviews": 98
    },
    {
      "id": 8,
      "name": "Tablet Pro",
      "price": "\$799.99",
      "originalPrice": null,
      "image":
          "https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": false,
      "rating": 4.9,
      "reviews": 445
    },
    {
      "id": 9,
      "name": "Wireless Charger",
      "price": "\$39.99",
      "originalPrice": "\$49.99",
      "image":
          "https://images.pexels.com/photos/4219654/pexels-photo-4219654.jpeg?auto=compress&cs=tinysrgb&w=400",
      "isOnSale": true,
      "rating": 4.1,
      "reviews": 67
    }
  ];

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _removeRecentSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Navigator.pushNamed(context, '/product-browse-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/shopping-cart-screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/user-profile-screen');
        break;
    }
  }

  void _onProductTap(Map<String, dynamic> product) {
    Navigator.pushNamed(context, '/product-detail-screen');
  }

  void _onSearchTap() {
    // Navigate to search screen (not implemented in this scope)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search functionality coming soon!')),
    );
  }

  void _onNotificationTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No new notifications')),
    );
  }

  void _onCartTap() {
    Navigator.pushNamed(context, '/shopping-cart-screen');
  }

  void _onScanTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barcode scanner opening...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                toolbarHeight: 12.h,
                flexibleSpace: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    children: [
                      // Header with logo and action icons
                      Row(
                        children: [
                          // Logo
                          Text(
                            'FlutterMart',
                            style: AppTheme.lightTheme.textTheme.headlineSmall
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightTheme.primaryColor,
                            ),
                          ),
                          const Spacer(),
                          // Notification icon
                          GestureDetector(
                            onTap: _onNotificationTap,
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppTheme.lightTheme.dividerColor,
                                ),
                              ),
                              child: CustomIconWidget(
                                iconName: 'notifications_outlined',
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                                size: 6.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          // Cart icon with badge
                          GestureDetector(
                            onTap: _onCartTap,
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppTheme.lightTheme.dividerColor,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'shopping_cart_outlined',
                                    color: AppTheme
                                        .lightTheme.colorScheme.onSurface,
                                    size: 6.w,
                                  ),
                                  if (_cartItemCount > 0)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(1.w),
                                        decoration: BoxDecoration(
                                          color: AppTheme
                                              .lightTheme.colorScheme.error,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 4.w,
                                          minHeight: 4.w,
                                        ),
                                        child: Text(
                                          _cartItemCount.toString(),
                                          style: AppTheme
                                              .lightTheme.textTheme.labelSmall
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 8.sp,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      // Search bar
                      SearchBarWidget(
                        onTap: _onSearchTap,
                        onScanTap: _onScanTap,
                      ),
                    ],
                  ),
                ),
              ),

              // Recent searches (if any)
              if (_recentSearches.isNotEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Searches',
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 1.h),
                        Wrap(
                          spacing: 2.w,
                          runSpacing: 1.h,
                          children: _recentSearches.map((search) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme
                                    .surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    search,
                                    style:
                                        AppTheme.lightTheme.textTheme.bodySmall,
                                  ),
                                  SizedBox(width: 2.w),
                                  GestureDetector(
                                    onTap: () => _removeRecentSearch(search),
                                    child: CustomIconWidget(
                                      iconName: 'close',
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                      size: 4.w,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

              // Hero banner
              SliverToBoxAdapter(
                child: HeroBannerWidget(),
              ),

              // Category grid
              SliverToBoxAdapter(
                child: CategoryGridWidget(),
              ),

              // New Arrivals section
              SliverToBoxAdapter(
                child: ProductSectionWidget(
                  title: 'New Arrivals',
                  products: _newArrivals,
                  onProductTap: _onProductTap,
                ),
              ),

              // Trending section
              SliverToBoxAdapter(
                child: ProductSectionWidget(
                  title: 'Trending Now',
                  products: _trendingProducts,
                  onProductTap: _onProductTap,
                ),
              ),

              // Recommended section
              SliverToBoxAdapter(
                child: ProductSectionWidget(
                  title: 'Recommended for You',
                  products: _recommendedProducts,
                  onProductTap: _onProductTap,
                ),
              ),

              // Bottom spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
        selectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedLabelStyle,
        elevation:
            AppTheme.lightTheme.bottomNavigationBarTheme.elevation ?? 8.0,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: _currentBottomNavIndex == 0 ? 'home' : 'home_outlined',
              color: _currentBottomNavIndex == 0
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 6.w,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName:
                  _currentBottomNavIndex == 1 ? 'search' : 'search_outlined',
              color: _currentBottomNavIndex == 1
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 6.w,
            ),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                CustomIconWidget(
                  iconName: _currentBottomNavIndex == 2
                      ? 'shopping_cart'
                      : 'shopping_cart_outlined',
                  color: _currentBottomNavIndex == 2
                      ? AppTheme.lightTheme.bottomNavigationBarTheme
                          .selectedItemColor!
                      : AppTheme.lightTheme.bottomNavigationBarTheme
                          .unselectedItemColor!,
                  size: 6.w,
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(0.5.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 3.w,
                        minHeight: 3.w,
                      ),
                      child: Text(
                        _cartItemCount.toString(),
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontSize: 7.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName:
                  _currentBottomNavIndex == 3 ? 'person' : 'person_outlined',
              color: _currentBottomNavIndex == 3
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 6.w,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onScanTap,
        backgroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.backgroundColor,
        foregroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor,
        elevation:
            AppTheme.lightTheme.floatingActionButtonTheme.elevation ?? 4.0,
        shape: AppTheme.lightTheme.floatingActionButtonTheme.shape,
        child: CustomIconWidget(
          iconName: 'qr_code_scanner',
          color: Colors.white,
          size: 7.w,
        ),
      ),
    );
  }
}
