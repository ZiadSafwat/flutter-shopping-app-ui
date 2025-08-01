import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterModalWidget extends StatefulWidget {
  final List<String> activeFilters;
  final Function(List<String>) onFiltersChanged;

  const FilterModalWidget({
    super.key,
    required this.activeFilters,
    required this.onFiltersChanged,
  });

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  late List<String> _selectedFilters;
  RangeValues _priceRange = const RangeValues(0, 500);
  double _minRating = 0;

  final Map<String, List<String>> _filterOptions = {
    'Category': [
      'Clothing',
      'Electronics',
      'Accessories',
      'Beauty',
      'Footwear',
      'Home & Garden'
    ],
    'Brand': [
      'StyleCraft',
      'AudioTech',
      'LeatherCraft',
      'FitTech',
      'NatureCare',
      'SportMax'
    ],
    'Size': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    'Color': [
      'Black',
      'White',
      'Blue',
      'Red',
      'Green',
      'Brown',
      'Gray',
      'Navy'
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedFilters = List.from(widget.activeFilters);
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  void _clearAllFilters() {
    setState(() {
      _selectedFilters.clear();
      _priceRange = const RangeValues(0, 500);
      _minRating = 0;
    });
  }

  void _applyFilters() {
    final List<String> allFilters = List.from(_selectedFilters);

    // Add price range filter
    if (_priceRange.start > 0 || _priceRange.end < 500) {
      allFilters.add(
          'Price: \$${_priceRange.start.round()}-\$${_priceRange.end.round()}');
    }

    // Add rating filter
    if (_minRating > 0) {
      allFilters.add('Rating: ${_minRating.toStringAsFixed(1)}+ stars');
    }

    widget.onFiltersChanged(allFilters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Text(
                    'Clear All',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price range
                  _buildPriceRangeSection(),

                  SizedBox(height: 3.h),

                  // Rating filter
                  _buildRatingSection(),

                  SizedBox(height: 3.h),

                  // Category filters
                  ..._filterOptions.entries.map(
                      (entry) => _buildFilterSection(entry.key, entry.value)),
                ],
              ),
            ),
          ),

          // Apply button
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text('Apply Filters (${_selectedFilters.length})'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 500,
          divisions: 50,
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${_priceRange.start.round()}',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            Text(
              '\$${_priceRange.end.round()}',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Slider(
          value: _minRating,
          min: 0,
          max: 5,
          divisions: 10,
          label: _minRating > 0
              ? '${_minRating.toStringAsFixed(1)} stars'
              : 'Any rating',
          onChanged: (value) {
            setState(() {
              _minRating = value;
            });
          },
        ),
        Row(
          children: [
            ...List.generate(5, (index) {
              return CustomIconWidget(
                iconName: index < _minRating.floor() ? 'star' : 'star_border',
                color: index < _minRating.floor()
                    ? Colors.amber
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              );
            }),
            SizedBox(width: 2.w),
            Text(
              _minRating > 0
                  ? '${_minRating.toStringAsFixed(1)} & up'
                  : 'Any rating',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            final isSelected = _selectedFilters.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) => _toggleFilter(option),
              selectedColor: AppTheme.lightTheme.colorScheme.primaryContainer,
              checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
              labelStyle: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.onPrimaryContainer
                    : AppTheme.lightTheme.colorScheme.onSurface,
              ),
              side: BorderSide(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}
