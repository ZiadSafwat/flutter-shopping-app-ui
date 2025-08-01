import 'package:flutter/material.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';
import '../presentation/product_browse_screen/product_browse_screen.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/shopping_cart_screen/shopping_cart_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String loginScreen = '/login-screen';
  static const String userProfileScreen = '/user-profile-screen';
  static const String productBrowseScreen = '/product-browse-screen';
  static const String productDetailScreen = '/product-detail-screen';
  static const String homeScreen = '/home-screen';
  static const String shoppingCartScreen = '/shopping-cart-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => HomeScreen(),
    loginScreen: (context) => LoginScreen(),
    userProfileScreen: (context) => UserProfileScreen(),
    productBrowseScreen: (context) => ProductBrowseScreen(),
    productDetailScreen: (context) => ProductDetailScreen(),
    homeScreen: (context) => HomeScreen(),
    shoppingCartScreen: (context) => ShoppingCartScreen(),
    // TODO: Add your other routes here
  };
}
