import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CategoryGridWidget extends StatelessWidget {
  const CategoryGridWidget({super.key});

  // Mock category data
  static final List<Map<String, dynamic>> _categories = [
    {
      "id": 1,
      "name": "Electronics",
      "icon": "devices",
      "color": "0xFF2563EB",
      "itemCount": 1250,
    },
    {
      "id": 2,
      "name": "Fashion",
      "icon": "checkroom",
      "color": "0xFFDC2626",
      "itemCount": 890,
    },
    {
      "id": 3,
      "name": "Home & Garden",
      "icon": "home",
      "color": "0xFF059669",
      "itemCount": 567,
    },
    {
      "id": 4,
      "name": "Sports",
      "icon": "sports_soccer",
      "color": "0xFFD97706",
      "itemCount": 423,
    },
    {
      "id": 5,
      "name": "Books",
      "icon": "menu_book",
      "color": "0xFF7C3AED",
      "itemCount": 789,
    },
    {
      "id": 6,
      "name": "Beauty",
      "icon": "face_retouching_natural",
      "color": "0xFFDB2777",
      "itemCount": 345,
    },
  ];

  void _onCategoryTap(BuildContext context, Map<String, dynamic> category) {
    Navigator.pushNamed(context, '/product-browse-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shop by Category',
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
          SizedBox(height: 2.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 0.85,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final categoryColor =
                  Color(int.parse(category["color"] as String));

              return GestureDetector(
                onTap: () => _onCategoryTap(context, category),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.lightTheme.dividerColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.lightTheme.colorScheme.shadow
                            .withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: categoryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: category["icon"] as String,
                            color: categoryColor,
                            size: 6.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        category["name"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '${category["itemCount"]} items',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
