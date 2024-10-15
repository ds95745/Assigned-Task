import 'package:flutter/material.dart';
import 'package:untitled/models/product.dart';
  // Import your model class

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display product image
            product.thumbnail != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.thumbnail!,
                width: double.infinity,  // Full width
                height: 250,  // Fixed height for the image
                fit: BoxFit.cover,  // Fit image to box
              ),
            )
                : Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.image, size: 50, color: Colors.grey),  // Default icon
            ),
            SizedBox(height: 16),  // Space below the image
            Text(
              product.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),  // Space below the title
            Text(
              product.description ?? 'No description available',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),  // Space below the description
            Text(
              '\$${product.price.toStringAsFixed(2)}',  // Format price
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
