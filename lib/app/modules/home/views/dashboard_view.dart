// dashboard_view.dart
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final List<NFTProduct> products = [
    NFTProduct(
      imageUrl: 'assets/1.jpg',
      name: 'CryptoPunk #123',
      price: '10 ETH',
      quantity: '5 available',
    ),
    NFTProduct(
      imageUrl: 'assets/2.png',
      name: 'Bored Ape #456',
      price: '15 ETH',
      quantity: '3 available',
    ),
    NFTProduct(
      imageUrl: 'assets/3.png',
      name: 'Doodle #789',
      price: '8 ETH',
      quantity: '10 available',
    ),
    NFTProduct(
      imageUrl: 'assets/4.jpg',
      name: 'Meebit #321',
      price: '5 ETH',
      quantity: '12 available',
    ),
    NFTProduct(
      imageUrl: 'assets/5.png',
      name: 'Pudgy Penguin #654',
      price: '20 ETH',
      quantity: '2 available',
    ),
    NFTProduct(
      imageUrl: 'assets/6.png',
      name: 'Cool Cat #777',
      price: '12 ETH',
      quantity: '7 available',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f7fa),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return NFTCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

class NFTProduct {
  final String imageUrl;
  final String name;
  final String price;
  final String quantity;

  NFTProduct({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class NFTCard extends StatelessWidget {
  final NFTProduct product;

  NFTCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      shadowColor: Colors.black45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFe1eec3), Color(0xFFf05053)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                      image: DecorationImage(
                        image: AssetImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black45,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        product.quantity,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Logika untuk bid produk
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF007BFF)),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: Text(
                            'Bid Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
