import 'package:flutter/material.dart';

class EarningsDetailPage extends StatefulWidget {
  const EarningsDetailPage({super.key});

  @override
  State<EarningsDetailPage> createState() => _EarningsDetailPageState();
}

class _EarningsDetailPageState extends State<EarningsDetailPage> {
  String selectedTimeframe = "Week"; // Default selected value

  final List<Map<String, dynamic>> earnings = [
    {
      "item": "Borati",
      "material": "Wanza",
      "color": "Black",
      "size": "M",
      "total": 8933,
    },
    {
      "item": "Barcuma",
      "material": "Wanza",
      "color": "White",
      "size": "XL",
      "total": 11229,
    },
    {
      "item": "Barcuma",
      "material": "Wanza",
      "color": "Brown",
      "size": "XL",
      "quantity": 13,
      "total": 11279,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button & Title
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Earnings Detail",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Total Earnings Dropdown
              Row(
                children: [
                  Text(
                    "Total earnings this ",
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: selectedTimeframe,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTimeframe = newValue!;
                      });
                    },
                    items: ["Day", "Week", "Month", "Year"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Filter Button
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "All",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Earnings List
              Expanded(
                child: ListView.builder(
                  itemCount: earnings.length,
                  itemBuilder: (context, index) {
                    final earning = earnings[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item: ${earning["item"]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Material: ${earning["material"]}"),
                          Text("Color: ${earning["color"]}"),
                          if (earning.containsKey("size"))
                            Text("Size: ${earning["size"]}"),
                          if (earning.containsKey("quantity"))
                            Text("Quantity: ${earning["quantity"]}"),
                          SizedBox(height: 5),
                          Text(
                            "Total: ${earning["total"]} Birr",
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
