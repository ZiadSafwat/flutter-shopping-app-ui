import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/filter_modal_widget.dart';
import './widgets/product_card_widget.dart';
import './widgets/sort_bottom_sheet_widget.dart';

class ProductBrowseScreen extends StatefulWidget {
  const ProductBrowseScreen({super.key});

  @override
  State<ProductBrowseScreen> createState() => _ProductBrowseScreenState();
}

class _ProductBrowseScreenState extends State<ProductBrowseScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  bool _isLoadingMore = false;
  List<Map<String, dynamic>> _products = [];
  List<String> _activeFilters = [];
  int _filterCount = 0;
  String _sortBy = 'Relevance';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    _loadMockData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    setState(() {
      _isLoading = true;
    });

    // Mock product data
    _products = [
      {
        "id": 1,
        "name": "Premium Cotton T-Shirt",
        "price": 29.99,
        "originalPrice": 39.99,
        "discount": 25,
        "rating": 4.5,
        "reviewCount": 128,
        "image":
            "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?auto=compress&cs=tinysrgb&w=400",
        "isWishlisted": false,
        "brand": "StyleCraft",
        "category": "Clothing",
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Black", "White", "Navy"],
        "inStock": true,
      },
      {
        "id": 2,
        "name": "Wireless Bluetooth Headphones",
        "price": 89.99,
        "originalPrice": 129.99,
        "discount": 31,
        "rating": 4.8,
        "reviewCount": 256,
        "image":
            "https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?auto=compress&cs=tinysrgb&w=400",
        "isWishlisted": true,
        "brand": "AudioTech",
        "category": "Electronics",
        "sizes": [],
        "colors": ["Black", "Silver"],
        "inStock": true,
      },
      {
        "id": 3,
        "name": "Leather Crossbody Bag",
        "price": 79.99,
        "originalPrice": 99.99,
        "discount": 20,
        "rating": 4.3,
        "reviewCount": 89,
        "image":
            "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=400",
        "isWishlisted": false,
        "brand": "LeatherCraft",
        "category": "Accessories",
        "sizes": [],
        "colors": ["Brown", "Black", "Tan"],
        "inStock": true,
      },
      {
        "id": 4,
        "name": "Smart Fitness Watch",
        "price": 199.99,
        "originalPrice": 249.99,
        "discount": 20,
        "rating": 4.6,
        "reviewCount": 342,
        "image":
            "https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=400",
        "isWishlisted": false,
        "brand": "FitTech",
        "category": "Electronics",
        "sizes": [],
        "colors": ["Black", "Silver", "Rose Gold"],
        "inStock": true,
      },
      {
        "id": 5,
        "name": "Organic Face Moisturizer",
        "price": 24.99,
        "originalPrice": 34.99,
        "discount": 29,
        "rating": 4.4,
        "reviewCount": 167,
        "image":
            "https://images.pexels.com/photos/3685530/pexels-photo-3685530.jpeg?auto=compress&cs=tinysrgb&w=400",
        "isWishlisted": true,
        "brand": "NatureCare",
        "category": "Beauty",
        "sizes": [],
        "colors": [],
        "inStock": true,
      },
      {
        "id": 6,
        "name": "Running Sneakers",
        "price": 119.99,
        "originalPrice": 159.99,
        "discount": 25,
        "rating": 4.7,
        "reviewCount": 203,
        "image":
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=400",
        "isWishlisted": false,
        "brand": "SportMax",
        "category": "Footwear",
        "sizes": ["7", "8", "9", "10", "11"],
        "colors": ["White", "Black", "Blue"],
        "inStock": true,
      },
    ];

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    setState(() {
      _isLoadingMore = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    _loadMockData();
  }

  void _toggleWishlist(int productId) {
    setState(() {
      final productIndex = _products.indexWhere((p) => p['id'] == productId);
      if (productIndex != -1) {
        _products[productIndex]['isWishlisted'] =
            !(_products[productIndex]['isWishlisted'] as bool);
      }
    });
  }

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
      _filterCount = _activeFilters.length;
    });
  }

  void _clearAllFilters() {
    setState(() {
      _activeFilters.clear();
      _filterCount = 0;
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterModalWidget(
        activeFilters: _activeFilters,
        onFiltersChanged: (filters) {
          setState(() {
            _activeFilters = filters;
            _filterCount = filters.length;
          });
        },
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SortBottomSheetWidget(
        currentSort: _sortBy,
        onSortChanged: (sort) {
          setState(() {
            _sortBy = sort;
          });
        },
      ),
    );
  }

  void _onProductTap(Map<String, dynamic> product) {
    Navigator.pushNamed(context, '/product-detail-screen');
  }

  void _showProductContextMenu(Map<String, dynamic> product, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 1,
        position.dy + 1,
      ),
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'favorite_border',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text('Add to Wishlist'),
            ],
          ),
          onTap: () => _toggleWishlist(product['id'] as int),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text('Share'),
            ],
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'search',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text('View Similar'),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search and filter
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.shadow
                        .withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Search bar with filter button
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: AppTheme
                                .lightTheme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(3.w),
                                child: CustomIconWidget(
                                  iconName: 'search',
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 2.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      // Filter button with badge
                      Stack(
                        children: [
                          Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: _showFilterModal,
                              icon: CustomIconWidget(
                                iconName: 'tune',
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          _filterCount > 0
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(
                                      color:
                                          AppTheme.lightTheme.colorScheme.error,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 5.w,
                                      minHeight: 5.w,
                                    ),
                                    child: Text(
                                      _filterCount.toString(),
                                      style: AppTheme
                                          .lightTheme.textTheme.labelSmall
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),

                  // Tab bar
                  SizedBox(height: 2.h),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: const [
                      Tab(text: 'Home'),
                      Tab(text: 'Browse'),
                      Tab(text: 'Cart'),
                      Tab(text: 'Wishlist'),
                      Tab(text: 'Profile'),
                    ],
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          Navigator.pushNamed(context, '/home-screen');
                          break;
                        case 2:
                          Navigator.pushNamed(context, '/shopping-cart-screen');
                          break;
                        case 3:
                          // Navigate to wishlist
                          break;
                        case 4:
                          Navigator.pushNamed(context, '/user-profile-screen');
                          break;
                      }
                    },
                  ),
                ],
              ),
            ),

            // Active filters chips
            _activeFilters.isNotEmpty
                ? Container(
                    height: 6.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _activeFilters.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 2.w),
                            itemBuilder: (context, index) {
                              return FilterChipWidget(
                                label: _activeFilters[index],
                                onRemove: () =>
                                    _removeFilter(_activeFilters[index]),
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: _clearAllFilters,
                          child: Text(
                            'Clear All',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),

            // Products grid
            Expanded(
              child: _isLoading
                  ? _buildSkeletonGrid()
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: _products.isEmpty
                          ? _buildEmptyState()
                          : GridView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.all(4.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.w,
                                mainAxisSpacing: 4.w,
                                childAspectRatio: 0.75,
                              ),
                              itemCount:
                                  _products.length + (_isLoadingMore ? 2 : 0),
                              itemBuilder: (context, index) {
                                if (index >= _products.length) {
                                  return _buildSkeletonCard();
                                }

                                final product = _products[index];
                                return ProductCardWidget(
                                  product: product,
                                  onTap: () => _onProductTap(product),
                                  onLongPress: (position) =>
                                      _showProductContextMenu(
                                          product, position),
                                  onWishlistTap: () =>
                                      _toggleWishlist(product['id'] as int),
                                );
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),

      // Floating sort button
      floatingActionButton: FloatingActionButton(
        onPressed: _showSortBottomSheet,
        child: CustomIconWidget(
          iconName: 'sort',
          color: Colors.white,
          size: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title skeleton
                Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color:
                        AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 1.h),
                // Price skeleton
                Container(
                  height: 1.5.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color:
                        AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'No products found',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your filters or search terms',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: _clearAllFilters,
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}