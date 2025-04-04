import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Text("Notifications",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "2 NEW",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TODAY", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Mark as all read",
                    style: TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  NotificationTile(
                    icon: Icons.receipt_long,
                    title: "New order",
                    time: "1h",
                    message:
                        "Culpa aliquam consequuntur veritatis at consectetur praesentium beatae temporibus nobis.",
                  ),
                  NotificationTile(
                    icon: Icons.receipt_long,
                    title: "New order",
                    time: "1h",
                    message:
                        "Culpa aliquam consequuntur veritatis at consectetur praesentium beatae temporibus nobis.",
                  ),
                  NotificationTile(
                    icon: Icons.attach_money,
                    title: "Payment Received",
                    time: "3h",
                    message:
                        "Culpa aliquam consequuntur veritatis at consectetur praesentium beatae temporibus nobis.",
                  ),
                  SizedBox(height: 20),
                  Text("YESTERDAY",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  NotificationTile(
                    icon: Icons.receipt_long,
                    title: "Order Request",
                    time: "1d",
                    message:
                        "Culpa aliquam consequuntur veritatis at consectetur praesentium beatae temporibus nobis.",
                  ),
                  NotificationTile(
                    icon: Icons.attach_money,
                    title: "Payment Received",
                    time: "1d",
                    message:
                        "Culpa aliquam consequuntur veritatis at consectetur praesentium beatae temporibus nobis.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String message;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 5),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.brown.shade100,
            child: Icon(icon, color: Colors.brown, size: 28),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(time,
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
