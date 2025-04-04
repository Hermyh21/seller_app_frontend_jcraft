import 'package:flutter/material.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String selectedCategory = "Chairs";
  final List<String> categories = ["Chairs", "Tables", "Sofas", "Cabinets"];
  String selectedWoodMaterial = "Wanza";
  final List<String> woodMaterials = ["Wanza", "Mahogany", "Oak", "Teak"];

  String selectedSize = "S";
  final List<String> sizes = ["S", "M", "L", "XL"];

  String selectedColor = "brown";
  final List<Color> colors = [
    Colors.brown,
    Colors.white70,
    Colors.brown.shade400,
    Colors.black
  ];

  String selectedHeightUnit = "cm";
  String selectedWidthUnit = "m";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Center(
                  child: Text(
                    "Add Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),

                // Product Name Input
                Text("Product Name"),
                SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: _inputDecoration(),
                ),
                SizedBox(height: 20),

                // Product Description Input
                Text("Product Description"),
                SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: _inputDecoration(),
                ),
                SizedBox(height: 20),

                // Category Dropdown
                Text("Category"),
                SizedBox(height: 8),
                _dropdown(categories, selectedCategory, (value) {
                  setState(() => selectedCategory = value);
                }),
                SizedBox(height: 20),

                // Upload Images Section
                Text("Upload Images"),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text("No Image Selected")),
                ),
                SizedBox(height: 20),

                // Buttons for Taking Photos & Picking from Gallery
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionButton("Take Photo", () {}),
                    SizedBox(width: 20),
                    _actionButton("From Gallery", () {}),
                  ],
                ),
                SizedBox(height: 30),

                // Set Product Specifications
                Text("Set Product Specifications",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                // Size Selection
                Row(
                  children: sizes.map((size) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(size),
                        selected: selectedSize == size,
                        onSelected: (selected) {
                          setState(() => selectedSize = size);
                        },
                        selectedColor: Colors.brown,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                            color: selectedSize == size
                                ? Colors.white
                                : Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Price, Height, Width, Quantity Inputs
                _buildSpecificationRow("Price:", priceController, ""),
                SizedBox(height: 10),
                _buildSpecificationRow("Height:", heightController, "cm"),
                SizedBox(height: 10),
                _buildSpecificationRow("Width:", widthController, "m"),
                SizedBox(height: 10),
                _buildSpecificationRow("Quantity:", quantityController, ""),
                SizedBox(height: 20),

                // Set Button
                Center(child: _actionButton("Set", () {})),
                SizedBox(height: 20),

                // Wood Material Dropdown
                Text("Wood Material"),
                SizedBox(height: 8),
                _dropdown(woodMaterials, selectedWoodMaterial, (value) {
                  setState(() => selectedWoodMaterial = value);
                }),
                SizedBox(height: 20),

                // Color Selection
                Text("Color"),
                SizedBox(height: 8),
                Row(
                  children: colors.map((color) {
                    return GestureDetector(
                      onTap: () =>
                          setState(() => selectedColor = color.toString()),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor == color.toString()
                                ? Colors.brown
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Add Product Button
                Center(child: _actionButton("Add Product", () {})),
                SizedBox(height: 40),
              ],
            ),
          ),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  // Common Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Dropdown Widget
  Widget _dropdown(
      List<String> items, String value, Function(String) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: (newValue) => onChanged(newValue!),
      ),
    );
  }

  // Specification Row Widget
  Widget _buildSpecificationRow(
      String label, TextEditingController controller, String unit) {
    return Row(
      children: [
        Container(width: 80, child: Text(label)),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: _inputDecoration(),
            keyboardType: TextInputType.number,
          ),
        ),
        if (unit.isNotEmpty) SizedBox(width: 10),
        if (unit.isNotEmpty)
          DropdownButton<String>(
            value: unit == "cm" ? selectedHeightUnit : selectedWidthUnit,
            underline: SizedBox(),
            items: ["cm", "m"].map((String unit) {
              return DropdownMenuItem(value: unit, child: Text(unit));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                if (unit == "cm")
                  selectedHeightUnit = newValue!;
                else
                  selectedWidthUnit = newValue!;
              });
            },
          ),
      ],
    );
  }

  // Common Button
  Widget _actionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
