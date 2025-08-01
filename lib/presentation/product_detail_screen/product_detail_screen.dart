import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_action_bar_widget.dart';
import './widgets/expandable_section_widget.dart';
import './widgets/product_image_carousel_widget.dart';
import './widgets/product_info_widget.dart';
import './widgets/product_options_widget.dart';
import './widgets/related_products_widget.dart';
import './widgets/reviews_section_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isWishlisted = false;
  int selectedQuantity = 1;
  String selectedSize = 'M';
  String selectedColor = 'Blue';

  // Mock product data
  final Map<String, dynamic> productData = {
    "id": 1,
    "name": "Premium Cotton T-Shirt",
    "description":
        "Experience ultimate comfort with our premium cotton t-shirt. Made from 100% organic cotton, this versatile piece features a classic fit that's perfect for any occasion. The breathable fabric ensures all-day comfort while maintaining its shape wash after wash.",
    "price": 29.99,
    "originalPrice": 39.99,
    "currency": "\$",
    "rating": 4.5,
    "reviewCount": 128,
    "availability": "In Stock",
    "images": [
      "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500&h=500&fit=crop",
      "https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=500&h=500&fit=crop",
      "https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=500&h=500&fit=crop"
    ],
    "sizes": ["XS", "S", "M", "L", "XL"],
    "colors": ["Blue", "Black", "White", "Gray"],
    "specifications": {
      "Material": "100% Organic Cotton",
      "Care": "Machine wash cold",
      "Origin": "Made in USA",
      "Fit": "Regular fit"
    },
    "shippingInfo":
        "Free shipping on orders over \$50. Standard delivery 3-5 business days.",
    "reviews": [
      {
        "id": 1,
        "userName": "Sarah Johnson",
        "rating": 5,
        "comment": "Amazing quality! The fabric is so soft and comfortable.",
        "date": "2024-01-15"
      },
      {
        "id": 2,
        "userName": "Mike Chen",
        "rating": 4,
        "comment": "Great fit and color. Highly recommend!",
        "date": "2024-01-10"
      }
    ]
  };

  final List<Map<String, dynamic>> relatedProducts = [
    {
      "id": 2,
      "name": "Classic Polo Shirt",
      "price": 34.99,
      "currency": "\$",
      "rating": 4.3,
      "image":
          "https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=300&h=300&fit=crop"
    },
    {
      "id": 3,
      "name": "Casual Hoodie",
      "price": 49.99,
      "currency": "\$",
      "rating": 4.7,
      "image":
          "https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=300&h=300&fit=crop"
    },
    {
      "id": 4,
      "name": "Denim Jacket",
      "price": 79.99,
      "currency": "\$",
      "rating": 4.4,
      "image":
          "https://images.unsplash.com/photo-1544966503-7cc5ac882d5f?w=300&h=300&fit=crop"
    }
  ];

  void _toggleWishlist() {
    HapticFeedback.lightImpact();
    setState(() {
      isWishlisted = !isWishlisted;
    });
  }

  void _shareProduct() {
    HapticFeedback.selectionClick();
    // Share functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality would open here')),
    );
  }

  void _addToCart() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${productData["name"]} to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () =>
              Navigator.pushNamed(context, '/shopping-cart-screen'),
        ),
      ),
    );
  }

  void _buyNow() {
    HapticFeedback.heavyImpact();
    Navigator.pushNamed(context, '/shopping-cart-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 60.h,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface
                    .withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface
                      .withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: _shareProduct,
                  icon: CustomIconWidget(
                    iconName: 'share',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 4.w, top: 2.w, bottom: 2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface
                      .withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: _toggleWishlist,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: CustomIconWidget(
                      key: ValueKey(isWishlisted),
                      iconName: isWishlisted ? 'favorite' : 'favorite_border',
                      color: isWishlisted
                          ? Colors.red
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ProductImageCarouselWidget(
                images: (productData["images"] as List).cast<String>(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  ProductInfoWidget(
                    name: productData["name"] as String,
                    price: productData["price"] as double,
                    originalPrice: productData["originalPrice"] as double,
                    currency: productData["currency"] as String,
                    rating: productData["rating"] as double,
                    reviewCount: productData["reviewCount"] as int,
                    availability: productData["availability"] as String,
                  ),
                  SizedBox(height: 3.h),
                  ProductOptionsWidget(
                    sizes: (productData["sizes"] as List).cast<String>(),
                    colors: (productData["colors"] as List).cast<String>(),
                    selectedSize: selectedSize,
                    selectedColor: selectedColor,
                    quantity: selectedQuantity,
                    onSizeChanged: (size) {
                      HapticFeedback.selectionClick();
                      setState(() => selectedSize = size);
                    },
                    onColorChanged: (color) {
                      HapticFeedback.selectionClick();
                      setState(() => selectedColor = color);
                    },
                    onQuantityChanged: (quantity) {
                      HapticFeedback.selectionClick();
                      setState(() => selectedQuantity = quantity);
                    },
                  ),
                  SizedBox(height: 3.h),
                  ExpandableSectionWidget(
                    title: 'Description',
                    content: productData["description"] as String,
                    isExpanded: true,
                  ),
                  ExpandableSectionWidget(
                    title: 'Specifications',
                    content:
                        (productData["specifications"] as Map<String, dynamic>)
                            .entries
                            .map((e) => '${e.key}: ${e.value}')
                            .join('\n'),
                  ),
                  ExpandableSectionWidget(
                    title: 'Shipping Info',
                    content: productData["shippingInfo"] as String,
                  ),
                  SizedBox(height: 2.h),
                  ReviewsSectionWidget(
                    rating: productData["rating"] as double,
                    reviewCount: productData["reviewCount"] as int,
                    reviews: (productData["reviews"] as List)
                        .cast<Map<String, dynamic>>(),
                  ),
                  SizedBox(height: 3.h),
                  RelatedProductsWidget(
                    products: relatedProducts,
                  ),
                  SizedBox(height: 12.h), // Space for bottom action bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActionBarWidget(
        onAddToCart: _addToCart,
        onBuyNow: _buyNow,
        price: productData["price"] as double,
        currency: productData["currency"] as String,
      ),
    );
  }
}
