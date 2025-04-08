import 'package:flutter/material.dart';
import 'notification_screen.dart';
import 'product_details_screen.dart';
import 'add_products_screen.dart';

class BuyerPage extends StatelessWidget {
  const BuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Hello!', style: TextStyle(fontSize: 14)),
                      Text('Tamirat Caalaa',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationsPage()),
                          );
                        },
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search here',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Category',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryIcon(Icons.table_bar),
                  _buildCategoryIcon(Icons.chair),
                  _buildCategoryIcon(Icons.stairs),
                  _buildCategoryIcon(Icons.deck),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Your products',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  // Text('View Less', style: TextStyle(color: Colors.brown)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterButton('All'),
                  _buildFilterButton('Newest', selected: true),
                  _buildFilterButton('Popular'),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    ProductCard(
                        name: "Barcuma",
                        price: "140 Birr",
                        rating: 4.5,
                        image: "assets/images/barcuma.png"),
                    ProductCard(
                        name: "Duka",
                        price: "110 Birr",
                        rating: 4.0,
                        image: "assets/images/sofa1.jpg"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    ProductCard(
                        name: "Barcuma",
                        price: "140 Birr",
                        rating: 4.5,
                        image: "assets/images/stools.jpg"),
                    ProductCard(
                        name: "Duka",
                        price: "110 Birr",
                        rating: 4.0,
                        image: "assets/images/sofa2.jpg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.euro), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.brown[100],
        child: Icon(icon, color: Colors.brown),
      ),
    );
  }

  Widget _buildFilterButton(String label, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.brown : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: selected ? Colors.white : Colors.brown,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProductItem(
      String name, String price, double rating, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(imagePath, width: 80, height: 80),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(color: Colors.brown)),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              Text(rating.toString()),
            ],
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String image;
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              name: name,
              price: price,
              rating: rating,
              image: image,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: 130),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(color: Colors.brown)),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16),
                Text(rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
