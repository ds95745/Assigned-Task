import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';  // Import the updated provider
import 'product_detail_screen.dart';  // Import the detail screen

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch products when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // Filter products based on the search query
    final filteredProducts = productProvider.products.where((product) {
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;  // Update the search query
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: productProvider.loading
          ? Center(child: CircularProgressIndicator())  // Show loading spinner
          : filteredProducts.isEmpty
          ? Center(child: Text('No products found.'))  // Show message if no products match
          : ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the detail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),  // Card margin
              elevation: 5,  // Shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),  // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),  // Padding inside the card
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    product.thumbnail != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.thumbnail!,
                        width: 100,  // Image width
                        height: 100,  // Image height
                        fit: BoxFit.cover,  // Fit image to box
                      ),
                    )
                        : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.image, size: 50, color: Colors.grey),  // Default icon
                    ),
                    SizedBox(width: 15),  // Space between image and text
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),  // Space between title and description
                          Text(
                            product.description ?? 'No description available',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,  // Limit description lines
                            overflow: TextOverflow.ellipsis,  // Ellipsis for overflow
                          ),
                          SizedBox(height: 5),  // Space between description and price
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',  // Format price
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
