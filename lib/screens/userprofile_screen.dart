import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),

            // Profile Image, Name, and Email
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            "assets/images/profile.jpg"), // Replace with network image if needed
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.camera_alt,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lina Windley",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "linadop@gmail.com",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Profile Options List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildProfileOption(Icons.person, "Profile", context),
                  _buildProfileOption(
                      Icons.credit_card, "Payment Methods", context),
                  _buildProfileOption(
                      Icons.help_outline, "Help Center", context),
                  _buildProfileOption(Icons.settings, "Settings", context),
                  SizedBox(height: 10),
                  _buildProfileOption(Icons.share, "Share App", context),
                  _buildProfileOption(Icons.logout, "Sign Out", context,
                      isLogout: true),
                ],
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, BuildContext context,
      {bool isLogout = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.brown),
        title: Text(title,
            style: TextStyle(
                fontSize: 16, color: isLogout ? Colors.red : Colors.black)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: () {
          if (isLogout) {
            // Add Sign Out Logic
          } else {
            // Navigate to respective screen
          }
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.home, color: Colors.white), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.add_box, color: Colors.white), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.attach_money, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.person, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }
}
