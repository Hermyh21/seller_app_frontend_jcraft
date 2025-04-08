import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String image;

  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Buttons
              Stack(
                children: [
                  Image.asset(
                    image,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: PopupMenuButton<String>(
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.more_vert, color: Colors.black),
                      ),
                      onSelected: (value) {
                        // Handle update or delete
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: "update", child: Text("Update Product")),
                        PopupMenuItem(
                            value: "delete", child: Text("Delete Product")),
                      ],
                    ),
                  ),
                ],
              ),

              // Product Details
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name & Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.brown,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        Text(" $rating ", style: TextStyle(fontSize: 16)),
                        Text("(20 Reviews)",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Description
                    Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Culpa aliquam consequuntur veritatis at consequuntur praesentium beatae."
                      " Velit dolorem facilis neque autem. Itaque voluptatem expedita qui eveniet id veritatis eaque.",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 16),

                    // Wood Material
                    Text("Wood Material: Wanza",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    // Size Selection
                    Text("Size", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Row(
                      children: ["S", "M", "L", "XL"].map((size) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(size),
                            selected: size == "S",
                            selectedColor: Color.fromARGB(255, 119, 46, 13),
                            labelStyle: TextStyle(
                              color: size == "S"
                                  ? Colors.white
                                  : Color.fromARGB(255, 119, 46, 13),
                            ),
                            backgroundColor: Colors.transparent,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 119, 46, 13),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),

                    // Color Selection
                    Text("Color",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        const Color.fromARGB(255, 119, 46, 13),
                        const Color.fromARGB(255, 77, 51, 51),
                        const Color.fromARGB(255, 187, 80, 44),
                        Colors.black
                      ]
                          .map((color) => Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  backgroundColor: color,
                                  radius: 15,
                                  child: color == Colors.brown
                                      ? Icon(Icons.check,
                                          color: Colors.white, size: 14)
                                      : null,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
