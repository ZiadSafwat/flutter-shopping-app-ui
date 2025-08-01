import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './product_card_widget.dart';

class ProductSectionWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onProductTap;

  const ProductSectionWidget({
    super.key,
    required this.title,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/product-browse-screen');
                  },
                  child: Text(
                    'View All',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          // Horizontal product list
          SizedBox(
            height: 32.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  width: 45.w,
                  margin: EdgeInsets.only(right: 3.w),
                  child: ProductCardWidget(
                    product: product,
                    onTap: () => onProductTap(product),
                    onQuickAdd: () => _onQuickAdd(context, product),
                    onWishlistTap: () => _onWishlistTap(context, product),
                    onShareTap: () => _onShareTap(context, product),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onQuickAdd(BuildContext context, Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product["name"]} added to cart!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onWishlistTap(BuildContext context, Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product["name"]} added to wishlist!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onShareTap(BuildContext context, Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${product["name"]}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
