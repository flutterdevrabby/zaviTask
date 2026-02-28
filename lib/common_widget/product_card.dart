import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/models/product_response.dart';


class ProductCard extends StatelessWidget {
  final ProductModelResponse product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        // ✅ Wrap in SizedBox to give bounded constraints
        leading: SizedBox(
          width: 56.w,
          height: 56.h,
          child: CachedNetworkImage(
            imageUrl: product.image ?? "",
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        ),
        title: Text(
          product.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis, // ✅ prevents text overflow crash too
        ),
        subtitle: Text("\$${product.price?.toStringAsFixed(2) ?? '0.00'}"),
        trailing: Text(
          product.category ?? "",
          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
        ),
      ),
    );
  }
}
