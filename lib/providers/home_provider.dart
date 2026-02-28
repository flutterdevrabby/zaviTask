import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zavisoft_task/constants/endpoint.dart';
import '../features/models/product_response.dart';

/// HomeProvider — manages product data and loading state.
///
/// Responsibilities:
///   1. Fetch all products from FakeStore API on startup
///   2. Filter products by tab/category on demand
///   3. Expose loading + error state to the UI
class HomeProvider extends ChangeNotifier {
  // ─── State ───────────────────────────────────────────────
  final List<ProductModelResponse> _productList = [];
  bool isLoading = false;
  String? errorMessage;

  // ─── Getters ─────────────────────────────────────────────
  List<ProductModelResponse> get productList => _productList;

  // ─── Constructor ─────────────────────────────────────────
  HomeProvider() {
    // addPostFrameCallback ensures notifyListeners() is never
    // called during the very first widget build pass.
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchProducts());
  }

  // ─── Category Filter ─────────────────────────────────────
  /// Maps the UI tab label → FakeStore API category string,
  /// then returns only matching products.
  ///
  /// FakeStore categories:
  ///   "jewelery" | "men's clothing" | "women's clothing" | "electronics"
  List<ProductModelResponse> getProductsByCategory(String tabLabel) {
    const categoryMap = {
      'Jewelery': 'jewelery',
      'Mens Cloth': "men's clothing",
      'Electronics': 'electronics',
    };

    final apiCategory = categoryMap[tabLabel];

    // If tab label isn't in the map, return everything (safe fallback).
    if (apiCategory == null) return List.unmodifiable(_productList);

    return _productList
        .where((product) => product.category == apiCategory)
        .toList();
  }

  // ─── API Call ─────────────────────────────────────────────
  /// Fetches all products from the API.
  /// Called on init and on pull-to-refresh.
  Future<void> fetchProducts() async {
    // Show loading spinner
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await Dio().get('$baseUrl/products');

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data;

        // Clear first to prevent duplicates on refresh
        _productList.clear();
        _productList.addAll(
          rawData.map((item) => ProductModelResponse.fromJson(item)).toList(),
        );
      }
    } catch (e) {
      errorMessage = 'Failed to load products. Please try again.';
      log('fetchProducts error: $e');
    } finally {
      // Always hide loading, whether success or failure
      isLoading = false;
      notifyListeners();
    }
  }
}
