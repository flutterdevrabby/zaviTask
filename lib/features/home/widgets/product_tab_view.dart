import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zavisoft_task/providers/home_provider.dart';

import '../../../common_widget/product_card.dart';

class ProductTabView extends StatefulWidget {
  final String tab;

  const ProductTabView({super.key, required this.tab});

  @override
  State<ProductTabView> createState() => _ProductTabViewState();
}

class _ProductTabViewState extends State<ProductTabView>
    with AutomaticKeepAliveClientMixin {
  // wantKeepAlive = true মানে tab switch করলে widget destroy হবে না
  // তাই scroll position যেখানে ছিল সেখানেই থাকবে
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // KeepAlive এর জন্য required

    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        // Loading state
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 12),
                Text(provider.errorMessage!),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: provider.fetchProducts,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final tabProducts = provider.getProductsByCategory(widget.tab);

        // Empty state
        if (tabProducts.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        // Product list
        return RefreshIndicator(
          onRefresh: provider.fetchProducts,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            key: PageStorageKey(widget.tab), // scroll position save করে
            physics: const ClampingScrollPhysics(),
            itemCount: tabProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(product: tabProducts[index]);
            },
          ),
        );
      },
    );
  }
}
