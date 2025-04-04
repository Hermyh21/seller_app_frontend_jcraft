import 'package:flutter/material.dart';

class BuyerPage extends StatelessWidget {
  const BuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello!",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.notifications, color: Colors.black),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
// Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search here",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Category Section
            Text("Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryIcon(icon: Icons.chair),
                CategoryIcon(icon: Icons.event_seat),
                CategoryIcon(icon: Icons.event_seat),
                CategoryIcon(icon: Icons.table_chart),
              ],
            ),

            SizedBox(height: 20),
            // Product Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Products",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                // Text("View Less", style: TextStyle(color: Colors.brown)),
              ],
            ),
            SizedBox(height: 10),

            // Filter Buttons
            Row(
              children: [
                FilterButton(label: "All", selected: false),
                FilterButton(label: "Newest", selected: true),
                FilterButton(label: "Popular", selected: false),
              ],
            ),
            SizedBox(height: 20),

            // Product List
            Expanded(
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
                      image: "assets/images/duka.png"),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.euro), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }
}

// Category Icon Widget
class CategoryIcon extends StatelessWidget {
  final IconData icon;
  const CategoryIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.brown.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 30, color: Colors.brown),
    );
  }
}

// Filter Button Widget
class FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  const FilterButton({super.key, required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.brown : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown),
      ),
      child: Text(
        label,
        style: TextStyle(color: selected ? Colors.white : Colors.brown),
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String image;
  const ProductCard(
      {super.key,
      required this.name,
      required this.price,
      required this.rating,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: 60),
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
    );
  }
}
